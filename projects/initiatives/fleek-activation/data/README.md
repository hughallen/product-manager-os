# Data & Analytics - Continuous

**Purpose:** Analytics, metrics, and data analysis informing both discovery and delivery tracks

---

## Folder Contents

```
data/
├── ux-analysis/          # UX audit and competitor research (moved from root)
│   ├── fleek-current-state.md
│   └── screenshots/
└── README.md
```

---

## Data Needs (Priority Order)

### 1. Persona Diagnosis (CRITICAL)
**Question:** Which segment has activation problem?

**Queries Needed:**
- User segmentation by budget, order size, behavior
- Activation rate by segment (signup → first purchase within 30 days)
- Funnel analysis by segment
- Time to first purchase by segment

**Success Criteria:** Identify persona with significantly lower activation

---

### 2. Funnel Analysis
**Question:** Where do users drop off?

**Stages:**
1. Signup
2. Browse (view suppliers)
3. Supplier click
4. Bundle view
5. Add to cart
6. Checkout
7. First purchase

**Metrics:** Conversion rate at each stage, by persona

---

### 3. Root Cause Validation
**Question:** What blocks conversion?

**Tests:**
- Budget: Do users only view expensive bundles (£400+) then drop?
- Trust: Do users who view reviews convert less?
- Uncertainty: Do users view many bundles but not add to cart?
- Desktop: Do Persona 3 users on web convert worse than app?

---

### 4. Baseline Metrics
**Current performance to improve from:**
- Overall activation rate (signup → first purchase, 30 days)
- By persona (Beginner, Scale, Wholesale)
- By channel (organic, paid, referral)
- Time to first purchase (median, p75, p90)

---

## Metrics Framework

See: `projects/product-artifacts/metrics/fleek-activation-metrics.md`

**North Star Candidates:**
- Monthly Active Buyers (making at least 1 purchase)
- First Purchase Conversion (signup → purchase within 30d)

**Primary Metrics:**
- Activation rate by persona
- Time to first purchase
- First → second purchase retention

---

## Analysis Timeline

**24 hours before interview (per Hannah):**
- Run all persona diagnosis queries
- Create funnel visualizations
- Identify drop-off points
- Validate root causes with data
- Prepare findings presentation

---

## Next Steps

1. Hugh gets database access
2. Write SQL queries for persona segmentation
3. Run funnel analysis
4. Create data visualizations
5. Present findings before solution design
