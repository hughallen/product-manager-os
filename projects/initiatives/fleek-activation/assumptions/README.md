# Assumptions Testing - Discovery Track

**Purpose:** Test key assumptions before building solutions

---

## Framework: Assumption Testing

Per Continuous Discovery Habits (`@pm-toolkit/2-discovery/continuous-discovery-habits/identify-and-test-assumptions.mdc`):

1. **Identify assumptions** in solutions
2. **Prioritize by risk** (high risk = test first)
3. **Design tests** (cheapest way to validate/invalidate)
4. **Run tests** (interviews, prototypes, data analysis)
5. **Learn and iterate**

---

## Critical Assumptions (Pending Data)

### Assumption 1: Beginner Resellers Have Activation Problem
**Risk:** HIGH - Entire solution approach depends on this  
**Test:** Data analysis - segment users, compare activation rates  
**Status:** ❓ Not tested yet - need database access

---

### Assumption 2: Trust is Primary Blocker
**Evidence:** ✅ User quotes confirm trust concerns exist  
**Assumption:** ⚠️ Trust is THE blocker (vs other factors)  
**Test:** Funnel analysis - do users who view reviews convert less?  
**Status:** ❓ Not tested

---

### Assumption 3: Small Bundles Exist But Aren't Discoverable
**Assumption:** Platform has 10-20 piece bundles at £50-200 but users can't find them  
**Test:** Product audit - catalog bundle sizes and prices, heatmap analysis  
**Status:** ❓ Not tested

---

### Assumption 4: Budget is Hard Constraint
**Evidence:** ✅ User quotes mention £400-500 out of range  
**Assumption:** ⚠️ Budget is blocker (vs just preference)  
**Test:** Show price distribution, analyze cart adds vs checkouts by price point  
**Status:** ❓ Not tested

---

### Assumption 5: Rating Opacity Blocks Conversion
**Evidence:** ✅ User quotes show confusion  
**Assumption:** ⚠️ Confusion → lower conversion  
**Test:** A/B test rating transparency, measure impact  
**Status:** ❓ Not tested

---

## Testing Priority (Riskiest First)

1. **Which persona has problem** - Changes everything
2. **What's the primary blocker** - Determines solution focus
3. **Are small bundles discoverable** - Quick product audit
4. **Does trust intervention work** - A/B test
5. **Does rating transparency matter** - A/B test

---

## Test Design Examples

### Test 1: Persona Diagnosis (Data Analysis)
**Question:** Which segment has activation problem?  
**Method:** SQL queries, funnel analysis  
**Success Criteria:** Identify persona with <X% activation vs >Y% baseline  
**Timeline:** 24 hours before interview (per Hannah)

### Test 2: Trust Intervention (Prototype Test)
**Question:** Do trust signals improve conversion intent?  
**Method:** Figma prototype with/without buyer protection badges, 5-8 user tests  
**Success Criteria:** >60% prefer trust-forward version  
**Timeline:** 1 week

### Test 3: Small Bundle Discoverability (Product Audit)
**Question:** Can users find £50-200 bundles?  
**Method:** Catalog audit, user journey mapping, heatmaps  
**Success Criteria:** Document current vs ideal discovery flow  
**Timeline:** 2 days

---

## Next Steps

1. Run data analysis (Test #1)
2. Based on results, prioritize remaining assumptions
3. Use cheapest test methods first (data analysis, product audits, prototypes)
4. A/B tests only for highest-confidence hypotheses
