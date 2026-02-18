-- Funnel: All registrations (onboarding as optional steps)
-- Optimised: each event table pre-aggregated to one row per user before joining
-- Rows = funnel steps, pct_of_registrations = % of all registrations who reached each step
-- Time = median and mean "X days Y hours" from registration

WITH registrations AS (
  SELECT
    anonymous_id,
    registration_timestamp,
    CAST(REGEXP_EXTRACT(user_id, r'Customer/(\d+)') AS INT64) as customer_id
  FROM `data-project-487408.dogwood.registrations`
  WHERE registration_timestamp >= '2024-01-01'
),

-- Pre-aggregate each event table to one row per user before joining
onboarding_started AS (
  SELECT anonymous_id, MIN(onboarding_started_timestamp) as ts
  FROM `data-project-487408.dogwood.onboarding_started`
  GROUP BY anonymous_id
),
onboarding_complete AS (
  SELECT anonymous_id, MIN(onboarding_submitted_timestamp) as ts
  FROM `data-project-487408.dogwood.onboarding_submitted`
  GROUP BY anonymous_id
),
home_views AS (
  SELECT anonymous_id, MIN(view_timestamp) as ts
  FROM `data-project-487408.dogwood.homescreen_views`
  GROUP BY anonymous_id
),
collection_views AS (
  SELECT anonymous_id, MIN(view_timestamp) as ts
  FROM `data-project-487408.dogwood.collection_views`
  GROUP BY anonymous_id
),
product_views AS (
  SELECT anonymous_id, MIN(view_timestamp) as ts
  FROM `data-project-487408.dogwood.product_views`
  GROUP BY anonymous_id
),
searches AS (
  SELECT anonymous_id, MIN(search_timestamp) as ts
  FROM `data-project-487408.dogwood.searches`
  GROUP BY anonymous_id
),
vendor_views AS (
  SELECT anonymous_id, MIN(view_timestamp) as ts
  FROM `data-project-487408.dogwood.vendor_page_views`
  GROUP BY anonymous_id
),
first_orders AS (
  SELECT customer_id, MIN(order_timestamp) as ts
  FROM `data-project-487408.dogwood.orders`
  WHERE total_price > 0
  GROUP BY customer_id
),
second_orders AS (
  SELECT customer_id, order_timestamp as ts
  FROM (
    SELECT customer_id, order_timestamp,
           ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_timestamp) as rn
    FROM `data-project-487408.dogwood.orders`
    WHERE total_price > 0
  )
  WHERE rn = 2
),

-- One row per user with all event timestamps
user_events AS (
  SELECT
    r.anonymous_id,
    r.registration_timestamp,
    os.ts  as onboarding_started_ts,
    oc.ts  as onboarding_complete_ts,
    hv.ts  as first_home_ts,
    cv.ts  as first_collection_ts,
    pv.ts  as first_product_ts,
    s.ts   as first_search_ts,
    vv.ts  as first_vendor_ts,
    fo.ts  as first_order_ts,
    so.ts  as second_order_ts
  FROM registrations r
  LEFT JOIN onboarding_started os  ON r.anonymous_id = os.anonymous_id
  LEFT JOIN onboarding_complete oc ON r.anonymous_id = oc.anonymous_id
  LEFT JOIN home_views hv          ON r.anonymous_id = hv.anonymous_id
  LEFT JOIN collection_views cv    ON r.anonymous_id = cv.anonymous_id
  LEFT JOIN product_views pv       ON r.anonymous_id = pv.anonymous_id
  LEFT JOIN searches s             ON r.anonymous_id = s.anonymous_id
  LEFT JOIN vendor_views vv        ON r.anonymous_id = vv.anonymous_id
  LEFT JOIN first_orders fo        ON r.customer_id  = fo.customer_id
  LEFT JOIN second_orders so       ON r.customer_id  = so.customer_id
),

total AS (SELECT COUNT(*) as n FROM user_events)

-- Output: one row per funnel step
SELECT sort_order, funnel_step, n_users, pct_of_registrations, median_time_from_reg, mean_time_from_reg
FROM (

  SELECT 1 as sort_order, 'Registration' as funnel_step,
    (SELECT n FROM total) as n_users,
    100.0 as pct_of_registrations,
    '—' as median_time_from_reg,
    '—' as mean_time_from_reg
  FROM total

  UNION ALL
  SELECT 2, 'Onboarding started',
    COUNTIF(onboarding_started_ts IS NOT NULL),
    ROUND(100.0 * COUNTIF(onboarding_started_ts IS NOT NULL) / COUNT(*), 1),
    FORMAT('%d days %d hours',
      CAST(FLOOR(APPROX_QUANTILES(TIMESTAMP_DIFF(onboarding_started_ts, registration_timestamp, HOUR), 100)[OFFSET(50)] / 24) AS INT64),
      CAST(MOD(APPROX_QUANTILES(TIMESTAMP_DIFF(onboarding_started_ts, registration_timestamp, HOUR), 100)[OFFSET(50)], 24) AS INT64)),
    FORMAT('%d days %d hours',
      CAST(FLOOR(AVG(TIMESTAMP_DIFF(onboarding_started_ts, registration_timestamp, HOUR)) / 24) AS INT64),
      CAST(MOD(CAST(ROUND(AVG(TIMESTAMP_DIFF(onboarding_started_ts, registration_timestamp, HOUR))) AS INT64), 24) AS INT64))
  FROM user_events

  UNION ALL
  SELECT 3, 'Onboarding complete',
    COUNTIF(onboarding_complete_ts IS NOT NULL),
    ROUND(100.0 * COUNTIF(onboarding_complete_ts IS NOT NULL) / COUNT(*), 1),
    FORMAT('%d days %d hours',
      CAST(FLOOR(APPROX_QUANTILES(TIMESTAMP_DIFF(onboarding_complete_ts, registration_timestamp, HOUR), 100)[OFFSET(50)] / 24) AS INT64),
      CAST(MOD(APPROX_QUANTILES(TIMESTAMP_DIFF(onboarding_complete_ts, registration_timestamp, HOUR), 100)[OFFSET(50)], 24) AS INT64)),
    FORMAT('%d days %d hours',
      CAST(FLOOR(AVG(TIMESTAMP_DIFF(onboarding_complete_ts, registration_timestamp, HOUR)) / 24) AS INT64),
      CAST(MOD(CAST(ROUND(AVG(TIMESTAMP_DIFF(onboarding_complete_ts, registration_timestamp, HOUR))) AS INT64), 24) AS INT64))
  FROM user_events

  UNION ALL
  SELECT 4, 'First homepage view',
    COUNTIF(first_home_ts IS NOT NULL),
    ROUND(100.0 * COUNTIF(first_home_ts IS NOT NULL) / COUNT(*), 1),
    FORMAT('%d days %d hours',
      CAST(FLOOR(APPROX_QUANTILES(TIMESTAMP_DIFF(first_home_ts, registration_timestamp, HOUR), 100)[OFFSET(50)] / 24) AS INT64),
      CAST(MOD(APPROX_QUANTILES(TIMESTAMP_DIFF(first_home_ts, registration_timestamp, HOUR), 100)[OFFSET(50)], 24) AS INT64)),
    FORMAT('%d days %d hours',
      CAST(FLOOR(AVG(TIMESTAMP_DIFF(first_home_ts, registration_timestamp, HOUR)) / 24) AS INT64),
      CAST(MOD(CAST(ROUND(AVG(TIMESTAMP_DIFF(first_home_ts, registration_timestamp, HOUR))) AS INT64), 24) AS INT64))
  FROM user_events

  UNION ALL
  SELECT 5, 'First collection view',
    COUNTIF(first_collection_ts IS NOT NULL),
    ROUND(100.0 * COUNTIF(first_collection_ts IS NOT NULL) / COUNT(*), 1),
    FORMAT('%d days %d hours',
      CAST(FLOOR(APPROX_QUANTILES(TIMESTAMP_DIFF(first_collection_ts, registration_timestamp, HOUR), 100)[OFFSET(50)] / 24) AS INT64),
      CAST(MOD(APPROX_QUANTILES(TIMESTAMP_DIFF(first_collection_ts, registration_timestamp, HOUR), 100)[OFFSET(50)], 24) AS INT64)),
    FORMAT('%d days %d hours',
      CAST(FLOOR(AVG(TIMESTAMP_DIFF(first_collection_ts, registration_timestamp, HOUR)) / 24) AS INT64),
      CAST(MOD(CAST(ROUND(AVG(TIMESTAMP_DIFF(first_collection_ts, registration_timestamp, HOUR))) AS INT64), 24) AS INT64))
  FROM user_events

  UNION ALL
  SELECT 6, 'First product view',
    COUNTIF(first_product_ts IS NOT NULL),
    ROUND(100.0 * COUNTIF(first_product_ts IS NOT NULL) / COUNT(*), 1),
    FORMAT('%d days %d hours',
      CAST(FLOOR(APPROX_QUANTILES(TIMESTAMP_DIFF(first_product_ts, registration_timestamp, HOUR), 100)[OFFSET(50)] / 24) AS INT64),
      CAST(MOD(APPROX_QUANTILES(TIMESTAMP_DIFF(first_product_ts, registration_timestamp, HOUR), 100)[OFFSET(50)], 24) AS INT64)),
    FORMAT('%d days %d hours',
      CAST(FLOOR(AVG(TIMESTAMP_DIFF(first_product_ts, registration_timestamp, HOUR)) / 24) AS INT64),
      CAST(MOD(CAST(ROUND(AVG(TIMESTAMP_DIFF(first_product_ts, registration_timestamp, HOUR))) AS INT64), 24) AS INT64))
  FROM user_events

  UNION ALL
  SELECT 7, 'First search',
    COUNTIF(first_search_ts IS NOT NULL),
    ROUND(100.0 * COUNTIF(first_search_ts IS NOT NULL) / COUNT(*), 1),
    FORMAT('%d days %d hours',
      CAST(FLOOR(APPROX_QUANTILES(TIMESTAMP_DIFF(first_search_ts, registration_timestamp, HOUR), 100)[OFFSET(50)] / 24) AS INT64),
      CAST(MOD(APPROX_QUANTILES(TIMESTAMP_DIFF(first_search_ts, registration_timestamp, HOUR), 100)[OFFSET(50)], 24) AS INT64)),
    FORMAT('%d days %d hours',
      CAST(FLOOR(AVG(TIMESTAMP_DIFF(first_search_ts, registration_timestamp, HOUR)) / 24) AS INT64),
      CAST(MOD(CAST(ROUND(AVG(TIMESTAMP_DIFF(first_search_ts, registration_timestamp, HOUR))) AS INT64), 24) AS INT64))
  FROM user_events

  UNION ALL
  SELECT 8, 'First vendor view',
    COUNTIF(first_vendor_ts IS NOT NULL),
    ROUND(100.0 * COUNTIF(first_vendor_ts IS NOT NULL) / COUNT(*), 1),
    FORMAT('%d days %d hours',
      CAST(FLOOR(APPROX_QUANTILES(TIMESTAMP_DIFF(first_vendor_ts, registration_timestamp, HOUR), 100)[OFFSET(50)] / 24) AS INT64),
      CAST(MOD(APPROX_QUANTILES(TIMESTAMP_DIFF(first_vendor_ts, registration_timestamp, HOUR), 100)[OFFSET(50)], 24) AS INT64)),
    FORMAT('%d days %d hours',
      CAST(FLOOR(AVG(TIMESTAMP_DIFF(first_vendor_ts, registration_timestamp, HOUR)) / 24) AS INT64),
      CAST(MOD(CAST(ROUND(AVG(TIMESTAMP_DIFF(first_vendor_ts, registration_timestamp, HOUR))) AS INT64), 24) AS INT64))
  FROM user_events

  UNION ALL
  SELECT 9, 'First order',
    COUNTIF(first_order_ts IS NOT NULL),
    ROUND(100.0 * COUNTIF(first_order_ts IS NOT NULL) / COUNT(*), 1),
    FORMAT('%d days %d hours',
      CAST(FLOOR(APPROX_QUANTILES(TIMESTAMP_DIFF(first_order_ts, registration_timestamp, HOUR), 100)[OFFSET(50)] / 24) AS INT64),
      CAST(MOD(APPROX_QUANTILES(TIMESTAMP_DIFF(first_order_ts, registration_timestamp, HOUR), 100)[OFFSET(50)], 24) AS INT64)),
    FORMAT('%d days %d hours',
      CAST(FLOOR(AVG(TIMESTAMP_DIFF(first_order_ts, registration_timestamp, HOUR)) / 24) AS INT64),
      CAST(MOD(CAST(ROUND(AVG(TIMESTAMP_DIFF(first_order_ts, registration_timestamp, HOUR))) AS INT64), 24) AS INT64))
  FROM user_events

  UNION ALL
  SELECT 10, 'Second order',
    COUNTIF(second_order_ts IS NOT NULL),
    ROUND(100.0 * COUNTIF(second_order_ts IS NOT NULL) / COUNT(*), 1),
    FORMAT('%d days %d hours',
      CAST(FLOOR(APPROX_QUANTILES(TIMESTAMP_DIFF(second_order_ts, registration_timestamp, HOUR), 100)[OFFSET(50)] / 24) AS INT64),
      CAST(MOD(APPROX_QUANTILES(TIMESTAMP_DIFF(second_order_ts, registration_timestamp, HOUR), 100)[OFFSET(50)], 24) AS INT64)),
    FORMAT('%d days %d hours',
      CAST(FLOOR(AVG(TIMESTAMP_DIFF(second_order_ts, registration_timestamp, HOUR)) / 24) AS INT64),
      CAST(MOD(CAST(ROUND(AVG(TIMESTAMP_DIFF(second_order_ts, registration_timestamp, HOUR))) AS INT64), 24) AS INT64))
  FROM user_events

)
ORDER BY sort_order;
