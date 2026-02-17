# Fleek Activation Metrics Framework

**Owner:** Hugh Allen (Case Study)
**Last Updated:** February 16, 2026
**Status:** Framework defined, baselines TBD (awaiting database access)

---

## Purpose

Define metrics to:
1. **Measure** activation problem magnitude and root causes
2. **Track** improvement from activation initiatives
3. **Validate** which persona(s) have activation problem
4. **Inform** prioritization and iteration decisions

---

## Activation Definition (To Be Validated)

### What is "Activated"?

**Working hypothesis:** User completes first purchase within defined time window.

**Time windows to analyze:**
- 7-day activation rate
- 14-day activation rate
- 30-day activation rate

**Questions for data analysis:**
1. What % of users who activate do so within 7 days? 14 days? 30 days?
2. What's the meaningful time window? (Industry standard: 7-30 days)
3. Does faster activation correlate with long-term retention?

**Alternative definitions to consider:**
- Added item to cart (intent signal)
- Completed personalization + browsed (engagement signal)
- Signed up + returned within 7 days (habit formation)

---

## Metric Hierarchy

### North Star Metric (TBD - Data Dependent)

**Candidates:**
1. **First-time user activation rate** (% completing first purchase within 30 days)
2. **Time to value** (days from signup to first successful order receipt)
3. **Activated user retention** (% of first-time buyers who return for second purchase)

**Selection criteria:**
- Correlates with long-term retention
- Demonstrates user sophistication
- 15-20% of users should be able to reach it
- Broader metric that's representative of user behavior

**Decision:** Will be made after analyzing:
- Current activation funnel metrics
- Correlation between activation and retention
- Business priorities (acquisition vs. retention focus)

---

## Primary Metrics

### 1. Activation Rate

**Definition:** % of new users who complete first purchase within [X] days of signup

**Formula:**
```
Activation Rate = (Users with 1+ purchase / Total signups) * 100
```

**Segmentation:**
- By time window (7-day, 14-day, 30-day)
- By traffic source
- By persona indicators (predicted budget, browse behavior)
- By experiment variant

**Current Baseline:** TBD
**Target:** TBD (after establishing baseline)
**Industry Benchmark:** TBD (research C2C marketplaces)

---

### 2. Time to First Purchase

**Definition:** Median and P90 days from signup to first completed purchase

**Why it matters:**
- Faster activation = stronger product-market fit
- Compound effect on cohort value
- Leading indicator for retention

**Current Baseline:** TBD
**Target:** TBD (reduce by 20-30%?)

---

### 3. First → Second Purchase Rate

**Definition:** % of first-time buyers who complete second purchase within [Y] days

**Formula:**
```
Repeat Rate = (Users with 2+ purchases / Users with 1+ purchase) * 100
```

**Why it matters:**
- True validation that activation wasn't hollow
- Fleek makes money from retention ("Revenue comes from retention" - Sanket)
- Indicates we activated "right" users, not just "more" users

**Current Baseline:** TBD
**Target:** 15-20% (industry rule of thumb)

---

## Funnel Metrics (Diagnostic)

### Activation Funnel

**Stages:**
1. **Signup** → Total new accounts created
2. **Onboarding Start** → Users who begin personalization
3. **Onboarding Complete** → Users who finish personalization
4. **Browse** → Users who view at least 1 bundle/supplier
5. **Cart Add** → Users who add at least 1 item to cart
6. **Checkout Start** → Users who reach checkout page
7. **Purchase Complete** → Users who complete payment

**Key Conversion Rates (TBD):**
- Signup → Onboarding Start: ___%
- Onboarding Start → Complete: ___%
- Onboarding Complete → Browse: ___%
- Browse → Cart Add: ___%
- Cart Add → Checkout Start: ___%
- Checkout Start → Purchase Complete: ___%

**Overall Signup → Purchase:** ___%

**Analysis questions:**
1. Where is the biggest drop-off?
2. Does drop-off point vary by persona/segment?
3. Which stage has most leverage for improvement?

---

### Page-Level Metrics

#### Homepage
- **Bounce rate:** % who leave without clicking
- **Engagement rate:** % who scroll or click
- **CTR on personalized content:** (if implemented)
- **CTR on generic content:** (baseline)
- **Time on page:** Median and P90

#### Onboarding
- **Completion rate:** % who finish all questions
- **Skip rate per question:** Which questions skipped most?
- **Drop-off point:** Which question has highest abandonment?
- **Time to complete:** Median (is it too long?)

#### Supplier Page
- **View rate:** % of browsers who view supplier pages
- **Time on page:** Are users reading or bouncing?
- **Review section engagement:** % who scroll to reviews
- **Cart add rate:** % who add to cart after viewing

#### Bundle Page
- **View rate:** % of browsers who view bundle pages
- **Time on page:** Engagement level
- **Details interaction:** % who expand contents/delivery/etc.
- **Cart add rate:** Critical conversion metric

#### Cart
- **Abandonment rate:** % who add but don't checkout
- **Items per cart:** Median and P90
- **Cart value:** Median and P90
- **Removal rate:** % who remove items (indecision signal)

#### Checkout
- **Completion rate:** % who complete after starting
- **Drop-off point:** Payment? Shipping? Other?
- **Time to complete:** Friction indicator

---

## Leading Indicators (Experiment Success Signals)

### Trust Signals

**Qualitative:**
- Support tickets mentioning "scam," "fake," "trust"
- App store review sentiment
- NPS scores (if collected)

**Quantitative:**
- % who view buyer protection page
- % who view "How it works"
- % who message supplier before purchasing (trust barrier)

**Hypothesis:** As trust improves, these should trend:
- ↓ Trust-related support tickets
- ↓ % needing human validation before purchase
- ↑ NPS scores

---

### Personalization Effectiveness

**Metrics:**
- Personalization completion rate
- Homepage engagement after personalization (CTR, time, scroll)
- Items viewed per session (should increase if personalized)
- Relevance of viewed items to stated preferences

**Hypothesis:** If personalization feedback loop works:
- ↑ Completion rate (users see value)
- ↑ Homepage engagement
- ↑ Items viewed (confident browsing)

---

### Discovery & Engagement

**Metrics:**
- Search usage rate (how many use search vs. browse?)
- Category interaction rate
- Supplier follows/saves
- Session depth (pages per session)

**Hypothesis:** If browse-first UI works:
- ↓ Dependence on search
- ↑ Category interaction
- ↑ Session depth

---

## Lagging Indicators (Long-Term Validation)

### Retention Cohorts

**Metric:** % of activated users who return and purchase in:
- 7 days
- 30 days
- 90 days

**Formula:**
```
7-Day Retention = (Users with purchase in Days 8-14 / Users activated in Days 1-7) * 100
```

**Why it matters:** Validates we activated "right" users who get long-term value

**Target:** Majority return within 7 days, 15-20% continue to collaborate (industry rule of thumb)

---

### Lifetime Value (LTV)

**Metric:** Average revenue per user over 90 days (or 6 months)

**Segmentation:**
- By activation experience (new vs. old)
- By persona (Casey, Jordan, Taylor)
- By first purchase size

**Why it matters:** Revenue impact validation

---

### Customer Satisfaction

**Metrics:**
- Post-purchase NPS
- Review sentiment (expectation vs. reality)
- Refund/return rate
- Repeat purchase rate

**Why it matters:** Ensures we're not just activating users who then have bad experiences

---

## Segmentation Strategy

### Persona Segmentation (To Validate)

**Casey (New Reseller) Indicators:**
- First-time buyer (no purchase history)
- Views bundles < £200
- Browse behavior (not search)
- Mobile user

**Jordan (Large Retailer) Indicators:**
- Views bundles > £500
- Search behavior (brand-specific)
- Desktop user
- Returns frequently (established)

**Taylor (Women's Curator) Indicators:**
- Views women's wear
- Medium bundle sizes (£500-2k)
- Mobile or web
- May use Depop (inferred)

**Analysis:**
1. Can we identify persona from behavior?
2. Which persona has lowest activation rate?
3. Do interventions help all personas or just target?

---

### Traffic Source Segmentation

**Channels:**
- Organic search
- Social media (Instagram, TikTok, etc.)
- Paid ads
- Referral
- Direct

**Why it matters:**
- Different channels attract different personas
- Activation barriers may vary by source
- ROI calculation (CAC vs. LTV)

---

### Temporal Segmentation

**Cohorts:**
- By signup week/month
- Before vs. after experiments
- Pre vs. post Fleek Sort (end of March)

**Why it matters:**
- Isolate impact of changes
- Control for seasonality
- Measure sustained improvement

---

## Experiment Tracking Framework

### Per-Experiment Metrics

**Setup:**
- Variant assignment (A vs. B)
- Sample size per variant
- Experiment start/end date

**Metrics:**
- Primary metric (specific to experiment)
- Secondary metrics
- Guardrail metrics (ensure no harm)

**Statistical validation:**
- Significance level (95% confidence)
- Effect size (>10% relative improvement)
- Sample size calculation upfront

---

### Experiment Dashboard (Ideal)

**Real-time monitoring:**
- Sample size reached
- Conversion rates by variant
- Statistical significance indicator
- Time-series view (detect novelty effects)

**Segmentation:**
- By persona/user type
- By traffic source
- By device (mobile/desktop)

---

## Analysis Methods

### Cohort Analysis

**Compare:**
- Activated users (Week 1) vs. non-activated
- New experience cohort vs. old experience cohort
- High-intent users (completed onboarding) vs. low-intent (skipped)

**Metrics:**
- Retention curves
- Purchase frequency
- Average order value
- LTV

---

### Funnel Analysis

**Identify:**
- Biggest drop-off points
- Conversion rate by segment
- Time between stages (velocity)

**Tools:**
- Sankey diagrams (visualize flow)
- Cohort-based funnels (does it improve over time?)

---

### A/B Test Analysis

**Methods:**
- T-test for continuous metrics (time to purchase)
- Chi-square for conversion rates
- Bayesian if appropriate (faster decisions)

**Considerations:**
- Multiple testing correction (if running many experiments)
- Interaction effects (do experiments compound or interfere?)
- Novelty effects (short-term boost that fades)

---

## Data Collection & Infrastructure

### Required Events (To Implement)

**User events:**
- `user_signup`
- `onboarding_start`
- `onboarding_question_answered` (per question)
- `onboarding_complete`
- `page_view` (with page_type: homepage, supplier, bundle, cart, checkout)
- `bundle_view`
- `supplier_view`
- `review_section_view`
- `rating_breakdown_view`
- `cart_add`
- `cart_remove`
- `checkout_start`
- `purchase_complete`
- `buyer_protection_view`

**User properties:**
- `user_id`
- `signup_date`
- `traffic_source`
- `device_type`
- `experiment_variant` (per experiment)
- `personalization_completed` (boolean)
- `first_purchase_date`

---

### Segmentation Properties (To Derive)

**Behavioral:**
- `browse_vs_search` (ratio)
- `price_range_viewed` (categorize budget)
- `category_preference`
- `mobile_vs_desktop`

**Outcome:**
- `is_activated` (boolean)
- `time_to_first_purchase` (days)
- `first_purchase_amount`
- `persona_predicted` (Casey, Jordan, Taylor, Unknown)

---

## Reporting Cadence

### Daily (During Experiments)
- Experiment sample size and conversion rates
- Anomaly detection (sudden drops/spikes)

### Weekly
- Activation rate trend
- Funnel conversion rates
- Experiment results readout

### Monthly
- Cohort retention analysis
- LTV trends
- Persona breakdown
- Overall activation health

---

## Questions for Data Analysis (Pre-Sprint)

### Activation Magnitude
1. What's the current activation rate? (7-day, 14-day, 30-day)
2. How does it compare to industry benchmarks?
3. What's the time distribution? (Do users activate in Days 1-3 or Days 20-30?)

### Funnel Diagnosis
4. Where is the biggest drop-off in the funnel?
5. What % complete onboarding? Browse? Add to cart? Checkout?
6. Does drop-off point vary by segment?

### Persona Validation
7. Can we identify Casey, Jordan, Taylor from behavior?
8. Which persona has the lowest activation rate?
9. Which persona is most valuable (LTV)?

### Root Cause Validation
10. Do users who view reviews convert less? (trust issue)
11. Do users who view expensive bundles (>£400) drop off more? (affordability issue)
12. Do users who complete personalization convert more? (current feedback loop broken?)
13. Does desktop vs. mobile matter?

### Opportunity Sizing
14. If we improve activation by 20%, what's the revenue impact?
15. What % of signups are "saveable" with improvements?
16. Where is the highest-leverage intervention point?

---

## Success Criteria (To Be Set After Analysis)

### Sprint 1 (Trust & Polish)
- **Target:** TBD
- **Metric:** Activation rate increase (relative %)
- **Guardrails:** No decrease in onboarding completion, no increase in refund rate

### Sprint 2 (Personalization & Transparency)
- **Target:** TBD
- **Metric:** Homepage → cart conversion increase
- **Guardrails:** Personalization completion rate maintained or improved

### Sprint 3 (Discovery & Affordability)
- **Target:** TBD
- **Metric:** First-time activation rate (primary), time to first purchase (secondary)
- **Guardrails:** No decrease in average order value (ensure we're not just getting low-value users)

### Overall (6-Week Initiative)
- **Target:** 20-30% relative improvement in activation rate (ambitious but achievable)
- **Validation:** Activated users have equal or better retention than baseline
- **Business impact:** $X incremental revenue from improved activation

---

## Metric Alignment Across Organization

### Product
- Focus: Activation rate, funnel conversion, engagement

### Engineering
- Focus: Page load times, error rates, experiment infrastructure

### Marketing
- Focus: CAC, traffic source quality, activation rate by channel

### Operations/Finance
- Focus: LTV, revenue impact, unit economics

**Key principle:** Make sure metrics link up across functions to avoid misalignment.

---

## Tools & Access Needed

### Analytics Platform
- [ ] Access to database for custom queries
- [ ] Experiment tracking system (for variant assignment)
- [ ] Funnel visualization tool (Sankey diagrams)
- [ ] Cohort analysis capability

### Dashboards to Build
- [ ] Activation funnel (real-time)
- [ ] Experiment monitoring dashboard
- [ ] Cohort retention curves
- [ ] Persona breakdown

---

## References

- Initiative overview: [`/projects/initiatives/fleek-activation/README.md`](../../initiatives/fleek-activation/README.md)
- Improvement plan: [`/projects/initiatives/fleek-activation/planning/activation-improvement-plan.md`](../../initiatives/fleek-activation/planning/activation-improvement-plan.md)
- Experiments: [`/projects/initiatives/fleek-activation/planning/experiment-ideas.md`](../../initiatives/fleek-activation/planning/experiment-ideas.md)
- User feedback: [`/projects/product-artifacts/personas/fleek-user-feedback-mapping.md`](../personas/fleek-user-feedback-mapping.md)

---

## Notes on Metrics Philosophy

### From Your Notes:

**Choosing the Right Activation Metric:**
- Should correlate with long-term retention ✅
- Demonstrate retention and sophistication ✅
- 20% of customers should be able to reach the number ✅
- Use a broader metric that's representative of what user is doing ✅

**Rules of Thumb:**
- Majority back in 7 days ✅
- 15-20% continue to collaborate (return) ✅
- 15-20% continue to find value ✅

**Onboarding Should Be:**
- Visual (showing) → Depop/Grailed visual personalization
- Progressive → Don't overwhelm with everything at once
- Experiential (have them complete something) → Vinted prompts to post item

**Other Considerations:**
- Time to value: Most users will not come back, so first sale is critical ✅
- Split traffic by order size ✅
- Split traffic by mobile/desktop ✅
- Build tech debt into experiments ✅

---

## Next Steps

1. **Gain database access** - Run queries to establish baselines
2. **Set up event tracking** - Ensure all required events are captured
3. **Build dashboards** - Activation funnel, experiments, cohorts
4. **Validate personas** - Can we identify Casey/Jordan/Taylor from data?
5. **Prioritize interventions** - Based on where biggest drop-off is
6. **Define success criteria** - Set targets based on baselines and business goals
