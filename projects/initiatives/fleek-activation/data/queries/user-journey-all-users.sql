-- User Journey: Full conversion funnel (all registrations, no cohorts)
-- Single row: registration → first order → second order
-- Time format: "X days Y hours"

WITH journey_events AS (
  SELECT
    r.anonymous_id,
    r.registration_timestamp,
    fo.first_order_timestamp,
    so.second_order_timestamp,
    MIN(os.onboarding_started_timestamp) as onboarding_started_ts,
    MIN(ob.onboarding_submitted_timestamp) as onboarding_submitted_ts,
    MIN(hv.view_timestamp) as first_homescreen_ts,
    MIN(pv.view_timestamp) as first_product_view_ts,
    MIN(s.search_timestamp) as first_search_ts,
    MIN(vv.view_timestamp) as first_vendor_view_ts
  FROM `data-project-487408.dogwood.registrations` r
  LEFT JOIN (
    SELECT customer_id, MIN(order_timestamp) as first_order_timestamp
    FROM `data-project-487408.dogwood.orders` WHERE total_price > 0 GROUP BY customer_id
  ) fo ON CAST(REGEXP_EXTRACT(r.user_id, r"Customer/(\d+)") AS INT64) = fo.customer_id
  LEFT JOIN (
    SELECT customer_id, order_timestamp as second_order_timestamp
    FROM (SELECT customer_id, order_timestamp, ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_timestamp) as rn
          FROM `data-project-487408.dogwood.orders` WHERE total_price > 0)
    WHERE rn = 2
  ) so ON CAST(REGEXP_EXTRACT(r.user_id, r"Customer/(\d+)") AS INT64) = so.customer_id
  LEFT JOIN `data-project-487408.dogwood.onboarding_started` os ON r.anonymous_id = os.anonymous_id
  LEFT JOIN `data-project-487408.dogwood.onboarding_submitted` ob ON r.anonymous_id = ob.anonymous_id
  LEFT JOIN `data-project-487408.dogwood.homescreen_views` hv ON r.anonymous_id = hv.anonymous_id
  LEFT JOIN `data-project-487408.dogwood.product_views` pv ON r.anonymous_id = pv.anonymous_id
  LEFT JOIN `data-project-487408.dogwood.searches` s ON r.anonymous_id = s.anonymous_id
  LEFT JOIN `data-project-487408.dogwood.vendor_page_views` vv ON r.anonymous_id = vv.anonymous_id
  WHERE r.registration_timestamp >= "2024-01-01"
  GROUP BY r.anonymous_id, r.registration_timestamp, fo.first_order_timestamp, so.second_order_timestamp
),
raw_metrics AS (
  SELECT
    COUNT(*) as total_users,
    ROUND(100.0 * COUNTIF(onboarding_started_ts IS NOT NULL) / COUNT(*), 1) as pct_onboarding_started,
    ROUND(100.0 * COUNTIF(onboarding_submitted_ts IS NOT NULL) / COUNT(*), 1) as pct_onboarding_completed,
    ROUND(100.0 * COUNTIF(first_homescreen_ts IS NOT NULL) / COUNT(*), 1) as pct_viewed_home,
    ROUND(100.0 * COUNTIF(first_product_view_ts IS NOT NULL) / COUNT(*), 1) as pct_viewed_product,
    ROUND(100.0 * COUNTIF(first_search_ts IS NOT NULL) / COUNT(*), 1) as pct_searched,
    ROUND(100.0 * COUNTIF(first_vendor_view_ts IS NOT NULL) / COUNT(*), 1) as pct_viewed_vendor,
    ROUND(100.0 * COUNTIF(first_order_timestamp IS NOT NULL) / COUNT(*), 1) as pct_first_order,
    ROUND(100.0 * COUNTIF(second_order_timestamp IS NOT NULL) / COUNT(*), 1) as pct_second_order,
    APPROX_QUANTILES(TIMESTAMP_DIFF(onboarding_started_ts, registration_timestamp, HOUR), 100)[OFFSET(50)] as m_hrs_onb_start,
    AVG(TIMESTAMP_DIFF(onboarding_started_ts, registration_timestamp, HOUR)) as a_hrs_onb_start,
    APPROX_QUANTILES(TIMESTAMP_DIFF(onboarding_submitted_ts, registration_timestamp, HOUR), 100)[OFFSET(50)] as m_hrs_onb_complete,
    AVG(TIMESTAMP_DIFF(onboarding_submitted_ts, registration_timestamp, HOUR)) as a_hrs_onb_complete,
    APPROX_QUANTILES(TIMESTAMP_DIFF(first_homescreen_ts, registration_timestamp, HOUR), 100)[OFFSET(50)] as m_hrs_home,
    AVG(TIMESTAMP_DIFF(first_homescreen_ts, registration_timestamp, HOUR)) as a_hrs_home,
    APPROX_QUANTILES(TIMESTAMP_DIFF(first_product_view_ts, registration_timestamp, HOUR), 100)[OFFSET(50)] as m_hrs_product,
    AVG(TIMESTAMP_DIFF(first_product_view_ts, registration_timestamp, HOUR)) as a_hrs_product,
    APPROX_QUANTILES(TIMESTAMP_DIFF(first_order_timestamp, registration_timestamp, HOUR), 100)[OFFSET(50)] as m_hrs_first_order,
    AVG(TIMESTAMP_DIFF(first_order_timestamp, registration_timestamp, HOUR)) as a_hrs_first_order,
    APPROX_QUANTILES(TIMESTAMP_DIFF(second_order_timestamp, first_order_timestamp, HOUR), 100)[OFFSET(50)] as m_hrs_second_order,
    AVG(TIMESTAMP_DIFF(second_order_timestamp, first_order_timestamp, HOUR)) as a_hrs_second_order
  FROM journey_events
)
SELECT
  total_users,
  pct_onboarding_started,
  pct_onboarding_completed,
  pct_viewed_home,
  pct_viewed_product,
  pct_searched,
  pct_viewed_vendor,
  pct_first_order,
  pct_second_order,
  IFNULL(FORMAT('%d days %d hours', CAST(FLOOR(m_hrs_onb_start / 24) AS INT64), CAST(MOD(CAST(ROUND(m_hrs_onb_start) AS INT64), 24) AS INT64)), NULL) as median_time_to_onb_start,
  IFNULL(FORMAT('%d days %d hours', CAST(FLOOR(a_hrs_onb_start / 24) AS INT64), CAST(MOD(CAST(ROUND(a_hrs_onb_start) AS INT64), 24) AS INT64)), NULL) as mean_time_to_onb_start,
  IFNULL(FORMAT('%d days %d hours', CAST(FLOOR(m_hrs_onb_complete / 24) AS INT64), CAST(MOD(CAST(ROUND(m_hrs_onb_complete) AS INT64), 24) AS INT64)), NULL) as median_time_to_onb_complete,
  IFNULL(FORMAT('%d days %d hours', CAST(FLOOR(a_hrs_onb_complete / 24) AS INT64), CAST(MOD(CAST(ROUND(a_hrs_onb_complete) AS INT64), 24) AS INT64)), NULL) as mean_time_to_onb_complete,
  IFNULL(FORMAT('%d days %d hours', CAST(FLOOR(m_hrs_home / 24) AS INT64), CAST(MOD(CAST(ROUND(m_hrs_home) AS INT64), 24) AS INT64)), NULL) as median_time_to_home,
  IFNULL(FORMAT('%d days %d hours', CAST(FLOOR(a_hrs_home / 24) AS INT64), CAST(MOD(CAST(ROUND(a_hrs_home) AS INT64), 24) AS INT64)), NULL) as mean_time_to_home,
  IFNULL(FORMAT('%d days %d hours', CAST(FLOOR(m_hrs_product / 24) AS INT64), CAST(MOD(CAST(ROUND(m_hrs_product) AS INT64), 24) AS INT64)), NULL) as median_time_to_product,
  IFNULL(FORMAT('%d days %d hours', CAST(FLOOR(a_hrs_product / 24) AS INT64), CAST(MOD(CAST(ROUND(a_hrs_product) AS INT64), 24) AS INT64)), NULL) as mean_time_to_product,
  IFNULL(FORMAT('%d days %d hours', CAST(FLOOR(m_hrs_first_order / 24) AS INT64), CAST(MOD(CAST(ROUND(m_hrs_first_order) AS INT64), 24) AS INT64)), NULL) as median_time_to_first_order,
  IFNULL(FORMAT('%d days %d hours', CAST(FLOOR(a_hrs_first_order / 24) AS INT64), CAST(MOD(CAST(ROUND(a_hrs_first_order) AS INT64), 24) AS INT64)), NULL) as mean_time_to_first_order,
  IFNULL(FORMAT('%d days %d hours', CAST(FLOOR(m_hrs_second_order / 24) AS INT64), CAST(MOD(CAST(ROUND(m_hrs_second_order) AS INT64), 24) AS INT64)), NULL) as median_time_to_second_order,
  IFNULL(FORMAT('%d days %d hours', CAST(FLOOR(a_hrs_second_order / 24) AS INT64), CAST(MOD(CAST(ROUND(a_hrs_second_order) AS INT64), 24) AS INT64)), NULL) as mean_time_to_second_order
FROM raw_metrics;
