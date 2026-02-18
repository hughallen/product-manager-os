-- Step 2: Funnel summary (run after create-user-events-table.sql)
-- Queries the pre-built user_events table (~170K rows) — should be fast
-- Time diffs calculated in seconds, displayed as "Xd Yh Zm"
-- Negatives clamped to 0 (same-session timing noise)

SELECT sort_order, funnel_step, n_users, pct_of_registrations, median_time_from_reg, mean_time_from_reg
FROM (

  SELECT 1 as sort_order, 'Registration' as funnel_step,
    COUNT(*) as n_users,
    100.0 as pct_of_registrations,
    '—' as median_time_from_reg,
    '—' as mean_time_from_reg
  FROM `data-project-487408.dogwood.user_events`

  UNION ALL
  SELECT 2, 'Onboarding started',
    COUNTIF(onboarding_started_ts IS NOT NULL),
    ROUND(100.0 * COUNTIF(onboarding_started_ts IS NOT NULL) / COUNT(*), 1),
    FORMAT('%dd %dh %dm',
      CAST(FLOOR(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(onboarding_started_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0) / 86400) AS INT64),
      CAST(FLOOR(MOD(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(onboarding_started_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0), 86400) / 3600) AS INT64),
      CAST(FLOOR(MOD(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(onboarding_started_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0), 3600) / 60) AS INT64)),
    FORMAT('%dd %dh %dm',
      CAST(FLOOR(GREATEST(AVG(TIMESTAMP_DIFF(onboarding_started_ts, registration_timestamp, SECOND)), 0) / 86400) AS INT64),
      CAST(FLOOR(MOD(CAST(GREATEST(ROUND(AVG(TIMESTAMP_DIFF(onboarding_started_ts, registration_timestamp, SECOND))), 0) AS INT64), 86400) / 3600) AS INT64),
      CAST(FLOOR(MOD(CAST(GREATEST(ROUND(AVG(TIMESTAMP_DIFF(onboarding_started_ts, registration_timestamp, SECOND))), 0) AS INT64), 3600) / 60) AS INT64))
  FROM `data-project-487408.dogwood.user_events`

  UNION ALL
  SELECT 3, 'Onboarding: Which describes you best?',
    COUNTIF(onboarding_which_describes_you_ts IS NOT NULL),
    ROUND(100.0 * COUNTIF(onboarding_which_describes_you_ts IS NOT NULL) / COUNT(*), 1),
    FORMAT('%dd %dh %dm',
      CAST(FLOOR(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(onboarding_which_describes_you_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0) / 86400) AS INT64),
      CAST(FLOOR(MOD(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(onboarding_which_describes_you_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0), 86400) / 3600) AS INT64),
      CAST(FLOOR(MOD(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(onboarding_which_describes_you_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0), 3600) / 60) AS INT64)),
    FORMAT('%dd %dh %dm',
      CAST(FLOOR(GREATEST(AVG(TIMESTAMP_DIFF(onboarding_which_describes_you_ts, registration_timestamp, SECOND)), 0) / 86400) AS INT64),
      CAST(FLOOR(MOD(CAST(GREATEST(ROUND(AVG(TIMESTAMP_DIFF(onboarding_which_describes_you_ts, registration_timestamp, SECOND))), 0) AS INT64), 86400) / 3600) AS INT64),
      CAST(FLOOR(MOD(CAST(GREATEST(ROUND(AVG(TIMESTAMP_DIFF(onboarding_which_describes_you_ts, registration_timestamp, SECOND))), 0) AS INT64), 3600) / 60) AS INT64))
  FROM `data-project-487408.dogwood.user_events`

  UNION ALL
  SELECT 4, 'Onboarding: Categories',
    COUNTIF(onboarding_categories_ts IS NOT NULL),
    ROUND(100.0 * COUNTIF(onboarding_categories_ts IS NOT NULL) / COUNT(*), 1),
    FORMAT('%dd %dh %dm',
      CAST(FLOOR(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(onboarding_categories_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0) / 86400) AS INT64),
      CAST(FLOOR(MOD(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(onboarding_categories_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0), 86400) / 3600) AS INT64),
      CAST(FLOOR(MOD(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(onboarding_categories_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0), 3600) / 60) AS INT64)),
    FORMAT('%dd %dh %dm',
      CAST(FLOOR(GREATEST(AVG(TIMESTAMP_DIFF(onboarding_categories_ts, registration_timestamp, SECOND)), 0) / 86400) AS INT64),
      CAST(FLOOR(MOD(CAST(GREATEST(ROUND(AVG(TIMESTAMP_DIFF(onboarding_categories_ts, registration_timestamp, SECOND))), 0) AS INT64), 86400) / 3600) AS INT64),
      CAST(FLOOR(MOD(CAST(GREATEST(ROUND(AVG(TIMESTAMP_DIFF(onboarding_categories_ts, registration_timestamp, SECOND))), 0) AS INT64), 3600) / 60) AS INT64))
  FROM `data-project-487408.dogwood.user_events`

  UNION ALL
  SELECT 5, 'Onboarding: Brands',
    COUNTIF(onboarding_brands_ts IS NOT NULL),
    ROUND(100.0 * COUNTIF(onboarding_brands_ts IS NOT NULL) / COUNT(*), 1),
    FORMAT('%dd %dh %dm',
      CAST(FLOOR(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(onboarding_brands_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0) / 86400) AS INT64),
      CAST(FLOOR(MOD(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(onboarding_brands_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0), 86400) / 3600) AS INT64),
      CAST(FLOOR(MOD(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(onboarding_brands_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0), 3600) / 60) AS INT64)),
    FORMAT('%dd %dh %dm',
      CAST(FLOOR(GREATEST(AVG(TIMESTAMP_DIFF(onboarding_brands_ts, registration_timestamp, SECOND)), 0) / 86400) AS INT64),
      CAST(FLOOR(MOD(CAST(GREATEST(ROUND(AVG(TIMESTAMP_DIFF(onboarding_brands_ts, registration_timestamp, SECOND))), 0) AS INT64), 86400) / 3600) AS INT64),
      CAST(FLOOR(MOD(CAST(GREATEST(ROUND(AVG(TIMESTAMP_DIFF(onboarding_brands_ts, registration_timestamp, SECOND))), 0) AS INT64), 3600) / 60) AS INT64))
  FROM `data-project-487408.dogwood.user_events`

  UNION ALL
  SELECT 6, 'Onboarding: Budget',
    COUNTIF(onboarding_budget_ts IS NOT NULL),
    ROUND(100.0 * COUNTIF(onboarding_budget_ts IS NOT NULL) / COUNT(*), 1),
    FORMAT('%dd %dh %dm',
      CAST(FLOOR(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(onboarding_budget_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0) / 86400) AS INT64),
      CAST(FLOOR(MOD(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(onboarding_budget_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0), 86400) / 3600) AS INT64),
      CAST(FLOOR(MOD(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(onboarding_budget_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0), 3600) / 60) AS INT64)),
    FORMAT('%dd %dh %dm',
      CAST(FLOOR(GREATEST(AVG(TIMESTAMP_DIFF(onboarding_budget_ts, registration_timestamp, SECOND)), 0) / 86400) AS INT64),
      CAST(FLOOR(MOD(CAST(GREATEST(ROUND(AVG(TIMESTAMP_DIFF(onboarding_budget_ts, registration_timestamp, SECOND))), 0) AS INT64), 86400) / 3600) AS INT64),
      CAST(FLOOR(MOD(CAST(GREATEST(ROUND(AVG(TIMESTAMP_DIFF(onboarding_budget_ts, registration_timestamp, SECOND))), 0) AS INT64), 3600) / 60) AS INT64))
  FROM `data-project-487408.dogwood.user_events`

  UNION ALL
  SELECT 7, 'Onboarding complete',
    COUNTIF(onboarding_complete_ts IS NOT NULL),
    ROUND(100.0 * COUNTIF(onboarding_complete_ts IS NOT NULL) / COUNT(*), 1),
    FORMAT('%dd %dh %dm',
      CAST(FLOOR(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(onboarding_complete_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0) / 86400) AS INT64),
      CAST(FLOOR(MOD(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(onboarding_complete_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0), 86400) / 3600) AS INT64),
      CAST(FLOOR(MOD(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(onboarding_complete_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0), 3600) / 60) AS INT64)),
    FORMAT('%dd %dh %dm',
      CAST(FLOOR(GREATEST(AVG(TIMESTAMP_DIFF(onboarding_complete_ts, registration_timestamp, SECOND)), 0) / 86400) AS INT64),
      CAST(FLOOR(MOD(CAST(GREATEST(ROUND(AVG(TIMESTAMP_DIFF(onboarding_complete_ts, registration_timestamp, SECOND))), 0) AS INT64), 86400) / 3600) AS INT64),
      CAST(FLOOR(MOD(CAST(GREATEST(ROUND(AVG(TIMESTAMP_DIFF(onboarding_complete_ts, registration_timestamp, SECOND))), 0) AS INT64), 3600) / 60) AS INT64))
  FROM `data-project-487408.dogwood.user_events`

  UNION ALL
  SELECT 8, 'First homepage view',
    COUNTIF(first_home_ts IS NOT NULL),
    ROUND(100.0 * COUNTIF(first_home_ts IS NOT NULL) / COUNT(*), 1),
    FORMAT('%dd %dh %dm',
      CAST(FLOOR(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(first_home_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0) / 86400) AS INT64),
      CAST(FLOOR(MOD(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(first_home_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0), 86400) / 3600) AS INT64),
      CAST(FLOOR(MOD(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(first_home_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0), 3600) / 60) AS INT64)),
    FORMAT('%dd %dh %dm',
      CAST(FLOOR(GREATEST(AVG(TIMESTAMP_DIFF(first_home_ts, registration_timestamp, SECOND)), 0) / 86400) AS INT64),
      CAST(FLOOR(MOD(CAST(GREATEST(ROUND(AVG(TIMESTAMP_DIFF(first_home_ts, registration_timestamp, SECOND))), 0) AS INT64), 86400) / 3600) AS INT64),
      CAST(FLOOR(MOD(CAST(GREATEST(ROUND(AVG(TIMESTAMP_DIFF(first_home_ts, registration_timestamp, SECOND))), 0) AS INT64), 3600) / 60) AS INT64))
  FROM `data-project-487408.dogwood.user_events`

  UNION ALL
  SELECT 9, 'First collection view',
    COUNTIF(first_collection_ts IS NOT NULL),
    ROUND(100.0 * COUNTIF(first_collection_ts IS NOT NULL) / COUNT(*), 1),
    FORMAT('%dd %dh %dm',
      CAST(FLOOR(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(first_collection_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0) / 86400) AS INT64),
      CAST(FLOOR(MOD(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(first_collection_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0), 86400) / 3600) AS INT64),
      CAST(FLOOR(MOD(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(first_collection_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0), 3600) / 60) AS INT64)),
    FORMAT('%dd %dh %dm',
      CAST(FLOOR(GREATEST(AVG(TIMESTAMP_DIFF(first_collection_ts, registration_timestamp, SECOND)), 0) / 86400) AS INT64),
      CAST(FLOOR(MOD(CAST(GREATEST(ROUND(AVG(TIMESTAMP_DIFF(first_collection_ts, registration_timestamp, SECOND))), 0) AS INT64), 86400) / 3600) AS INT64),
      CAST(FLOOR(MOD(CAST(GREATEST(ROUND(AVG(TIMESTAMP_DIFF(first_collection_ts, registration_timestamp, SECOND))), 0) AS INT64), 3600) / 60) AS INT64))
  FROM `data-project-487408.dogwood.user_events`

  UNION ALL
  SELECT 10, 'First product view',
    COUNTIF(first_product_ts IS NOT NULL),
    ROUND(100.0 * COUNTIF(first_product_ts IS NOT NULL) / COUNT(*), 1),
    FORMAT('%dd %dh %dm',
      CAST(FLOOR(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(first_product_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0) / 86400) AS INT64),
      CAST(FLOOR(MOD(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(first_product_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0), 86400) / 3600) AS INT64),
      CAST(FLOOR(MOD(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(first_product_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0), 3600) / 60) AS INT64)),
    FORMAT('%dd %dh %dm',
      CAST(FLOOR(GREATEST(AVG(TIMESTAMP_DIFF(first_product_ts, registration_timestamp, SECOND)), 0) / 86400) AS INT64),
      CAST(FLOOR(MOD(CAST(GREATEST(ROUND(AVG(TIMESTAMP_DIFF(first_product_ts, registration_timestamp, SECOND))), 0) AS INT64), 86400) / 3600) AS INT64),
      CAST(FLOOR(MOD(CAST(GREATEST(ROUND(AVG(TIMESTAMP_DIFF(first_product_ts, registration_timestamp, SECOND))), 0) AS INT64), 3600) / 60) AS INT64))
  FROM `data-project-487408.dogwood.user_events`

  UNION ALL
  SELECT 11, 'First search',
    COUNTIF(first_search_ts IS NOT NULL),
    ROUND(100.0 * COUNTIF(first_search_ts IS NOT NULL) / COUNT(*), 1),
    FORMAT('%dd %dh %dm',
      CAST(FLOOR(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(first_search_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0) / 86400) AS INT64),
      CAST(FLOOR(MOD(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(first_search_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0), 86400) / 3600) AS INT64),
      CAST(FLOOR(MOD(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(first_search_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0), 3600) / 60) AS INT64)),
    FORMAT('%dd %dh %dm',
      CAST(FLOOR(GREATEST(AVG(TIMESTAMP_DIFF(first_search_ts, registration_timestamp, SECOND)), 0) / 86400) AS INT64),
      CAST(FLOOR(MOD(CAST(GREATEST(ROUND(AVG(TIMESTAMP_DIFF(first_search_ts, registration_timestamp, SECOND))), 0) AS INT64), 86400) / 3600) AS INT64),
      CAST(FLOOR(MOD(CAST(GREATEST(ROUND(AVG(TIMESTAMP_DIFF(first_search_ts, registration_timestamp, SECOND))), 0) AS INT64), 3600) / 60) AS INT64))
  FROM `data-project-487408.dogwood.user_events`

  UNION ALL
  SELECT 12, 'First vendor view',
    COUNTIF(first_vendor_ts IS NOT NULL),
    ROUND(100.0 * COUNTIF(first_vendor_ts IS NOT NULL) / COUNT(*), 1),
    FORMAT('%dd %dh %dm',
      CAST(FLOOR(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(first_vendor_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0) / 86400) AS INT64),
      CAST(FLOOR(MOD(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(first_vendor_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0), 86400) / 3600) AS INT64),
      CAST(FLOOR(MOD(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(first_vendor_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0), 3600) / 60) AS INT64)),
    FORMAT('%dd %dh %dm',
      CAST(FLOOR(GREATEST(AVG(TIMESTAMP_DIFF(first_vendor_ts, registration_timestamp, SECOND)), 0) / 86400) AS INT64),
      CAST(FLOOR(MOD(CAST(GREATEST(ROUND(AVG(TIMESTAMP_DIFF(first_vendor_ts, registration_timestamp, SECOND))), 0) AS INT64), 86400) / 3600) AS INT64),
      CAST(FLOOR(MOD(CAST(GREATEST(ROUND(AVG(TIMESTAMP_DIFF(first_vendor_ts, registration_timestamp, SECOND))), 0) AS INT64), 3600) / 60) AS INT64))
  FROM `data-project-487408.dogwood.user_events`

  UNION ALL
  SELECT 13, 'First order',
    COUNTIF(first_order_ts IS NOT NULL),
    ROUND(100.0 * COUNTIF(first_order_ts IS NOT NULL) / COUNT(*), 1),
    FORMAT('%dd %dh %dm',
      CAST(FLOOR(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(first_order_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0) / 86400) AS INT64),
      CAST(FLOOR(MOD(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(first_order_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0), 86400) / 3600) AS INT64),
      CAST(FLOOR(MOD(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(first_order_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0), 3600) / 60) AS INT64)),
    FORMAT('%dd %dh %dm',
      CAST(FLOOR(GREATEST(AVG(TIMESTAMP_DIFF(first_order_ts, registration_timestamp, SECOND)), 0) / 86400) AS INT64),
      CAST(FLOOR(MOD(CAST(GREATEST(ROUND(AVG(TIMESTAMP_DIFF(first_order_ts, registration_timestamp, SECOND))), 0) AS INT64), 86400) / 3600) AS INT64),
      CAST(FLOOR(MOD(CAST(GREATEST(ROUND(AVG(TIMESTAMP_DIFF(first_order_ts, registration_timestamp, SECOND))), 0) AS INT64), 3600) / 60) AS INT64))
  FROM `data-project-487408.dogwood.user_events`

  UNION ALL
  SELECT 14, 'Second order',
    COUNTIF(second_order_ts IS NOT NULL),
    ROUND(100.0 * COUNTIF(second_order_ts IS NOT NULL) / COUNT(*), 1),
    FORMAT('%dd %dh %dm',
      CAST(FLOOR(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(second_order_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0) / 86400) AS INT64),
      CAST(FLOOR(MOD(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(second_order_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0), 86400) / 3600) AS INT64),
      CAST(FLOOR(MOD(GREATEST(APPROX_QUANTILES(TIMESTAMP_DIFF(second_order_ts, registration_timestamp, SECOND), 100)[OFFSET(50)], 0), 3600) / 60) AS INT64)),
    FORMAT('%dd %dh %dm',
      CAST(FLOOR(GREATEST(AVG(TIMESTAMP_DIFF(second_order_ts, registration_timestamp, SECOND)), 0) / 86400) AS INT64),
      CAST(FLOOR(MOD(CAST(GREATEST(ROUND(AVG(TIMESTAMP_DIFF(second_order_ts, registration_timestamp, SECOND))), 0) AS INT64), 86400) / 3600) AS INT64),
      CAST(FLOOR(MOD(CAST(GREATEST(ROUND(AVG(TIMESTAMP_DIFF(second_order_ts, registration_timestamp, SECOND))), 0) AS INT64), 3600) / 60) AS INT64))
  FROM `data-project-487408.dogwood.user_events`

)
ORDER BY sort_order;
