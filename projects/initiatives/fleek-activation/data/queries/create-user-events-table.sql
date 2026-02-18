-- Step 1: Create user_events table (run once, stores ~170K rows)
-- One row per registered user with:
--   - First timestamp for each funnel step
--   - Count of events before first order for browse/engagement steps
-- Run this first, then use funnel-summary.sql for aggregations

CREATE OR REPLACE TABLE `data-project-487408.dogwood.user_events` AS

WITH registrations AS (
  SELECT
    anonymous_id,
    registration_timestamp,
    CAST(REGEXP_EXTRACT(user_id, r'Customer/(\d+)') AS INT64) as customer_id
  FROM `data-project-487408.dogwood.registrations`
  WHERE registration_timestamp >= '2024-01-01'
),
onboarding_started AS (
  SELECT os.anonymous_id, MIN(os.onboarding_started_timestamp) as first_ts
  FROM `data-project-487408.dogwood.onboarding_started` os
  JOIN registrations r ON os.anonymous_id = r.anonymous_id
  WHERE os.onboarding_started_timestamp >= r.registration_timestamp
  GROUP BY os.anonymous_id
),
onboarding_which_describes_you AS (
  SELECT ob.anonymous_id, MIN(ob.onboarding_submitted_timestamp) as first_ts
  FROM `data-project-487408.dogwood.onboarding_submitted` ob
  JOIN registrations r ON ob.anonymous_id = r.anonymous_id
  WHERE ob.flow_status = 'PLATFORM_STORE_IDENTIFICATION'
  AND ob.onboarding_submitted_timestamp >= r.registration_timestamp
  GROUP BY ob.anonymous_id
),
onboarding_categories AS (
  SELECT ob.anonymous_id, MIN(ob.onboarding_submitted_timestamp) as first_ts
  FROM `data-project-487408.dogwood.onboarding_submitted` ob
  JOIN registrations r ON ob.anonymous_id = r.anonymous_id
  WHERE ob.flow_status = 'CATEGORY'
  AND ob.onboarding_submitted_timestamp >= r.registration_timestamp
  GROUP BY ob.anonymous_id
),
onboarding_brands AS (
  SELECT ob.anonymous_id, MIN(ob.onboarding_submitted_timestamp) as first_ts
  FROM `data-project-487408.dogwood.onboarding_submitted` ob
  JOIN registrations r ON ob.anonymous_id = r.anonymous_id
  WHERE ob.flow_status = 'BRAND'
  AND ob.onboarding_submitted_timestamp >= r.registration_timestamp
  GROUP BY ob.anonymous_id
),
onboarding_budget AS (
  SELECT ob.anonymous_id, MIN(ob.onboarding_submitted_timestamp) as first_ts
  FROM `data-project-487408.dogwood.onboarding_submitted` ob
  JOIN registrations r ON ob.anonymous_id = r.anonymous_id
  WHERE ob.flow_status = 'BUDGET'
  AND ob.onboarding_submitted_timestamp >= r.registration_timestamp
  GROUP BY ob.anonymous_id
),
onboarding_complete AS (
  SELECT ob.anonymous_id, MIN(ob.onboarding_submitted_timestamp) as first_ts
  FROM `data-project-487408.dogwood.onboarding_submitted` ob
  JOIN registrations r ON ob.anonymous_id = r.anonymous_id
  WHERE ob.flow_status = 'COMPLETED'
  AND ob.onboarding_submitted_timestamp >= r.registration_timestamp
  GROUP BY ob.anonymous_id
),
home_views AS (
  SELECT hv.anonymous_id, MIN(hv.view_timestamp) as first_ts, COUNT(*) as total_count
  FROM `data-project-487408.dogwood.homescreen_views` hv
  JOIN registrations r ON hv.anonymous_id = r.anonymous_id
  WHERE hv.view_timestamp >= r.registration_timestamp
  GROUP BY hv.anonymous_id
),
collection_views AS (
  SELECT cv.anonymous_id, MIN(cv.view_timestamp) as first_ts, COUNT(*) as total_count
  FROM `data-project-487408.dogwood.collection_views` cv
  JOIN registrations r ON cv.anonymous_id = r.anonymous_id
  WHERE cv.view_timestamp >= r.registration_timestamp
  GROUP BY cv.anonymous_id
),
product_views AS (
  SELECT pv.anonymous_id, MIN(pv.view_timestamp) as first_ts, COUNT(*) as total_count
  FROM `data-project-487408.dogwood.product_views` pv
  JOIN registrations r ON pv.anonymous_id = r.anonymous_id
  WHERE pv.view_timestamp >= r.registration_timestamp
  GROUP BY pv.anonymous_id
),
searches AS (
  SELECT s.anonymous_id, MIN(s.search_timestamp) as first_ts, COUNT(*) as total_count
  FROM `data-project-487408.dogwood.searches` s
  JOIN registrations r ON s.anonymous_id = r.anonymous_id
  WHERE s.search_timestamp >= r.registration_timestamp
  GROUP BY s.anonymous_id
),
vendor_views AS (
  SELECT vv.anonymous_id, MIN(vv.view_timestamp) as first_ts, COUNT(*) as total_count
  FROM `data-project-487408.dogwood.vendor_page_views` vv
  JOIN registrations r ON vv.anonymous_id = r.anonymous_id
  WHERE vv.view_timestamp >= r.registration_timestamp
  GROUP BY vv.anonymous_id
),
first_orders AS (
  SELECT customer_id, MIN(order_timestamp) as first_ts
  FROM `data-project-487408.dogwood.orders`
  WHERE total_price > 0
  GROUP BY customer_id
),
second_orders AS (
  SELECT customer_id, order_timestamp as first_ts
  FROM (
    SELECT customer_id, order_timestamp,
           ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_timestamp) as rn
    FROM `data-project-487408.dogwood.orders`
    WHERE total_price > 0
  )
  WHERE rn = 2
),

-- Pre-order counts: count events only before first order timestamp
home_views_pre_order AS (
  SELECT hv.anonymous_id, COUNT(*) as count_before_order
  FROM `data-project-487408.dogwood.homescreen_views` hv
  JOIN `data-project-487408.dogwood.registrations` r ON hv.anonymous_id = r.anonymous_id
  JOIN first_orders fo ON CAST(REGEXP_EXTRACT(r.user_id, r'Customer/(\d+)') AS INT64) = fo.customer_id
  WHERE hv.view_timestamp < fo.first_ts
  GROUP BY hv.anonymous_id
),
collection_views_pre_order AS (
  SELECT cv.anonymous_id, COUNT(*) as count_before_order
  FROM `data-project-487408.dogwood.collection_views` cv
  JOIN `data-project-487408.dogwood.registrations` r ON cv.anonymous_id = r.anonymous_id
  JOIN first_orders fo ON CAST(REGEXP_EXTRACT(r.user_id, r'Customer/(\d+)') AS INT64) = fo.customer_id
  WHERE cv.view_timestamp < fo.first_ts
  GROUP BY cv.anonymous_id
),
product_views_pre_order AS (
  SELECT pv.anonymous_id, COUNT(*) as count_before_order
  FROM `data-project-487408.dogwood.product_views` pv
  JOIN `data-project-487408.dogwood.registrations` r ON pv.anonymous_id = r.anonymous_id
  JOIN first_orders fo ON CAST(REGEXP_EXTRACT(r.user_id, r'Customer/(\d+)') AS INT64) = fo.customer_id
  WHERE pv.view_timestamp < fo.first_ts
  GROUP BY pv.anonymous_id
),
searches_pre_order AS (
  SELECT s.anonymous_id, COUNT(*) as count_before_order
  FROM `data-project-487408.dogwood.searches` s
  JOIN `data-project-487408.dogwood.registrations` r ON s.anonymous_id = r.anonymous_id
  JOIN first_orders fo ON CAST(REGEXP_EXTRACT(r.user_id, r'Customer/(\d+)') AS INT64) = fo.customer_id
  WHERE s.search_timestamp < fo.first_ts
  GROUP BY s.anonymous_id
),
vendor_views_pre_order AS (
  SELECT vv.anonymous_id, COUNT(*) as count_before_order
  FROM `data-project-487408.dogwood.vendor_page_views` vv
  JOIN `data-project-487408.dogwood.registrations` r ON vv.anonymous_id = r.anonymous_id
  JOIN first_orders fo ON CAST(REGEXP_EXTRACT(r.user_id, r'Customer/(\d+)') AS INT64) = fo.customer_id
  WHERE vv.view_timestamp < fo.first_ts
  GROUP BY vv.anonymous_id
)

SELECT
  r.anonymous_id,
  r.customer_id,
  r.registration_timestamp,

  -- Onboarding steps
  os.first_ts    as onboarding_started_ts,
  wd.first_ts    as onboarding_which_describes_you_ts,
  ocat.first_ts  as onboarding_categories_ts,
  obr.first_ts   as onboarding_brands_ts,
  obud.first_ts  as onboarding_budget_ts,
  oc.first_ts    as onboarding_complete_ts,

  -- First timestamps (all users)
  hv.first_ts   as first_home_ts,
  cv.first_ts   as first_collection_ts,
  pv.first_ts   as first_product_ts,
  s.first_ts    as first_search_ts,
  vv.first_ts   as first_vendor_ts,

  -- Total event counts (all time, including non-purchasers)
  hv.total_count   as home_view_count_total,
  cv.total_count   as collection_view_count_total,
  pv.total_count   as product_view_count_total,
  s.total_count    as search_count_total,
  vv.total_count   as vendor_view_count_total,

  -- Event counts before first order (purchasers only, null for non-purchasers)
  hpo.count_before_order  as home_view_count_pre_order,
  cpo.count_before_order  as collection_view_count_pre_order,
  pvpo.count_before_order as product_view_count_pre_order,
  spo.count_before_order  as search_count_pre_order,
  vvpo.count_before_order as vendor_view_count_pre_order,

  -- Orders
  fo.first_ts   as first_order_ts,
  so.first_ts   as second_order_ts

FROM registrations r
LEFT JOIN onboarding_started os            ON r.anonymous_id = os.anonymous_id
LEFT JOIN onboarding_which_describes_you wd ON r.anonymous_id = wd.anonymous_id
LEFT JOIN onboarding_categories ocat       ON r.anonymous_id = ocat.anonymous_id
LEFT JOIN onboarding_brands obr            ON r.anonymous_id = obr.anonymous_id
LEFT JOIN onboarding_budget obud           ON r.anonymous_id = obud.anonymous_id
LEFT JOIN onboarding_complete oc           ON r.anonymous_id = oc.anonymous_id
LEFT JOIN home_views hv            ON r.anonymous_id = hv.anonymous_id
LEFT JOIN collection_views cv      ON r.anonymous_id = cv.anonymous_id
LEFT JOIN product_views pv         ON r.anonymous_id = pv.anonymous_id
LEFT JOIN searches s               ON r.anonymous_id = s.anonymous_id
LEFT JOIN vendor_views vv          ON r.anonymous_id = vv.anonymous_id
LEFT JOIN home_views_pre_order hpo     ON r.anonymous_id = hpo.anonymous_id
LEFT JOIN collection_views_pre_order cpo ON r.anonymous_id = cpo.anonymous_id
LEFT JOIN product_views_pre_order pvpo   ON r.anonymous_id = pvpo.anonymous_id
LEFT JOIN searches_pre_order spo         ON r.anonymous_id = spo.anonymous_id
LEFT JOIN vendor_views_pre_order vvpo    ON r.anonymous_id = vvpo.anonymous_id
LEFT JOIN first_orders fo          ON r.customer_id = fo.customer_id
LEFT JOIN second_orders so         ON r.customer_id = so.customer_id;
