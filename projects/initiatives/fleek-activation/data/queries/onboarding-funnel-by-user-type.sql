-- Onboarding Funnel by User Type
-- Last run: February 2026
--
-- RESULTS (as of last run, Sep–Nov 2025 cohort):
--
-- Step                                Users     % of Registrations   % of Prev Step
-- -----------------------------------------------------------------------------------
-- App Registrations (Sep–Nov 2025)   75,490    100%                 —
-- Started onboarding                 40,592     53.8%               53.8%
-- Online Reseller                    16,738     22.2%               41.2%
--   Categories                       15,331     20.3%               91.6%
--   Brands                           15,022     19.9%               89.7%
--   Budget                           14,940     19.8%               89.3%
-- Individual/Consumer                11,633     15.4%               28.7%
--   Categories                       10,493     13.9%               90.2%
--   Brands                           10,185     13.5%               87.6%
--   Budget                           10,128     13.4%               87.1%
-- Physical Retailer                     489      0.6%                1.2%
--   Categories                          392      0.5%               80.2%
--   Brands                              374      0.5%               76.5%
--   Budget                              370      0.5%               75.7%
--
-- METHODOLOGY NOTES:
-- - Registrations: CONSUMER_APP only, on or after 2025-09-02 (first onboarding event),
--   deduped to one row per anonymous_id using MIN(registration_timestamp)
-- - First session only: events from first STARTED up to (but not including) the next STARTED
-- - User type classified by the first non-STARTED flow_status event in the first session:
--     PLATFORM_STORE_IDENTIFICATION → Online Reseller
--     SAVE_USER_INTENT              → Individual/Consumer
--     STORE_IDENTIFICATION          → Physical Retailer
-- - Categories confirmed by screen_type = 'category' (100% co-occurrence with data_categories)
-- - Brands confirmed by screen_type = 'brand' (100% co-occurrence with data_brands)
-- - Budget confirmed by screen_type IS NULL + purchase_tier set after brand timestamp
-- - Ordering validated: category < brand < budget in 99.98%+ of cases
-- - ~25,900 users hit STARTED but never reached a user type screen (not in any sub-group)

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
  SELECT
    anonymous_id,
    MIN(CASE WHEN screen_type = 'category' THEN onboarding_submitted_timestamp END) AS category_ts,
    MIN(CASE WHEN screen_type = 'brand'    THEN onboarding_submitted_timestamp END) AS brand_ts,
    MIN(CASE WHEN screen_type IS NULL AND purchase_tier IN ('Small_Buyer','Larger_Buyer','not_defined') THEN onboarding_submitted_timestamp END) AS budget_ts
  FROM first_session_events
  GROUP BY anonymous_id
),
user_summary AS (
  SELECT
    st.anonymous_id,
    c.user_type,
    CASE WHEN st.category_ts IS NOT NULL THEN 1 ELSE 0 END AS completed_categories,
    CASE WHEN st.brand_ts IS NOT NULL AND st.brand_ts > st.category_ts THEN 1 ELSE 0 END AS completed_brands,
    CASE WHEN st.budget_ts IS NOT NULL AND st.budget_ts > st.brand_ts THEN 1 ELSE 0 END AS completed_budget
  FROM step_timestamps st
  JOIN classified c ON st.anonymous_id = c.anonymous_id
),
total_started AS (SELECT COUNT(DISTINCT anonymous_id) AS n FROM first_started)

SELECT step, sort_order, users,
  ROUND(100.0 * users / (SELECT n FROM total_reg), 1) AS pct_of_registrations,
  pct_of_prev
FROM (
  SELECT 'App Registrations (Sep–Nov 2025)' AS step, 1 AS sort_order, (SELECT n FROM total_reg) AS users, NULL AS pct_of_prev
  UNION ALL
  SELECT 'Started onboarding',              2, (SELECT n FROM total_started), ROUND(100.0 * (SELECT n FROM total_started) / (SELECT n FROM total_reg), 1)
  UNION ALL
  SELECT 'Online Reseller',                 3, COUNT(*), ROUND(100.0 * COUNT(*) / (SELECT n FROM total_started), 1) FROM user_summary WHERE user_type = 'Online Reseller'
  UNION ALL
  SELECT '  Categories',                    4, SUM(completed_categories), ROUND(100.0 * SUM(completed_categories) / COUNT(*), 1) FROM user_summary WHERE user_type = 'Online Reseller'
  UNION ALL
  SELECT '  Brands',                        5, SUM(completed_brands),     ROUND(100.0 * SUM(completed_brands)     / COUNT(*), 1) FROM user_summary WHERE user_type = 'Online Reseller'
  UNION ALL
  SELECT '  Budget',                        6, SUM(completed_budget),     ROUND(100.0 * SUM(completed_budget)     / COUNT(*), 1) FROM user_summary WHERE user_type = 'Online Reseller'
  UNION ALL
  SELECT 'Individual/Consumer',             7, COUNT(*), ROUND(100.0 * COUNT(*) / (SELECT n FROM total_started), 1) FROM user_summary WHERE user_type = 'Individual/Consumer'
  UNION ALL
  SELECT '  Categories',                    8, SUM(completed_categories), ROUND(100.0 * SUM(completed_categories) / COUNT(*), 1) FROM user_summary WHERE user_type = 'Individual/Consumer'
  UNION ALL
  SELECT '  Brands',                        9, SUM(completed_brands),     ROUND(100.0 * SUM(completed_brands)     / COUNT(*), 1) FROM user_summary WHERE user_type = 'Individual/Consumer'
  UNION ALL
  SELECT '  Budget',                       10, SUM(completed_budget),     ROUND(100.0 * SUM(completed_budget)     / COUNT(*), 1) FROM user_summary WHERE user_type = 'Individual/Consumer'
  UNION ALL
  SELECT 'Physical Retailer',              11, COUNT(*), ROUND(100.0 * COUNT(*) / (SELECT n FROM total_started), 1) FROM user_summary WHERE user_type = 'Physical Retailer'
  UNION ALL
  SELECT '  Categories',                   12, SUM(completed_categories), ROUND(100.0 * SUM(completed_categories) / COUNT(*), 1) FROM user_summary WHERE user_type = 'Physical Retailer'
  UNION ALL
  SELECT '  Brands',                       13, SUM(completed_brands),     ROUND(100.0 * SUM(completed_brands)     / COUNT(*), 1) FROM user_summary WHERE user_type = 'Physical Retailer'
  UNION ALL
  SELECT '  Budget',                       14, SUM(completed_budget),     ROUND(100.0 * SUM(completed_budget)     / COUNT(*), 1) FROM user_summary WHERE user_type = 'Physical Retailer'
)
ORDER BY sort_order;
