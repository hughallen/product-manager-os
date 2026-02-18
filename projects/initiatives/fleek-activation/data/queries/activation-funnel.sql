-- ACTIVATION FUNNEL: Registration → Onboarding → Activity → Orders
--
-- Tracks the end-to-end user journey for registered users (Sep–Nov 2025 cohort).
-- Each step is measured independently against the total registration base.
--
-- RESULTS (as of last run):
--
-- Step                                    Unique Users   % of Reg   Mean Count   Median Count   Median Time from Reg
-- ---------------------------------------------------------------------------------------------------------------------
-- Registered (All, Sep–Nov 2025)           78,796        100%        —            —              —
-- Started onboarding                       40,556         51.5%      1.1          1              0d 0h 0m
-- Completed furthest onboarding step       30,647         38.9%      1.0          1              0d 0h 2m
-- Viewed homescreen                        78,493         99.6%      15.2         4              0d 0h 0m
-- Viewed products                          70,732         89.8%      50.2         12             0d 0h 2m
-- Viewed collections                       63,918         81.1%      8.2          4              0d 0h 2m
-- Viewed supplier page                      1,273          1.6%      11.5         4              0d 0h 8m
-- Searched                                 53,742         68.2%      8.9          4              0d 0h 4m
-- Placed 1st order                          7,538          9.6%      1.9          1              2d 7h 5m
-- Placed 2nd order                          2,358          3.0%      3.9          3              29d 20h 24m
-- Placed 3rd order                          1,203          1.5%      5.8          4              42d 5h 4m
-- Placed 4th order                            728          0.9%      7.6          5              48d 1h 49m
-- Placed 5th order                            515          0.7%      9.0          7              54d 23h 12m
-- Placed 6+ orders                            365          0.5%     10.7          8              60d 12h 33m
--
-- METHODOLOGY NOTES:
-- - Cohort: all registrations between 2025-09-02 and 2025-11-30 (inclusive)
-- - Registrations deduped to one row per anonymous_id using MIN(registration_timestamp)
-- - Only events AFTER registration_timestamp are counted
-- - "Started onboarding": first STARTED flow_status event per user
-- - "Completed furthest onboarding step": MAX(onboarding_submitted_timestamp) per user
--     for any non-STARTED flow_status event; count = 1 per user (furthest step reached)
-- - Activity steps (homescreen, products, etc.) count all events post-registration
-- - Order milestones (1st–5th, 6+): each row = users who reached at least that order number
--     Mean/median count = total orders placed by users in that cohort (not just N)
--     Median time = time from registration to that specific Nth order
-- - Orders joined via customer_id: REGEXP_EXTRACT(user_id, r'Customer/(\d+)')
-- - Supplier page views are web-only (no app tracking equivalent)
-- - Median time uses APPROX_QUANTILES(secs, 2)[OFFSET(1)] to avoid mean skew from outliers

WITH
registrations AS (
  SELECT DISTINCT anonymous_id,
    MIN(registration_timestamp) AS registration_timestamp,
    MIN(CAST(REGEXP_EXTRACT(user_id, r'Customer/(\d+)') AS INT64)) AS customer_id
  FROM `data-project-487408.dogwood.registrations`
  WHERE registration_timestamp >= '2025-09-02'
    AND registration_timestamp < '2025-12-01'
  GROUP BY anonymous_id
),
total_reg AS (SELECT COUNT(*) AS n FROM registrations),

onboarding_started AS (
  SELECT ob.anonymous_id,
    COUNT(*) AS cnt,
    MIN(TIMESTAMP_DIFF(ob.onboarding_submitted_timestamp, r.registration_timestamp, SECOND)) AS secs
  FROM `data-project-487408.dogwood.onboarding_submitted` ob
  JOIN registrations r ON ob.anonymous_id = r.anonymous_id
  WHERE ob.flow_status = 'STARTED'
    AND ob.onboarding_submitted_timestamp >= r.registration_timestamp
  GROUP BY ob.anonymous_id
),

-- Last (furthest) onboarding step per user: count = 1, time = MAX submission timestamp
onboarding_furthest_step AS (
  SELECT ob.anonymous_id,
    1 AS cnt,
    TIMESTAMP_DIFF(MAX(ob.onboarding_submitted_timestamp), r.registration_timestamp, SECOND) AS secs
  FROM `data-project-487408.dogwood.onboarding_submitted` ob
  JOIN registrations r ON ob.anonymous_id = r.anonymous_id
  WHERE ob.flow_status != 'STARTED'
    AND ob.onboarding_submitted_timestamp >= r.registration_timestamp
  GROUP BY ob.anonymous_id, r.registration_timestamp
),

homescreen AS (
  SELECT t.anonymous_id, COUNT(*) AS cnt,
    MIN(TIMESTAMP_DIFF(t.view_timestamp, r.registration_timestamp, SECOND)) AS secs
  FROM `data-project-487408.dogwood.homescreen_views` t
  JOIN registrations r ON t.anonymous_id = r.anonymous_id
  WHERE t.view_timestamp >= r.registration_timestamp
  GROUP BY t.anonymous_id
),

product_views AS (
  SELECT t.anonymous_id, COUNT(*) AS cnt,
    MIN(TIMESTAMP_DIFF(t.view_timestamp, r.registration_timestamp, SECOND)) AS secs
  FROM `data-project-487408.dogwood.product_views` t
  JOIN registrations r ON t.anonymous_id = r.anonymous_id
  WHERE t.view_timestamp >= r.registration_timestamp
  GROUP BY t.anonymous_id
),

collection_views AS (
  SELECT t.anonymous_id, COUNT(*) AS cnt,
    MIN(TIMESTAMP_DIFF(t.view_timestamp, r.registration_timestamp, SECOND)) AS secs
  FROM `data-project-487408.dogwood.collection_views` t
  JOIN registrations r ON t.anonymous_id = r.anonymous_id
  WHERE t.view_timestamp >= r.registration_timestamp
  GROUP BY t.anonymous_id
),

supplier_views AS (
  SELECT t.anonymous_id, COUNT(*) AS cnt,
    MIN(TIMESTAMP_DIFF(t.view_timestamp, r.registration_timestamp, SECOND)) AS secs
  FROM `data-project-487408.dogwood.vendor_page_views` t
  JOIN registrations r ON t.anonymous_id = r.anonymous_id
  WHERE t.view_timestamp >= r.registration_timestamp
  GROUP BY t.anonymous_id
),

searches AS (
  SELECT t.anonymous_id, COUNT(*) AS cnt,
    MIN(TIMESTAMP_DIFF(t.search_timestamp, r.registration_timestamp, SECOND)) AS secs
  FROM `data-project-487408.dogwood.searches` t
  JOIN registrations r ON t.anonymous_id = r.anonymous_id
  WHERE t.search_timestamp >= r.registration_timestamp
  GROUP BY t.anonymous_id
),

-- Per-user order stats: total orders + time to each Nth order (up to 6th)
user_orders AS (
  SELECT r.anonymous_id,
    COUNT(*) AS total_orders,
    MIN(CASE WHEN o.rn = 1 THEN TIMESTAMP_DIFF(o.order_timestamp, r.registration_timestamp, SECOND) END) AS secs_1,
    MIN(CASE WHEN o.rn = 2 THEN TIMESTAMP_DIFF(o.order_timestamp, r.registration_timestamp, SECOND) END) AS secs_2,
    MIN(CASE WHEN o.rn = 3 THEN TIMESTAMP_DIFF(o.order_timestamp, r.registration_timestamp, SECOND) END) AS secs_3,
    MIN(CASE WHEN o.rn = 4 THEN TIMESTAMP_DIFF(o.order_timestamp, r.registration_timestamp, SECOND) END) AS secs_4,
    MIN(CASE WHEN o.rn = 5 THEN TIMESTAMP_DIFF(o.order_timestamp, r.registration_timestamp, SECOND) END) AS secs_5,
    MIN(CASE WHEN o.rn = 6 THEN TIMESTAMP_DIFF(o.order_timestamp, r.registration_timestamp, SECOND) END) AS secs_6
  FROM registrations r
  JOIN (
    SELECT customer_id, order_timestamp,
      ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_timestamp) AS rn
    FROM `data-project-487408.dogwood.orders`
  ) o ON r.customer_id = o.customer_id
  WHERE o.order_timestamp >= r.registration_timestamp
  GROUP BY r.anonymous_id
)

SELECT
  step,
  sort_order,
  unique_users,
  ROUND(100.0 * unique_users / (SELECT n FROM total_reg), 1) AS pct_of_registrations,
  mean_count,
  median_count,
  median_time_from_reg
FROM (
  SELECT 'Registered (All, Sep–Nov 2025)' AS step, 1 AS sort_order,
    (SELECT n FROM total_reg) AS unique_users,
    NULL AS mean_count, NULL AS median_count, NULL AS median_time_from_reg

  UNION ALL
  SELECT 'Started onboarding', 2, COUNT(*), ROUND(AVG(cnt), 1),
    APPROX_QUANTILES(cnt, 2)[OFFSET(1)],
    FORMAT('%dd %dh %dm',
      CAST(APPROX_QUANTILES(secs,2)[OFFSET(1)] / 86400 AS INT64),
      MOD(CAST(APPROX_QUANTILES(secs,2)[OFFSET(1)] / 3600 AS INT64), 24),
      MOD(CAST(APPROX_QUANTILES(secs,2)[OFFSET(1)] / 60 AS INT64), 60))
  FROM onboarding_started

  UNION ALL
  SELECT 'Completed furthest onboarding step', 3, COUNT(*), ROUND(AVG(cnt), 1),
    APPROX_QUANTILES(cnt, 2)[OFFSET(1)],
    FORMAT('%dd %dh %dm',
      CAST(APPROX_QUANTILES(secs,2)[OFFSET(1)] / 86400 AS INT64),
      MOD(CAST(APPROX_QUANTILES(secs,2)[OFFSET(1)] / 3600 AS INT64), 24),
      MOD(CAST(APPROX_QUANTILES(secs,2)[OFFSET(1)] / 60 AS INT64), 60))
  FROM onboarding_furthest_step

  UNION ALL
  SELECT 'Viewed homescreen', 4, COUNT(*), ROUND(AVG(cnt), 1),
    APPROX_QUANTILES(cnt, 2)[OFFSET(1)],
    FORMAT('%dd %dh %dm',
      CAST(APPROX_QUANTILES(secs,2)[OFFSET(1)] / 86400 AS INT64),
      MOD(CAST(APPROX_QUANTILES(secs,2)[OFFSET(1)] / 3600 AS INT64), 24),
      MOD(CAST(APPROX_QUANTILES(secs,2)[OFFSET(1)] / 60 AS INT64), 60))
  FROM homescreen

  UNION ALL
  SELECT 'Viewed products', 5, COUNT(*), ROUND(AVG(cnt), 1),
    APPROX_QUANTILES(cnt, 2)[OFFSET(1)],
    FORMAT('%dd %dh %dm',
      CAST(APPROX_QUANTILES(secs,2)[OFFSET(1)] / 86400 AS INT64),
      MOD(CAST(APPROX_QUANTILES(secs,2)[OFFSET(1)] / 3600 AS INT64), 24),
      MOD(CAST(APPROX_QUANTILES(secs,2)[OFFSET(1)] / 60 AS INT64), 60))
  FROM product_views

  UNION ALL
  SELECT 'Viewed collections', 6, COUNT(*), ROUND(AVG(cnt), 1),
    APPROX_QUANTILES(cnt, 2)[OFFSET(1)],
    FORMAT('%dd %dh %dm',
      CAST(APPROX_QUANTILES(secs,2)[OFFSET(1)] / 86400 AS INT64),
      MOD(CAST(APPROX_QUANTILES(secs,2)[OFFSET(1)] / 3600 AS INT64), 24),
      MOD(CAST(APPROX_QUANTILES(secs,2)[OFFSET(1)] / 60 AS INT64), 60))
  FROM collection_views

  UNION ALL
  SELECT 'Viewed supplier page', 7, COUNT(*), ROUND(AVG(cnt), 1),
    APPROX_QUANTILES(cnt, 2)[OFFSET(1)],
    FORMAT('%dd %dh %dm',
      CAST(APPROX_QUANTILES(secs,2)[OFFSET(1)] / 86400 AS INT64),
      MOD(CAST(APPROX_QUANTILES(secs,2)[OFFSET(1)] / 3600 AS INT64), 24),
      MOD(CAST(APPROX_QUANTILES(secs,2)[OFFSET(1)] / 60 AS INT64), 60))
  FROM supplier_views

  UNION ALL
  SELECT 'Searched', 8, COUNT(*), ROUND(AVG(cnt), 1),
    APPROX_QUANTILES(cnt, 2)[OFFSET(1)],
    FORMAT('%dd %dh %dm',
      CAST(APPROX_QUANTILES(secs,2)[OFFSET(1)] / 86400 AS INT64),
      MOD(CAST(APPROX_QUANTILES(secs,2)[OFFSET(1)] / 3600 AS INT64), 24),
      MOD(CAST(APPROX_QUANTILES(secs,2)[OFFSET(1)] / 60 AS INT64), 60))
  FROM searches

  UNION ALL
  SELECT 'Placed 1st order', 9, COUNT(*), ROUND(AVG(total_orders), 1),
    APPROX_QUANTILES(total_orders, 2)[OFFSET(1)],
    FORMAT('%dd %dh %dm',
      CAST(APPROX_QUANTILES(secs_1,2)[OFFSET(1)] / 86400 AS INT64),
      MOD(CAST(APPROX_QUANTILES(secs_1,2)[OFFSET(1)] / 3600 AS INT64), 24),
      MOD(CAST(APPROX_QUANTILES(secs_1,2)[OFFSET(1)] / 60 AS INT64), 60))
  FROM user_orders WHERE total_orders >= 1

  UNION ALL
  SELECT 'Placed 2nd order', 10, COUNT(*), ROUND(AVG(total_orders), 1),
    APPROX_QUANTILES(total_orders, 2)[OFFSET(1)],
    FORMAT('%dd %dh %dm',
      CAST(APPROX_QUANTILES(secs_2,2)[OFFSET(1)] / 86400 AS INT64),
      MOD(CAST(APPROX_QUANTILES(secs_2,2)[OFFSET(1)] / 3600 AS INT64), 24),
      MOD(CAST(APPROX_QUANTILES(secs_2,2)[OFFSET(1)] / 60 AS INT64), 60))
  FROM user_orders WHERE total_orders >= 2

  UNION ALL
  SELECT 'Placed 3rd order', 11, COUNT(*), ROUND(AVG(total_orders), 1),
    APPROX_QUANTILES(total_orders, 2)[OFFSET(1)],
    FORMAT('%dd %dh %dm',
      CAST(APPROX_QUANTILES(secs_3,2)[OFFSET(1)] / 86400 AS INT64),
      MOD(CAST(APPROX_QUANTILES(secs_3,2)[OFFSET(1)] / 3600 AS INT64), 24),
      MOD(CAST(APPROX_QUANTILES(secs_3,2)[OFFSET(1)] / 60 AS INT64), 60))
  FROM user_orders WHERE total_orders >= 3

  UNION ALL
  SELECT 'Placed 4th order', 12, COUNT(*), ROUND(AVG(total_orders), 1),
    APPROX_QUANTILES(total_orders, 2)[OFFSET(1)],
    FORMAT('%dd %dh %dm',
      CAST(APPROX_QUANTILES(secs_4,2)[OFFSET(1)] / 86400 AS INT64),
      MOD(CAST(APPROX_QUANTILES(secs_4,2)[OFFSET(1)] / 3600 AS INT64), 24),
      MOD(CAST(APPROX_QUANTILES(secs_4,2)[OFFSET(1)] / 60 AS INT64), 60))
  FROM user_orders WHERE total_orders >= 4

  UNION ALL
  SELECT 'Placed 5th order', 13, COUNT(*), ROUND(AVG(total_orders), 1),
    APPROX_QUANTILES(total_orders, 2)[OFFSET(1)],
    FORMAT('%dd %dh %dm',
      CAST(APPROX_QUANTILES(secs_5,2)[OFFSET(1)] / 86400 AS INT64),
      MOD(CAST(APPROX_QUANTILES(secs_5,2)[OFFSET(1)] / 3600 AS INT64), 24),
      MOD(CAST(APPROX_QUANTILES(secs_5,2)[OFFSET(1)] / 60 AS INT64), 60))
  FROM user_orders WHERE total_orders >= 5

  UNION ALL
  SELECT 'Placed 6+ orders', 14, COUNT(*), ROUND(AVG(total_orders), 1),
    APPROX_QUANTILES(total_orders, 2)[OFFSET(1)],
    FORMAT('%dd %dh %dm',
      CAST(APPROX_QUANTILES(secs_6,2)[OFFSET(1)] / 86400 AS INT64),
      MOD(CAST(APPROX_QUANTILES(secs_6,2)[OFFSET(1)] / 3600 AS INT64), 24),
      MOD(CAST(APPROX_QUANTILES(secs_6,2)[OFFSET(1)] / 60 AS INT64), 60))
  FROM user_orders WHERE total_orders >= 6
)
ORDER BY sort_order;
