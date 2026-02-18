-- LOOKER STUDIO VIEWS
-- Run each statement separately in the BigQuery console.
-- Each creates a view in data-project-487408.dogwood that Looker Studio connects to directly.
-- Views are live — they always reflect the latest underlying data when queried.

-- ============================================================
-- VIEW 1: Activation Funnel
-- Chart type: Horizontal bar chart
--   Dimension: step  |  Metric: unique_users or pct_of_registrations
--   Sort by: sort_order ASC
-- Note: median_secs_from_reg is the raw value for sorting/calculations;
--       median_time_from_reg is the human-readable label for tooltips/tables
-- ============================================================

CREATE OR REPLACE VIEW `data-project-487408.dogwood.v_activation_funnel` AS

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
  SELECT ob.anonymous_id, COUNT(*) AS cnt,
    MIN(TIMESTAMP_DIFF(ob.onboarding_submitted_timestamp, r.registration_timestamp, SECOND)) AS secs
  FROM `data-project-487408.dogwood.onboarding_submitted` ob
  JOIN registrations r ON ob.anonymous_id = r.anonymous_id
  WHERE ob.flow_status = 'STARTED'
    AND ob.onboarding_submitted_timestamp >= r.registration_timestamp
  GROUP BY ob.anonymous_id
),
onboarding_furthest_step AS (
  SELECT ob.anonymous_id, 1 AS cnt,
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
  WHERE t.view_timestamp >= r.registration_timestamp GROUP BY t.anonymous_id
),
product_views AS (
  SELECT t.anonymous_id, COUNT(*) AS cnt,
    MIN(TIMESTAMP_DIFF(t.view_timestamp, r.registration_timestamp, SECOND)) AS secs
  FROM `data-project-487408.dogwood.product_views` t
  JOIN registrations r ON t.anonymous_id = r.anonymous_id
  WHERE t.view_timestamp >= r.registration_timestamp GROUP BY t.anonymous_id
),
collection_views AS (
  SELECT t.anonymous_id, COUNT(*) AS cnt,
    MIN(TIMESTAMP_DIFF(t.view_timestamp, r.registration_timestamp, SECOND)) AS secs
  FROM `data-project-487408.dogwood.collection_views` t
  JOIN registrations r ON t.anonymous_id = r.anonymous_id
  WHERE t.view_timestamp >= r.registration_timestamp GROUP BY t.anonymous_id
),
supplier_views AS (
  SELECT t.anonymous_id, COUNT(*) AS cnt,
    MIN(TIMESTAMP_DIFF(t.view_timestamp, r.registration_timestamp, SECOND)) AS secs
  FROM `data-project-487408.dogwood.vendor_page_views` t
  JOIN registrations r ON t.anonymous_id = r.anonymous_id
  WHERE t.view_timestamp >= r.registration_timestamp GROUP BY t.anonymous_id
),
searches AS (
  SELECT t.anonymous_id, COUNT(*) AS cnt,
    MIN(TIMESTAMP_DIFF(t.search_timestamp, r.registration_timestamp, SECOND)) AS secs
  FROM `data-project-487408.dogwood.searches` t
  JOIN registrations r ON t.anonymous_id = r.anonymous_id
  WHERE t.search_timestamp >= r.registration_timestamp GROUP BY t.anonymous_id
),
user_orders AS (
  SELECT r.anonymous_id, COUNT(*) AS total_orders,
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

SELECT step, sort_order, unique_users,
  ROUND(100.0 * unique_users / (SELECT n FROM total_reg), 1) AS pct_of_registrations,
  mean_count,
  median_count,
  median_secs_from_reg,
  FORMAT('%dd %dh %dm',
    CAST(median_secs_from_reg / 86400 AS INT64),
    MOD(CAST(median_secs_from_reg / 3600 AS INT64), 24),
    MOD(CAST(median_secs_from_reg / 60 AS INT64), 60)) AS median_time_from_reg
FROM (
  SELECT 'Registered (All, Sep–Nov 2025)' AS step, 1 AS sort_order,
    (SELECT n FROM total_reg) AS unique_users,
    NULL AS mean_count, NULL AS median_count, NULL AS median_secs_from_reg

  UNION ALL
  SELECT 'Started onboarding', 2, COUNT(*), ROUND(AVG(cnt), 1),
    CAST(APPROX_QUANTILES(cnt, 2)[OFFSET(1)] AS FLOAT64),
    CAST(APPROX_QUANTILES(secs, 2)[OFFSET(1)] AS FLOAT64)
  FROM onboarding_started

  UNION ALL
  SELECT 'Completed furthest onboarding step', 3, COUNT(*), ROUND(AVG(cnt), 1),
    CAST(APPROX_QUANTILES(cnt, 2)[OFFSET(1)] AS FLOAT64),
    CAST(APPROX_QUANTILES(secs, 2)[OFFSET(1)] AS FLOAT64)
  FROM onboarding_furthest_step

  UNION ALL
  SELECT 'Viewed homescreen', 4, COUNT(*), ROUND(AVG(cnt), 1),
    CAST(APPROX_QUANTILES(cnt, 2)[OFFSET(1)] AS FLOAT64),
    CAST(APPROX_QUANTILES(secs, 2)[OFFSET(1)] AS FLOAT64)
  FROM homescreen

  UNION ALL
  SELECT 'Viewed products', 5, COUNT(*), ROUND(AVG(cnt), 1),
    CAST(APPROX_QUANTILES(cnt, 2)[OFFSET(1)] AS FLOAT64),
    CAST(APPROX_QUANTILES(secs, 2)[OFFSET(1)] AS FLOAT64)
  FROM product_views

  UNION ALL
  SELECT 'Viewed collections', 6, COUNT(*), ROUND(AVG(cnt), 1),
    CAST(APPROX_QUANTILES(cnt, 2)[OFFSET(1)] AS FLOAT64),
    CAST(APPROX_QUANTILES(secs, 2)[OFFSET(1)] AS FLOAT64)
  FROM collection_views

  UNION ALL
  SELECT 'Viewed supplier page', 7, COUNT(*), ROUND(AVG(cnt), 1),
    CAST(APPROX_QUANTILES(cnt, 2)[OFFSET(1)] AS FLOAT64),
    CAST(APPROX_QUANTILES(secs, 2)[OFFSET(1)] AS FLOAT64)
  FROM supplier_views

  UNION ALL
  SELECT 'Searched', 8, COUNT(*), ROUND(AVG(cnt), 1),
    CAST(APPROX_QUANTILES(cnt, 2)[OFFSET(1)] AS FLOAT64),
    CAST(APPROX_QUANTILES(secs, 2)[OFFSET(1)] AS FLOAT64)
  FROM searches

  UNION ALL
  SELECT 'Placed 1st order', 9, COUNT(*), ROUND(AVG(total_orders), 1),
    CAST(APPROX_QUANTILES(total_orders, 2)[OFFSET(1)] AS FLOAT64),
    CAST(APPROX_QUANTILES(secs_1, 2)[OFFSET(1)] AS FLOAT64)
  FROM user_orders WHERE total_orders >= 1

  UNION ALL
  SELECT 'Placed 2nd order', 10, COUNT(*), ROUND(AVG(total_orders), 1),
    CAST(APPROX_QUANTILES(total_orders, 2)[OFFSET(1)] AS FLOAT64),
    CAST(APPROX_QUANTILES(secs_2, 2)[OFFSET(1)] AS FLOAT64)
  FROM user_orders WHERE total_orders >= 2

  UNION ALL
  SELECT 'Placed 3rd order', 11, COUNT(*), ROUND(AVG(total_orders), 1),
    CAST(APPROX_QUANTILES(total_orders, 2)[OFFSET(1)] AS FLOAT64),
    CAST(APPROX_QUANTILES(secs_3, 2)[OFFSET(1)] AS FLOAT64)
  FROM user_orders WHERE total_orders >= 3

  UNION ALL
  SELECT 'Placed 4th order', 12, COUNT(*), ROUND(AVG(total_orders), 1),
    CAST(APPROX_QUANTILES(total_orders, 2)[OFFSET(1)] AS FLOAT64),
    CAST(APPROX_QUANTILES(secs_4, 2)[OFFSET(1)] AS FLOAT64)
  FROM user_orders WHERE total_orders >= 4

  UNION ALL
  SELECT 'Placed 5th order', 13, COUNT(*), ROUND(AVG(total_orders), 1),
    CAST(APPROX_QUANTILES(total_orders, 2)[OFFSET(1)] AS FLOAT64),
    CAST(APPROX_QUANTILES(secs_5, 2)[OFFSET(1)] AS FLOAT64)
  FROM user_orders WHERE total_orders >= 5

  UNION ALL
  SELECT 'Placed 6+ orders', 14, COUNT(*), ROUND(AVG(total_orders), 1),
    CAST(APPROX_QUANTILES(total_orders, 2)[OFFSET(1)] AS FLOAT64),
    CAST(APPROX_QUANTILES(secs_6, 2)[OFFSET(1)] AS FLOAT64)
  FROM user_orders WHERE total_orders >= 6
)
ORDER BY sort_order;


-- ============================================================
-- VIEW 2: Onboarding Funnel by User Type
-- Chart type: Grouped bar chart
--   Dimension: user_type  |  Metrics: pct_categories, pct_brands, pct_budget
-- ============================================================

CREATE OR REPLACE VIEW `data-project-487408.dogwood.v_onboarding_funnel_by_user_type` AS

WITH
registrations AS (
  SELECT DISTINCT anonymous_id, MIN(registration_timestamp) AS registration_timestamp
  FROM `data-project-487408.dogwood.registrations`
  WHERE registration_timestamp >= '2025-09-02'
    AND registration_timestamp < '2025-12-01'
    AND platform = 'CONSUMER_APP'
  GROUP BY anonymous_id
),
total_reg AS (SELECT COUNT(*) AS n FROM registrations),
first_started AS (
  SELECT ob.anonymous_id, MIN(ob.onboarding_submitted_timestamp) AS first_started_ts
  FROM `data-project-487408.dogwood.onboarding_submitted` ob
  JOIN registrations r ON ob.anonymous_id = r.anonymous_id
  WHERE ob.flow_status = 'STARTED'
  GROUP BY ob.anonymous_id
),
second_started AS (
  SELECT ob.anonymous_id, MIN(ob.onboarding_submitted_timestamp) AS second_started_ts
  FROM `data-project-487408.dogwood.onboarding_submitted` ob
  JOIN first_started fs ON ob.anonymous_id = fs.anonymous_id
  WHERE ob.flow_status = 'STARTED' AND ob.onboarding_submitted_timestamp > fs.first_started_ts
  GROUP BY ob.anonymous_id
),
first_session_events AS (
  SELECT ob.anonymous_id, ob.flow_status, ob.screen_type, ob.purchase_tier, ob.onboarding_submitted_timestamp
  FROM `data-project-487408.dogwood.onboarding_submitted` ob
  JOIN first_started fs ON ob.anonymous_id = fs.anonymous_id
  LEFT JOIN second_started ss ON ob.anonymous_id = ss.anonymous_id
  WHERE ob.onboarding_submitted_timestamp >= fs.first_started_ts
    AND (ss.second_started_ts IS NULL OR ob.onboarding_submitted_timestamp < ss.second_started_ts)
),
user_type AS (
  SELECT anonymous_id, flow_status AS user_type_path,
    ROW_NUMBER() OVER (PARTITION BY anonymous_id ORDER BY onboarding_submitted_timestamp ASC) AS rn
  FROM first_session_events WHERE flow_status != 'STARTED'
),
classified AS (
  SELECT anonymous_id,
    CASE user_type_path
      WHEN 'PLATFORM_STORE_IDENTIFICATION' THEN 'Online Reseller'
      WHEN 'SAVE_USER_INTENT'              THEN 'Individual/Consumer'
      WHEN 'STORE_IDENTIFICATION'          THEN 'Physical Retailer'
      ELSE 'Other'
    END AS user_type
  FROM user_type WHERE rn = 1
),
step_timestamps AS (
  SELECT anonymous_id,
    MIN(CASE WHEN screen_type = 'category' THEN onboarding_submitted_timestamp END) AS category_ts,
    MIN(CASE WHEN screen_type = 'brand'    THEN onboarding_submitted_timestamp END) AS brand_ts,
    MIN(CASE WHEN screen_type IS NULL AND purchase_tier IN ('Small_Buyer','Larger_Buyer','not_defined') THEN onboarding_submitted_timestamp END) AS budget_ts
  FROM first_session_events
  GROUP BY anonymous_id
),
user_summary AS (
  SELECT st.anonymous_id, c.user_type,
    CASE WHEN st.category_ts IS NOT NULL THEN 1 ELSE 0 END AS completed_categories,
    CASE WHEN st.brand_ts IS NOT NULL AND st.brand_ts > st.category_ts THEN 1 ELSE 0 END AS completed_brands,
    CASE WHEN st.budget_ts IS NOT NULL AND st.budget_ts > st.brand_ts THEN 1 ELSE 0 END AS completed_budget
  FROM step_timestamps st
  JOIN classified c ON st.anonymous_id = c.anonymous_id
),
total_started AS (SELECT COUNT(DISTINCT anonymous_id) AS n FROM first_started)

SELECT
  user_type,
  COUNT(*) AS users,
  ROUND(100.0 * COUNT(*) / (SELECT n FROM total_reg), 1) AS pct_of_registrations,
  ROUND(100.0 * COUNT(*) / (SELECT n FROM total_started), 1) AS pct_of_starters,
  SUM(completed_categories) AS users_categories,
  ROUND(100.0 * SUM(completed_categories) / COUNT(*), 1) AS pct_categories,
  SUM(completed_brands) AS users_brands,
  ROUND(100.0 * SUM(completed_brands) / COUNT(*), 1) AS pct_brands,
  SUM(completed_budget) AS users_budget,
  ROUND(100.0 * SUM(completed_budget) / COUNT(*), 1) AS pct_budget,
  CASE user_type
    WHEN 'Online Reseller'    THEN 1
    WHEN 'Individual/Consumer' THEN 2
    WHEN 'Physical Retailer'  THEN 3
    ELSE 4
  END AS sort_order
FROM user_summary
GROUP BY user_type
ORDER BY sort_order;


-- ============================================================
-- VIEW 3: User Activity by Platform
-- Chart type: Stacked or grouped bar chart
--   Dimension: activity  |  Metrics: unique_users, total_sessions, total_events
--   Break down by: platform
-- ============================================================

CREATE OR REPLACE VIEW `data-project-487408.dogwood.v_user_activity_by_platform` AS

WITH registered_gids AS (
  SELECT DISTINCT user_id,
    MIN(registration_timestamp) AS registration_timestamp,
    CAST(REGEXP_EXTRACT(user_id, r'Customer/(\d+)') AS INT64) AS customer_id
  FROM `data-project-487408.dogwood.registrations`
  WHERE user_id LIKE 'gid://%'
    AND registration_timestamp >= '2025-09-02'
    AND registration_timestamp < '2025-12-01'
  GROUP BY user_id
),
total_registered AS (SELECT COUNT(DISTINCT user_id) AS n FROM registered_gids),
all_events AS (
  SELECT t.user_id, t.platform, 'Homescreen views' AS activity, t.view_timestamp AS event_ts
  FROM `data-project-487408.dogwood.homescreen_views` t JOIN registered_gids r ON t.user_id = r.user_id AND t.view_timestamp >= r.registration_timestamp WHERE t.user_id LIKE 'gid://%'
  UNION ALL
  SELECT t.user_id, t.platform, 'Product views', t.view_timestamp
  FROM `data-project-487408.dogwood.product_views` t JOIN registered_gids r ON t.user_id = r.user_id AND t.view_timestamp >= r.registration_timestamp WHERE t.user_id LIKE 'gid://%'
  UNION ALL
  SELECT t.user_id, t.platform, 'Collection views', t.view_timestamp
  FROM `data-project-487408.dogwood.collection_views` t JOIN registered_gids r ON t.user_id = r.user_id AND t.view_timestamp >= r.registration_timestamp WHERE t.user_id LIKE 'gid://%'
  UNION ALL
  SELECT t.user_id, t.platform, 'Searches', t.search_timestamp
  FROM `data-project-487408.dogwood.searches` t JOIN registered_gids r ON t.user_id = r.user_id AND t.search_timestamp >= r.registration_timestamp WHERE t.user_id LIKE 'gid://%'
  UNION ALL
  SELECT t.user_id, t.platform, 'Vendor page views', t.view_timestamp
  FROM `data-project-487408.dogwood.vendor_page_views` t JOIN registered_gids r ON t.user_id = r.user_id AND t.view_timestamp >= r.registration_timestamp WHERE t.user_id LIKE 'gid://%'
),
session_flags AS (
  SELECT user_id, platform, activity, event_ts,
    CASE
      WHEN TIMESTAMP_DIFF(event_ts, LAG(event_ts) OVER (PARTITION BY user_id, platform, activity ORDER BY event_ts), MINUTE) > 30
        OR LAG(event_ts) OVER (PARTITION BY user_id, platform, activity ORDER BY event_ts) IS NULL
      THEN 1 ELSE 0
    END AS is_new_session
  FROM all_events
),
sessions AS (
  SELECT user_id, platform, activity,
    SUM(is_new_session) OVER (PARTITION BY user_id, platform, activity ORDER BY event_ts) AS session_num
  FROM session_flags
),
user_activity_stats AS (
  SELECT user_id, platform, activity,
    COUNT(DISTINCT session_num) AS num_sessions,
    COUNT(*) AS num_events
  FROM sessions
  GROUP BY user_id, platform, activity
),
user_orders AS (
  SELECT rg.user_id, COUNT(*) AS order_count
  FROM registered_gids rg
  JOIN `data-project-487408.dogwood.orders` o ON rg.customer_id = o.customer_id
  WHERE o.order_timestamp >= rg.registration_timestamp
  GROUP BY rg.user_id
)

SELECT activity, platform,
  COUNT(DISTINCT user_id) AS unique_users,
  ROUND(100.0 * COUNT(DISTINCT user_id) / (SELECT n FROM total_registered), 1) AS pct_of_registered,
  SUM(num_sessions) AS total_sessions,
  ROUND(AVG(num_sessions), 1) AS mean_sessions,
  APPROX_QUANTILES(num_sessions, 2)[OFFSET(1)] AS median_sessions,
  SUM(num_events) AS total_events,
  ROUND(AVG(num_events), 1) AS mean_events,
  APPROX_QUANTILES(num_events, 2)[OFFSET(1)] AS median_events,
  CASE activity
    WHEN 'Homescreen views'  THEN 1
    WHEN 'Product views'     THEN 2
    WHEN 'Collection views'  THEN 3
    WHEN 'Vendor page views' THEN 4
    WHEN 'Searches'          THEN 5
    ELSE 6
  END AS sort_order
FROM user_activity_stats
GROUP BY activity, platform

UNION ALL

SELECT 'Orders', 'No platform data',
  COUNT(DISTINCT user_id),
  ROUND(100.0 * COUNT(DISTINCT user_id) / (SELECT n FROM total_registered), 1),
  SUM(order_count), ROUND(AVG(order_count), 1), APPROX_QUANTILES(order_count, 2)[OFFSET(1)],
  SUM(order_count), ROUND(AVG(order_count), 1), APPROX_QUANTILES(order_count, 2)[OFFSET(1)],
  6
FROM user_orders

ORDER BY sort_order, platform DESC;
