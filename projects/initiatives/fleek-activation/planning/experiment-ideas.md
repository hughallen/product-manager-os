# Fleek Activation Experiments - Testable Hypotheses

**Timeline:** 6 weeks (3 x 2-week sprints)
**Approach:** Build → Measure → Learn cycles

**Last Updated:** February 16, 2026

---

## Experiment Framework

### General Approach

**Philosophy:**
- Test one variable at a time where possible
- Run concurrent experiments when non-interfering
- Build in tech debt management (10-20% of sprint capacity)
- Fail fast on experiments that don't show promise

**Confidence Levels:**
- ✅ **High confidence:** User research + competitor validation + clear mechanism
- 🔸 **Medium confidence:** User research OR competitor validation, unclear mechanism
- ⚠️ **Low confidence:** Assumption-based, needs validation

**Success Criteria:**
- Statistical significance (95% confidence)
- Meaningful effect size (>10% relative improvement for primary metric)
- Sustainable (not short-term boost that fades)

---

## Sprint 1 Experiments: Trust & Polish

### Experiment 1.1: Design Consistency Refresh

**Hypothesis:** Professional, high-quality visual design will increase user trust, leading to higher activation rates.

**Confidence:** ✅ High
- User feedback: "Screams like red flag to me"
- Competitor validation: Depop's beautiful design builds trust
- Mechanism: Visual quality → perceived legitimacy → reduced scam anxiety

**Test Design:**
- **Treatment:** New high-quality graphics, consistent branding
- **Control:** Current blurry graphics
- **Traffic split:** 50/50 (or 100% rollout if too risky to keep bad design)
- **Duration:** 2 weeks
- **Sample size:** TBD (based on traffic volume)

**Primary Metric:**
- First-time user activation rate (30-day)

**Secondary Metrics:**
- Time to first purchase
- Onboarding completion rate
- Homepage bounce rate

**Leading Indicators:**
- Qualitative feedback (support tickets, reviews mentioning trust)
- Session duration (do users browse longer?)

**Success Criteria:**
- +15-20% relative improvement in activation rate
- OR meaningful reduction in "scam" support tickets

**Risk:**
- Low (unlikely to hurt)
- If negative: quick rollback possible

**Learnings to Extract:**
- Which graphics had biggest impact? (onboarding vs homepage vs supplier page)
- Does design quality compound with other trust signals?

---

### Experiment 1.2: Review Relevance Algorithm

**Hypothesis:** Surfacing helpful/relevant reviews (not just recent bad ones) will reduce drop-off at supplier pages, increasing add-to-cart rate.

**Confidence:** ✅ High
- User feedback: "Reviews also are all bad at the top"
- Competitor validation: Depop/Vinted prompt positive reviews
- Mechanism: Bad reviews at decision point → trust erosion → abandonment

**Test Design:**
- **Treatment:** Reviews sorted by relevance/helpfulness
- **Control:** Reviews sorted by recency (current)
- **Traffic split:** 50/50
- **Duration:** 2 weeks
- **Sample size:** TBD

**Primary Metric:**
- Supplier page → add to cart conversion rate

**Secondary Metrics:**
- Review section scroll depth
- Time spent on supplier page
- Bounce rate from supplier page

**Leading Indicators:**
- % of users who view reviews (should stay same or increase)
- % of users who add to cart AFTER viewing reviews (should increase)

**Success Criteria:**
- +10-15% relative improvement in supplier page → cart conversion
- No decrease in review engagement (still visible, just not all bad at top)

**Risk:**
- Low-medium (might hide real quality issues)
- Mitigation: Don't hide bad reviews, just weight by helpfulness

**Variants to Test (if time permits):**
- A: Relevance only
- B: Relevance + show supplier responses
- C: Relevance + "most helpful" filter option

**Learnings to Extract:**
- What defines "helpful" review? (verified buyer, detailed, balanced)
- Does supplier rating correlate with review sentiment?

---

### Experiment 1.3: Buyer Protection Visibility

**Hypothesis:** Making buyer protection prominent will reduce trust anxiety, increasing onboarding completion and activation.

**Confidence:** 🔸 Medium
- User feedback: "Didn't want to get catfished"
- Competitor note: Vinted hides this (missed opportunity)
- Mechanism: Visible protection → reduced risk perception → more likely to try

**Test Design:**
- **Treatment:** Buyer protection badge on homepage + in-app "How it works" page
- **Control:** Current (buried in settings)
- **Traffic split:** 50/50 OR 100% rollout (low risk)
- **Duration:** 2 weeks

**Primary Metric:**
- First-time user activation rate

**Secondary Metrics:**
- Buyer protection page views (should increase dramatically)
- Onboarding completion rate
- Homepage → browse conversion

**Success Criteria:**
- +5-10% relative improvement in activation
- OR 20%+ of new users view buyer protection info

**Risk:**
- Low (unlikely to hurt)
- Possible concern: Highlighting protection might raise anxiety where it didn't exist

**Learnings to Extract:**
- Do users who view buyer protection info convert more?
- What questions do they have? (FAQs analytics)

---

## Sprint 2 Experiments: Personalization & Transparency

### Experiment 2.1: Personalization Feedback Loop (CRITICAL)

**Hypothesis:** Showing users that personalization worked (immediate homepage results) will increase engagement, browsing, and cart adds.

**Confidence:** ✅ High
- User feedback: "Put in personalization but homepage is generic"
- Competitor validation: Grailed/Depop show immediate results
- Mechanism: Reward for effort → trust in system → more browsing → higher conversion

**Test Design:**
- **Treatment:** Homepage with "Based on your preferences" section (personalized bundles)
- **Control:** Current generic homepage
- **Traffic split:** 50/50
- **Duration:** 2 weeks
- **Sample size:** TBD

**Primary Metric:**
- First-time user activation rate

**Secondary Metrics:**
- Personalization completion rate (might increase if users see value)
- Homepage engagement: CTR on personalized section vs generic
- Items viewed per session
- Browse → cart conversion

**Leading Indicators:**
- Time on homepage (should increase)
- Scroll depth on homepage
- Clicks on personalized bundles vs generic content

**Success Criteria:**
- +20-30% relative improvement in activation rate (this is THE critical fix)
- Personalized section CTR >2x generic content CTR

**Risk:**
- Medium (requires recommendation logic - if it's bad, might backfire)
- Mitigation: Start with simple rule-based (if selected "men's vintage" → show men's vintage bundles)

**Variants to Test:**
- A: Personalized section only
- B: Personalized + visual confirmation "You selected [X], here's what matches"
- C: Fully personalized homepage (no generic content)

**Learnings to Extract:**
- How many items need to be "personalized" to feel personalized?
- Does visual confirmation of preferences matter?
- Do users browse personalized section then also browse generic?

---

### Experiment 2.2: Onboarding Rationale & Value

**Hypothesis:** Explaining WHY we ask personalization questions will increase completion rate and user trust in the system.

**Confidence:** 🔸 Medium
- Competitor validation: Grailed/Depop explain value upfront
- Mechanism: Clear value → more likely to complete → better results

**Test Design:**
- **Treatment:** Onboarding with "Why we're asking" for each question
- **Control:** Current onboarding (no rationale)
- **Traffic split:** 50/50
- **Duration:** 2 weeks

**Primary Metric:**
- Personalization completion rate

**Secondary Metrics:**
- Skip rate per question
- Time spent on each question (might increase if reading rationale)
- Activation rate (compound effect with Exp 2.1)

**Success Criteria:**
- +10-15% relative improvement in personalization completion
- Maintained or improved time to complete (not adding too much friction)

**Risk:**
- Low (more context usually helps)
- Possible concern: Adds reading time, might increase drop-off

**Variants:**
- A: "Why we're asking" copy only
- B: Copy + visual example of result
- C: Copy + progress indicator ("2/5 questions")

**Learnings to Extract:**
- Which questions have highest skip rate?
- Does rationale reduce skips?

---

### Experiment 2.3: Supplier Transparency

**Hypothesis:** Showing supplier tenure, sales, rating breakdown, and "about" section will enable risk assessment, increasing purchase confidence.

**Confidence:** ✅ High
- User feedback: "Can never figure out what caused score to be low"
- Competitor validation: Etsy best-in-class transparency
- Mechanism: Information → risk assessment → informed decision → higher conversion

**Test Design:**
- **Treatment:** Supplier page with transparency section (years active, sales, rating breakdown, about)
- **Control:** Current supplier page
- **Traffic split:** 50/50
- **Duration:** 2 weeks

**Primary Metric:**
- Supplier page → add to cart conversion rate

**Secondary Metrics:**
- Time on supplier page (might increase as users read)
- % viewing rating breakdown
- % viewing "about" section

**Success Criteria:**
- +15-20% relative improvement in supplier page → cart conversion
- 30%+ of users interact with rating breakdown

**Risk:**
- Low-medium (requires supplier data - might not exist for all)
- Mitigation: Start with suppliers who have complete data

**Variants:**
- A: Transparency section only
- B: Transparency + "Global shipping included" badge
- C: Full redesign with modular sections (Etsy pattern)

**Learnings to Extract:**
- Which transparency element has highest engagement? (years, sales, rating breakdown, about)
- Do users who view transparency convert at higher rates?
- Does low supplier rating still convert if breakdown shows it's just slow shipping?

---

## Sprint 3 Experiments: Discovery & Affordability

### Experiment 3.1: Curated Content & Browse-First UI

**Hypothesis:** Surfacing quality items first and providing clear entry points will reduce overwhelm and increase browse → cart conversion.

**Confidence:** 🔸 Medium
- User feedback: "Don't know what I'm searching for"
- Competitor validation: Vinted (showcase), Depop (editorial)
- Mechanism: Guided discovery → confidence → faster purchase decision

**Test Design:**
- **Treatment:** Homepage with "Popular with new resellers" + visual category cards + browsing tags
- **Control:** Current homepage (slider + search-first)
- **Traffic split:** 50/50
- **Duration:** 2 weeks

**Primary Metric:**
- Homepage → cart conversion rate

**Secondary Metrics:**
- Items viewed per session
- Time to first cart add
- Category engagement rate

**Success Criteria:**
- +10-15% relative improvement in homepage → cart conversion
- Reduced time to first cart add

**Risk:**
- Medium (major UI change, might confuse existing users)
- Mitigation: Segment by new vs. returning users if needed

**Variants:**
- A: Curated section only
- B: Curated + category cards
- C: Curated + category cards + browsing tags

**Learnings to Extract:**
- Do users prefer curated or category entry points?
- Does "Popular with new resellers" resonate?
- Browse-first vs. search-first behavior patterns

---

### Experiment 3.2: Starter Bundle Visibility (DATA-DEPENDENT)

**Hypothesis:** If financial risk is validated blocker, surfacing affordable starter bundles will increase activation for price-sensitive users.

**Confidence:** ⚠️ Low-Medium (data-dependent)
- User feedback: "Higher priced things out of price range... £400-500"
- Unknown: What % of users are priced out? Do starter bundles exist?
- Mechanism: Affordable entry → lower risk → higher conversion

**Pre-Experiment Validation Required:**
1. Data analysis: What % of users view only expensive bundles then drop off?
2. Inventory check: Do £50-100 bundles exist in sufficient quantity?
3. Persona validation: Is Casey (£200 budget) the primary activation problem?

**Test Design (IF validated):**
- **Treatment:** "Starter bundles for new resellers" section on homepage + filter option
- **Control:** Current homepage
- **Traffic split:** 50/50 OR segment by user behavior (viewed expensive bundles only)
- **Duration:** 2 weeks

**Primary Metric:**
- First-time user activation rate (for price-sensitive segment)

**Secondary Metrics:**
- % of first purchases under £150
- CTR on "starter bundles" section
- Cart abandonment rate (price-related)

**Success Criteria:**
- +25%+ relative improvement for price-sensitive segment
- 30%+ of first purchases under £150 (vs. current baseline)

**Risk:**
- High IF starter bundles don't exist (requires supply-side work, out of 6-week scope)
- Medium IF bundlessuffix exist but low quality (might hurt brand)

**Alternative IF Bundles Don't Exist:**
- Advocate to leadership for supply-side initiative
- Focus on other blockers (trust, transparency, discovery)
- Consider payment plans (future phase)

**Learnings to Extract:**
- What's the price elasticity of first-time buyers?
- Is affordability THE blocker, or one of many?
- Do users who start small (£50-100) scale up over time?

---

### Experiment 3.3: Bundle Clarity & Modular Details

**Hypothesis:** Clear bundle contents and modular product details will reduce uncertainty, increasing bundle page → cart conversion.

**Confidence:** ✅ High
- User feedback: "No idea how many units small/medium, what material"
- Competitor validation: Etsy modular details reduce uncertainty
- Mechanism: Clear expectations → confidence → purchase

**Test Design:**
- **Treatment:** Bundle page with modular sections (contents, delivery, supplier, similar)
- **Control:** Current bundle page
- **Traffic split:** 50/50
- **Duration:** 2 weeks

**Primary Metric:**
- Bundle page → cart conversion rate

**Secondary Metrics:**
- Time on bundle page (might increase)
- Section interaction rates (which modules viewed)
- Cart → checkout conversion (expectations set, less surprises)

**Success Criteria:**
- +10-15% relative improvement in bundle page → cart conversion
- Reduced post-purchase complaints about expectations

**Risk:**
- Medium (requires data on bundle contents - might not exist yet)
- Mitigation: Use Fleek Sort data if available (end of March timing)

**Variants:**
- A: Contents breakdown only
- B: Contents + delivery info (global shipping prominent)
- C: Full Etsy pattern (contents + delivery + supplier + similar)

**Learnings to Extract:**
- Which module has highest engagement?
- Does "global shipping included" visibility matter?
- Do users who view bundle details convert at higher rates?

---

## Cross-Sprint Experiment: Cohort Comparison

### Long-Term Retention Analysis

**Hypothesis:** Users activated through improved onboarding/experience will have higher long-term retention and LTV.

**Test Design:**
- **Cohort A:** Users who activated with new experience (all Sprint 1-3 improvements)
- **Cohort B:** Users who activated with old experience (before improvements)
- **Duration:** Track for 90 days post-activation

**Metrics:**
- 7-day retention rate
- 30-day retention rate
- First → second purchase rate
- Time to second purchase
- Average LTV (3-month)

**Success Criteria:**
- Cohort A has 20%+ higher retention than Cohort B
- Cohort A reaches second purchase faster

**Learnings:**
- Did we activate the "right" users (who stay) or just "more" users (who churn)?
- Which improvement had lasting impact on retention?

---

## Experiment Prioritization Matrix

| Experiment | Confidence | Impact | Effort | Priority | Sprint |
|------------|-----------|--------|--------|----------|---------|
| Design Consistency | High | High | Low | **P0** | 1 |
| Review Relevance | High | High | Low | **P0** | 1 |
| Personalization Loop | High | Very High | Medium | **P0** | 2 |
| Supplier Transparency | High | High | Medium | P1 | 2 |
| Bundle Clarity | High | Medium | Medium | P1 | 3 |
| Buyer Protection | Medium | Medium | Low | P1 | 1 |
| Onboarding Rationale | Medium | Medium | Low | P1 | 2 |
| Curated Content | Medium | Medium | Medium | P1 | 3 |
| Starter Bundles | Low-Medium | Very High | Low | **P0 IF DATA CONFIRMS** | 3 |

---

## Measurement & Tracking

### Analytics Setup Required

**Event Tracking:**
- Page views: Homepage, onboarding, supplier page, bundle page, cart, checkout
- Interactions: Personalization questions, review section, rating breakdown, category cards
- Conversions: Signup, onboarding complete, cart add, checkout start, purchase complete

**Segmentation:**
- New vs. returning users
- Experiment variant (A vs. B)
- Persona indicators (order size, browse behavior, price viewed)
- Traffic source

**Dashboards:**
- Real-time experiment monitoring (sample size, conversion rates)
- Activation funnel (signup → onboarding → browse → cart → checkout → purchase)
- Cohort retention (7-day, 30-day, 90-day)

### Experiment Velocity

**2-Week Sprint:**
- Day 1-2: Design & spec finalization
- Day 3-5: Development
- Day 6-7: QA & launch
- Day 8-14: Data collection & monitoring
- Day 14: Analysis & decision (ship it / iterate / kill it)

**Tech Debt Management:**
- Reserve 10-20% of each sprint for cleanup
- Kill experiments that don't show promise by Day 10
- Document learnings even for failed experiments

---

## Decision Framework

### When to Ship It:
- ✅ Statistically significant improvement (95% confidence)
- ✅ Meaningful effect size (>10% relative improvement)
- ✅ No negative impacts on other metrics
- ✅ Sustainable (not just novelty effect)

### When to Iterate:
- 🔸 Directionally positive but not significant (might need more time or tweaks)
- 🔸 Mixed results (helps some segments, hurts others)
- 🔸 Qualitative feedback positive but quant neutral

### When to Kill It:
- ❌ No movement after 2 weeks with sufficient sample
- ❌ Negative impact on primary metric
- ❌ High effort for minimal return
- ❌ User feedback strongly negative

---

## References

- Improvement plan: [`activation-improvement-plan.md`](./activation-improvement-plan.md)
- UX audit: [`../ux-analysis/fleek-current-state.md`](../ux-analysis/fleek-current-state.md)
- Competitor patterns: [`/projects/competitors/ux-patterns-benchmarking.md`](../../competitors/ux-patterns-benchmarking.md)
- Metrics framework: [`/projects/product-artifacts/metrics/fleek-activation-metrics.md`](../../product-artifacts/metrics/fleek-activation-metrics.md)
