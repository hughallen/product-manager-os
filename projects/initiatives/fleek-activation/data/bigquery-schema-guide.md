# BigQuery Dataset Guide - Dogwood

**Project:** `data-project-487408`  
**Dataset:** `dogwood`  
**Purpose:** Navigation guide for Fleek activation analysis

---

## Assistance Navigating the Data

### **Join Patterns**

#### **1. Event Tables to Orders: Extract numeric from GID user_id**

*Only works for rows where user_id is GID format*

```sql
CAST(orders.customer_id AS STRING) = REGEXP_EXTRACT(registrations.user_id, r'Customer/(\d+)')
```

#### **2. Direct Joins (No Transformation)**

```sql
-- Orders to order lines
orders.order_id = order_lines.order_id -- (100% match)

-- Messages to orders
messages.customer_id = orders.customer_id -- (25% of message customers have orders)

-- Order lines to product views
order_lines.vendor = product_views.vendor -- (99.9% match)

-- Order lines to vendor page views
order_lines.vendor = vendor_page_views.vendor_handle -- (98.4% match)

-- Messages to order lines
messages.vendor = order_lines.vendor
```

#### **3. Product ID Join: Extract numeric from GID**

*order_lines.product_id is INT64, product_views.product_id is GID STRING*

```sql
CAST(order_lines.product_id AS STRING) = REGEXP_EXTRACT(product_views.product_id, r'Product/(\d+)')
```

#### **4. Orders to User Mapping: Extract numeric from GID**

*orders.customer_id is INT64, user_mapping.shopify_user_id is GID STRING*

```sql
CAST(orders.customer_id AS STRING) = REGEXP_EXTRACT(user_mapping.shopify_user_id, r'Customer/(\d+)')
```

#### **5. Event Tables Join via anonymous_id (RECOMMENDED)**

*All event tables (product_views, homescreen_views, searches, etc.) use anonymous_id for cross-event joins*

```sql
-- Join registrations to product views
registrations.anonymous_id = product_views.anonymous_id

-- Join registrations to homescreen views
registrations.anonymous_id = homescreen_views.anonymous_id

-- Join onboarding to any event table
onboarding_submitted.anonymous_id = searches.anonymous_id
```

---

## **Table Schemas**

### **orders**

*Row count: 53,389*

| **Column** | **Type** | **Description** |
| --- | --- | --- |
| order_id | INT64 | Unique order identifier |
| customer_id | INT64 | Shopify customer ID (numeric) |
| order_timestamp | TIMESTAMP | Order creation time |
| currency | STRING | Currency code |
| total_price | FLOAT64 | Total order price |
| subtotal_price | FLOAT64 | Subtotal before discounts |
| total_discounts | FLOAT64 | Total discounts applied |
| financial_status | STRING | Payment status |
| fulfillment_status | STRING | Fulfillment status |
| country_code | STRING | Customer country |

**Key for Activation Analysis:**
- First order per customer = activation event
- Join to registrations via GID extraction
- `order_timestamp` - `registration_timestamp` = time to activation

---

### **order_lines**

*Row count: 85,190*

| **Column** | **Type** | **Description** |
| --- | --- | --- |
| order_line_id | INT64 | Unique line item ID |
| order_id | INT64 | Parent order ID |
| product_id | INT64 | Product ID (numeric) |
| variant_id | INT64 | Product variant ID |
| quantity | INT64 | Quantity ordered |
| price | FLOAT64 | Line item price |
| vendor | STRING | Vendor handle |
| title | STRING | Product title |

**Key for Activation Analysis:**
- Analyze bundle sizes via `quantity`
- Identify vendor specialization patterns
- Track product preferences

---

### **user_mapping**

*Row count: 600,777*

| **Column** | **Type** | **Description** |
| --- | --- | --- |
| user_id | INT64 | Internal user ID |
| shopify_user_id | STRING | Shopify GID format: gid://shopify/Customer/XXXXX |
| created_at | DATETIME | User creation time |

**Key for Activation Analysis:**
- Bridge table between internal and Shopify IDs
- Use for persona mapping if persona data exists elsewhere

---

### **messages**

*Row count: 13,369,947*

| **Column** | **Type** | **Description** |
| --- | --- | --- |
| customer_id | INT64 | Shopify customer ID (numeric) - joins directly to orders.customer_id |
| vendor | STRING | Vendor handle |
| sender_type | STRING | 'buyer' or 'vendor' |
| channel_channel_url | STRING | Conversation channel URL |
| payload_message | STRING | Message content |
| timestamp | TIMESTAMP | Message timestamp |

**Key for Activation Analysis:**
- Does messaging correlate with first purchase?
- Messaging as trust signal indicator
- Vendor engagement patterns

---

### **product_views**

*Row count: 17,757,344*

| **Column** | **Type** | **Description** |
| --- | --- | --- |
| user_id | STRING | Mixed format: GID (70%) or UUID (30%) - use anonymous_id for joins |
| anonymous_id | STRING | UUID format - **USE THIS FOR JOINS** |
| view_timestamp | TIMESTAMP | View time |
| platform | STRING | Platform (ios/android/web) |
| product_id | STRING | Product GID: gid://shopify/Product/XXXXX |
| vendor | STRING | Vendor handle |
| price | INT64 | Product price |

**Key for Activation Analysis:**
- Browse vs search behavior (compare to searches table)
- Product engagement before first purchase
- Price point exploration patterns
- **Use anonymous_id for joins to registrations**

---

### **vendor_page_views**

*Row count: 436,975*

| **Column** | **Type** | **Description** |
| --- | --- | --- |
| user_id | STRING | Mixed format: GID (25%) or UUID (75%) - use anonymous_id for joins |
| anonymous_id | STRING | UUID format - **USE THIS FOR JOINS** |
| view_timestamp | TIMESTAMP | View time |
| platform | STRING | Platform |
| device_type | STRING | Device type |
| os | STRING | Operating system |
| vendor_handle | STRING | Vendor handle |

**Key for Activation Analysis:**
- Supplier evaluation behavior
- Trust-building activity (viewing supplier = research)
- **Opportunity 2**: Supplier rating analysis (if rating data available)

---

### **collection_views**

*Row count: 4,718,445*

| **Column** | **Type** | **Description** |
| --- | --- | --- |
| user_id | STRING | Mixed format: GID (39%) or UUID (53%) - use anonymous_id for joins |
| anonymous_id | STRING | UUID format - **USE THIS FOR JOINS** |
| view_timestamp | TIMESTAMP | View time |
| platform | STRING | Platform |
| device_type | STRING | Device type |
| os | STRING | Operating system |
| collection_name | STRING | Collection name |

**Key for Activation Analysis:**
- Discovery behavior (browse-first users)
- **Opportunity 18**: Cognitive overload analysis
- Collection engagement patterns

---

### **homescreen_views**

*Row count: 7,127,464*

| **Column** | **Type** | **Description** |
| --- | --- | --- |
| user_id | STRING | Mixed format: GID (68%) or UUID (28%) - use anonymous_id for joins |
| anonymous_id | STRING | UUID format - **USE THIS FOR JOINS** |
| view_timestamp | TIMESTAMP | View time |
| platform | STRING | Platform |
| device_type | STRING | Device type |
| os | STRING | Operating system |

**Key for Activation Analysis:**
- Homepage engagement after onboarding
- **Opportunity 13**: Generic homepage issue
- **Opportunity 12**: Personalization feedback loop

---

### **searches**

*Row count: 2,158,080*

| **Column** | **Type** | **Description** |
| --- | --- | --- |
| user_id | STRING | Mixed format: GID (73%) or UUID (27%) - use anonymous_id for joins |
| anonymous_id | STRING | UUID format - **USE THIS FOR JOINS** |
| search_timestamp | TIMESTAMP | Search time |
| platform | STRING | Platform |
| search_term | STRING | Search query |

**Key for Activation Analysis:**
- Browse vs search behavior
- **Opportunity 19**: "Don't know what to search for"
- Search term analysis for product discovery patterns

---

### **registrations**

*Row count: 336,088*

| **Column** | **Type** | **Description** |
| --- | --- | --- |
| user_id | STRING | GID format (100%): gid://shopify/Customer/XXXXX |
| anonymous_id | STRING | UUID format - **USE THIS FOR JOINS** to other event tables |
| registration_timestamp | TIMESTAMP | Registration time |
| platform | STRING | Platform |
| device_type | STRING | Device type |
| os | STRING | Operating system |
| customer_type | STRING | Customer type |

**Key for Activation Analysis:**
- Starting point for activation funnel
- **Use anonymous_id to join to all event tables**
- `customer_type` may indicate persona
- Platform analysis (mobile vs desktop)

---

### **onboarding_started**

*Row count: 120,679*

| **Column** | **Type** | **Description** |
| --- | --- | --- |
| user_id | STRING | GID format (100%): gid://shopify/Customer/XXXXX |
| anonymous_id | STRING | UUID format - **USE THIS FOR JOINS** |
| onboarding_started_timestamp | TIMESTAMP | Start time |
| platform | STRING | Platform |
| device_type | STRING | Device type |
| os | STRING | Operating system |

**Key for Activation Analysis:**
- Onboarding drop-off analysis (started vs submitted)
- **Parent B Opportunities**: Onboarding friction
- Time between registration and onboarding start

---

### **onboarding_submitted**

*Row count: 382,044*

| **Column** | **Type** | **Description** |
| --- | --- | --- |
| user_id | STRING | GID format (100%): gid://shopify/Customer/XXXXX |
| anonymous_id | STRING | UUID format - **USE THIS FOR JOINS** |
| onboarding_submitted_timestamp | TIMESTAMP | Submit time |
| platform | STRING | Platform |
| device_type | STRING | Device type |
| os | STRING | Operating system |
| screen_type | STRING | Screen type |
| purchase_tier | STRING | Purchase tier selected (PERSONA INDICATOR!) |
| user_intent | STRING | User intent (PERSONA INDICATOR!) |
| flow_status | STRING | Flow status |
| data_brands | STRING | Selected brands |
| data_categories | STRING | Selected categories |
| data_selected_entity_count | INT64 | Number of entities selected |

**Key for Activation Analysis:**
- **CRITICAL**: `purchase_tier` and `user_intent` = persona identification!
- Personalization data captured here
- **Opportunity 12-13**: Does personalization work?
- Brand/category preferences for personalization validation

---

## Critical Unknowns Mapped to Tables

### 1. **Which persona has activation problem?**

**Query approach:**
```sql
-- Join onboarding_submitted (purchase_tier, user_intent) to orders
-- Calculate activation rate by persona
```

**Tables needed:**
- `registrations` (starting cohort)
- `onboarding_submitted` (purchase_tier = persona)
- `orders` (activation event)

---

### 2. **Where do users drop off?**

**Funnel stages:**
1. `registrations` → Signup
2. `onboarding_started` → Started onboarding
3. `onboarding_submitted` → Completed onboarding
4. `homescreen_views` → Viewed homepage
5. `product_views` → Viewed products
6. `vendor_page_views` → Viewed suppliers (optional)
7. `orders` → First purchase (ACTIVATION!)

---

### 3. **Does personalization work?**

**Query approach:**
```sql
-- Compare homescreen_views patterns for users who completed onboarding
-- vs didn't complete onboarding
-- Analyze data_brands/data_categories from onboarding_submitted
-- vs product_views vendor/category
```

**Tables needed:**
- `onboarding_submitted` (preferences)
- `product_views` (actual views)
- `homescreen_views` (engagement)

---

### 4. **Browse vs search behavior?**

**Query approach:**
```sql
-- Users with searches.search_timestamp vs users with product_views only
-- Activation rate comparison
```

**Tables needed:**
- `registrations`
- `searches`
- `product_views`
- `orders`

---

### 5. **Desktop vs mobile conversion?**

**Query approach:**
```sql
-- Activation rate by platform
-- Analyze platform from registrations
```

**Tables needed:**
- `registrations` (platform)
- `orders`
- All event tables (platform field)

---

## Sample Queries

### Activation Funnel

```sql
WITH cohort AS (
  SELECT 
    REGEXP_EXTRACT(user_id, r'Customer/(\d+)') as customer_id,
    anonymous_id,
    registration_timestamp,
    platform,
    customer_type
  FROM `data-project-487408.dogwood.registrations`
  WHERE registration_timestamp >= '2024-01-01'
),
first_orders AS (
  SELECT
    customer_id,
    MIN(order_timestamp) as first_order_timestamp
  FROM `data-project-487408.dogwood.orders`
  GROUP BY customer_id
)
SELECT
  COUNT(DISTINCT c.customer_id) as total_registrations,
  COUNT(DISTINCT o.customer_id) as activated_users,
  COUNT(DISTINCT o.customer_id) / COUNT(DISTINCT c.customer_id) as activation_rate,
  AVG(TIMESTAMP_DIFF(o.first_order_timestamp, c.registration_timestamp, DAY)) as avg_days_to_activation
FROM cohort c
LEFT JOIN first_orders o ON c.customer_id = CAST(o.customer_id AS STRING)
```

### Onboarding Completion by Persona

```sql
WITH onboarding AS (
  SELECT
    REGEXP_EXTRACT(user_id, r'Customer/(\d+)') as customer_id,
    purchase_tier,
    user_intent,
    onboarding_submitted_timestamp
  FROM `data-project-487408.dogwood.onboarding_submitted`
),
first_orders AS (
  SELECT
    customer_id,
    MIN(order_timestamp) as first_order_timestamp
  FROM `data-project-487408.dogwood.orders`
  GROUP BY customer_id
)
SELECT
  o.purchase_tier,
  o.user_intent,
  COUNT(DISTINCT o.customer_id) as completed_onboarding,
  COUNT(DISTINCT f.customer_id) as activated,
  COUNT(DISTINCT f.customer_id) / COUNT(DISTINCT o.customer_id) as activation_rate
FROM onboarding o
LEFT JOIN first_orders f ON o.customer_id = CAST(f.customer_id AS STRING)
GROUP BY o.purchase_tier, o.user_intent
ORDER BY activation_rate DESC
```

---

## Tips for Analysis

### Use anonymous_id for Event Joins

**✅ CORRECT:**
```sql
FROM registrations r
LEFT JOIN product_views pv ON r.anonymous_id = pv.anonymous_id
```

**❌ INCORRECT:**
```sql
FROM registrations r
LEFT JOIN product_views pv ON r.user_id = pv.user_id -- Mixed formats!
```

### Extract Customer ID from GID

**✅ CORRECT:**
```sql
REGEXP_EXTRACT(user_id, r'Customer/(\d+)')
```

**❌ INCORRECT:**
```sql
CAST(user_id AS INT64) -- Will fail on GID format
```

### Date Filtering for Performance

Always filter by timestamp to reduce data scanned:

```sql
WHERE registration_timestamp >= '2024-01-01'
AND registration_timestamp < '2025-01-01'
```

---

## User Type / Cohort Definitions

### **Primary Field: `registrations.customer_type`**

The three onboarding options map to this field:

| Onboarding Option | Database Value | Description |
|-------------------|----------------|-------------|
| **"Online seller"** | `reseller` | 291,489 users (87%) - Selling online (Vinted, Depop, etc.) |
| **"Physical seller"** | `retailer` | 44,579 users (13%) - Brick-and-mortar stores |
| **"Just getting started"** | Subset of above | Identified by `user_intent = 'TO_EARN_EXTRA_MONEY'` |

### **Cohort Segmentation Query**

```sql
SELECT
  -- Base user type
  r.customer_type,
  
  -- Persona indicators
  CASE 
    WHEN r.customer_type = 'reseller' 
      AND o.user_intent = 'TO_EARN_EXTRA_MONEY' 
      AND o.purchase_tier IN ('not_defined', 'Small_Buyer')
    THEN 'Just Getting Started (Reseller)'
    
    WHEN r.customer_type = 'reseller' 
      AND o.purchase_tier = 'Small_Buyer'
    THEN 'Small Online Seller'
    
    WHEN r.customer_type = 'reseller' 
      AND o.purchase_tier = 'Larger_Buyer'
    THEN 'Scale Online Seller'
    
    WHEN r.customer_type = 'retailer' 
      AND o.purchase_tier IN ('Small_Buyer', 'not_defined')
    THEN 'Small Physical Retailer'
    
    WHEN r.customer_type = 'retailer' 
      AND o.purchase_tier = 'Larger_Buyer'
    THEN 'Wholesale Physical Retailer'
    
    WHEN r.customer_type = 'reseller'
    THEN 'Online Seller (No Tier)'
    
    WHEN r.customer_type = 'retailer'
    THEN 'Physical Seller (No Tier)'
    
    ELSE 'Unknown'
  END as cohort,
  
  COUNT(DISTINCT r.anonymous_id) as user_count
FROM `data-project-487408.dogwood.registrations` r
LEFT JOIN (
  SELECT DISTINCT anonymous_id, purchase_tier, user_intent
  FROM `data-project-487408.dogwood.onboarding_submitted`
) o ON r.anonymous_id = o.anonymous_id
WHERE r.registration_timestamp >= '2024-01-01'
GROUP BY r.customer_type, cohort
ORDER BY user_count DESC
```

### **CRITICAL FINDING: Onboarding Completion Rates**

| Metric | Count | % |
|--------|-------|---|
| Total registrations (2024+) | 170,093 | 100% |
| Skipped onboarding entirely | 170,093 | 100% |
| Completed purchase_tier | 28,992 + 23,948 + 1,322 = 54,262 | 32% |
| Completed user_intent | 19,732 + 8,026 + 4,668 = 32,426 | 19% |

**This validates Opportunities 7, 10, 11** (onboarding friction)!

---

## Next Steps for Fleek Analysis

1. **Cohort Identification**: Use `customer_type` + `purchase_tier` + `user_intent` to define cohorts
2. **Activation Funnel by Cohort**: Calculate drop-off rates at each stage per cohort
3. **Onboarding Impact**: Does completing onboarding correlate with activation?
4. **Opportunity Validation**: Map data findings to 23 opportunities ranked by evidence

---

**Related Files:**
- Opportunities: `../opportunities/activation/opportunities-activation-v1.md`
- Metrics: `../../product-artifacts/metrics/fleek-activation-metrics.md`
- UX Audit: `./ux-analysis/fleek-current-state.md`
