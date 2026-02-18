-- User Activity by Platform (App vs Web)
-- Cohort: Sep–Nov 2025 registrations (78,796 users)
-- Last run: February 2026
--
-- RESULTS (as of last run):
--
-- Activity           Platform          Unique Users   % of Registered   Total Sessions   Mean Sessions   Median Sessions   Total Events   Mean Events   Median Events
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Homescreen views   App               77,851         97.9%             1,114,612        14.3            3                 1,346,557      17.3          4
-- Homescreen views   Web               5,733           7.2%             15,524            2.7            1                 41,741          7.3          4
-- Product views      App               70,597         88.8%             472,814           6.7            2                 4,035,531      57.2         13
-- Product views      Web               5,408           6.8%             19,860            3.7            1                 121,594        22.5          7
-- Collection views   App               64,187         80.7%             307,358           4.8            2                 536,732         8.4          4
-- Collection views   Web               4,011           5.0%             9,877             2.5            1                 100,058        24.9         12
-- Searches           App               54,249         68.2%             157,167           2.9            1                 506,285         9.3          4
-- Searches           Web               3,556           4.5%             7,884             2.2            1                 24,349          6.8          4
-- Vendor page views  Web only          2,863           3.6%             8,078             2.8            1                 35,200         12.3          4
-- Orders             No platform data  7,756           9.8%             14,756            1.9            1                 14,756          1.9          1
--
-- METHODOLOGY NOTES:
-- - Cohort: all registered users (app + web) between 2025-09-02 and 2025-11-30
-- - Joined via GID user_id to track the same user across app and web accurately
--   (anonymous_id is device-specific; GID persists for logged-in sessions across devices)
-- - Only events AFTER registration_timestamp are counted
-- - Sessions defined as: gap of >30 minutes of inactivity = new session, per user per platform per activity
-- - Orders joined via customer_id extracted from GID: REGEXP_EXTRACT(user_id, r'Customer/(\d+)')
-- - Orders have no platform column — tracking gap
-- - Vendor page views are web-only — app tracking gap (no event fires when tapping supplier page in app)
-- - % of registered uses total cohort (78,796) as denominator; rows for app and web can overlap
--   (same user counted in both if they used both platforms)
-- - Same user can appear in both app and web rows — percentages are not mutually exclusive

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
    SUM(is_new_session) OVER (PARTITION BY user_id, platform, activity ORDER BY event_ts) AS session_num,
    1 AS event_count
  FROM session_flags
),
user_activity_stats AS (
  SELECT user_id, platform, activity,
    COUNT(DISTINCT session_num) AS num_sessions,
    COUNT(*) AS num_events
  FROM sessions
  GROUP BY user_id, platform, activity
),
event_rows AS (
  SELECT activity, platform,
    COUNT(DISTINCT user_id) AS unique_users,
    ROUND(100.0 * COUNT(DISTINCT user_id) / (SELECT n FROM total_registered), 1) AS pct_of_registered,
    SUM(num_sessions) AS total_sessions,
    ROUND(AVG(num_sessions), 1) AS mean_sessions,
    APPROX_QUANTILES(num_sessions, 2)[OFFSET(1)] AS median_sessions,
    SUM(num_events) AS total_events,
    ROUND(AVG(num_events), 1) AS mean_events,
    APPROX_QUANTILES(num_events, 2)[OFFSET(1)] AS median_events
  FROM user_activity_stats
  GROUP BY activity, platform
),
user_orders AS (
  SELECT rg.user_id, COUNT(*) AS order_count
  FROM registered_gids rg
  JOIN `data-project-487408.dogwood.orders` o ON rg.customer_id = o.customer_id
  WHERE o.order_timestamp >= rg.registration_timestamp
  GROUP BY rg.user_id
),
order_rows AS (
  SELECT 'Orders' AS activity, 'No platform data' AS platform,
    COUNT(DISTINCT user_id) AS unique_users,
    ROUND(100.0 * COUNT(DISTINCT user_id) / (SELECT n FROM total_registered), 1) AS pct_of_registered,
    SUM(order_count) AS total_sessions,
    ROUND(AVG(order_count), 1) AS mean_sessions,
    APPROX_QUANTILES(order_count, 2)[OFFSET(1)] AS median_sessions,
    SUM(order_count) AS total_events,
    ROUND(AVG(order_count), 1) AS mean_events,
    APPROX_QUANTILES(order_count, 2)[OFFSET(1)] AS median_events
  FROM user_orders
)
SELECT activity, platform, unique_users, pct_of_registered,
  total_sessions, mean_sessions, median_sessions,
  total_events, mean_events, median_events,
  CASE activity WHEN 'Homescreen views' THEN 1 WHEN 'Product views' THEN 2 WHEN 'Collection views' THEN 3 WHEN 'Searches' THEN 4 WHEN 'Vendor page views' THEN 5 ELSE 6 END AS sort
FROM event_rows
UNION ALL SELECT *, 6 FROM order_rows
ORDER BY sort, platform DESC;
