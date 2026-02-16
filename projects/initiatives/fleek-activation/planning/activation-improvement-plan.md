# Fleek Activation Improvement Plan

**Timeline:** 6 weeks
**Resources:** 2 engineers
**Goal:** Increase first-time user activation rate

**Last Updated:** February 16, 2026

---

## Executive Summary

### The Problem (Validated)

**New users face three major barriers:**
1. **Trust Deficit** (60% of problem) - Platform looks like scam, bad reviews surfaced, no visible quality control
2. **Financial Risk** (25% of problem) - Priced out by £400-500 bundle minimums with £200 budgets
3. **Product Uncertainty** (15% of problem) - Example photos misleading, bundle contents unclear, no personalization feedback

**Current Experience:**
User faces "expanse of options" → hits "trust wall" (bad reviews + blurry graphics) → abandons

**Desired Experience:**
User sees personalized, curated options → clear quality signals → confident first purchase

---

## Strategic Approach

### Design Principles

1. **Trust First** - Every touchpoint must build (not erode) trust
2. **Show, Don't Tell** - Personalization must be immediately visible
3. **Reduce Uncertainty** - Clear expectations prevent disappointment
4. **Progressive Disclosure** - Don't overwhelm with everything at once
5. **Quick Wins + Strategic Bets** - Balance fast improvements with foundational changes

### Success Criteria (To Be Validated with Data)

**Primary Metric:**
- First-time user activation rate (% completing first purchase within 30 days)

**Secondary Metrics:**
- Time to first purchase
- First → second purchase rate
- Browse → cart conversion
- Cart → checkout completion

**Leading Indicators:**
- Personalization completion rate
- Average items viewed before cart
- Supplier profile views
- Review section views

---

## 6-Week Roadmap

### Sprint 1 (Weeks 1-2): Trust & Polish - Quick Wins

**Theme:** Address visual trust deficit and low-hanging fruit

**Objective:** Make platform look legitimate and professional

#### Initiatives

**1. Design Consistency Refresh (P0 - CRITICAL)**
- **Effort:** Low (design only, minimal eng)
- **Impact:** High (addresses #1 user pain point)
- **Scope:**
  - Replace all blurry onboarding graphics with high-quality visuals
  - Create consistent icon library
  - Refresh email templates (onboarding + promo)
  - Supplier product photo quality guidelines
- **Success metric:** Qualitative (looks professional), setup for trust measurement
- **Maps to feedback:** "It seemed like such a scam... just screams red flag"

**2. Review Relevance Algorithm (P0 - CRITICAL)**
- **Effort:** Low (backend tweak)
- **Impact:** High (stops trust erosion at critical moment)
- **Scope:**
  - Adjust review sorting: relevance/helpfulness over recency
  - Weight positive reviews from verified buyers
  - Don't surface lowest-rated reviews at top
- **Success metric:** % of users who view reviews and still add to cart (vs. current)
- **Maps to feedback:** Reviews "all bad at top" reinforcing scam perception

**3. Buyer Protection Visibility (P1)**
- **Effort:** Low (content + UI placement)
- **Impact:** Medium (trust signal for skeptical users)
- **Scope:**
  - Add buyer protection badge to homepage
  - Create in-app "How it works" page (not mobile site link)
  - FAQs prominent and searchable
- **Success metric:** % of users who view buyer protection info
- **Maps to feedback:** "Didn't want to get catfished... until I spoke to someone physically"

#### Sprint 1 Deliverables
- ✅ Professional visual design across app
- ✅ Reviews no longer killing trust at moment of decision
- ✅ Buyer protection prominent for skeptical users
- ✅ Foundation for deeper trust building

---

### Sprint 2 (Weeks 3-4): Personalization Feedback Loop & Transparency

**Theme:** Show users personalization works and set clear expectations

**Objective:** Reward users for onboarding effort and reduce product uncertainty

#### Initiatives

**1. Personalization Feedback Loop (P0 - CRITICAL)**
- **Effort:** Medium (frontend + recommendation logic)
- **Impact:** Very High (fixes broken onboarding → homepage experience)
- **Scope:**
  - After onboarding, show "Based on your preferences" section on homepage
  - Personalized bundle recommendations above generic content
  - Visual confirmation: "You selected [X], here are bundles matching that"
  - A/B test: personalized homepage vs. current generic
- **Success metric:** Homepage → browse conversion, personalization completion rate
- **Maps to feedback:** "I put in personalization preferences but homepage is generic/one-size"
- **Competitor pattern:** Grailed, Depop (immediate feedback)

**2. Onboarding Rationale & Value (P1)**
- **Effort:** Low (copy changes + minor UI)
- **Impact:** Medium (improves personalization completion rate)
- **Scope:**
  - Add "Why we're asking" for each personalization question
  - Change CTA from "Maybe later" (prominent) to "Skip" (top-right)
  - Add mission statement: "Helping resellers source quality vintage at wholesale prices"
  - Make swipeable (nice-to-have if time permits)
- **Success metric:** Personalization completion rate
- **Maps to feedback:** Users don't understand why questions being asked
- **Competitor pattern:** Depop, Grailed (clear rationale)

**3. Supplier Transparency (P1)**
- **Effort:** Medium (data display + schema changes if needed)
- **Impact:** High (enables risk assessment)
- **Scope:**
  - Supplier page shows: years active, total sales, response time
  - Rating breakdown: delivery speed, product quality, communication, accuracy
  - "About" section for supplier (specialization, story)
  - "Global shipping included" badge prominent
- **Success metric:** Supplier page → add to cart conversion
- **Maps to feedback:** "I can never figure out what caused score to be low"
- **Competitor pattern:** Etsy (best-in-class transparency)

#### Sprint 2 Deliverables
- ✅ Users see immediate value from personalization
- ✅ Users understand WHY they're answering questions
- ✅ Users can assess supplier risk and make informed decisions
- ✅ Homepage feels curated, not generic

---

### Sprint 3 (Weeks 5-6): Discovery & Affordability

**Theme:** Help users find the right first purchase and make it accessible

**Objective:** Reduce overwhelm and address affordability barrier

#### Initiatives

**1. Curated Content & Browse-First UI (P1)**
- **Effort:** Medium (content curation + UI changes)
- **Impact:** High (addresses overwhelm + discovery)
- **Scope:**
  - "Popular with new resellers" section on homepage
  - Visual category cards (not just slider)
  - Horizontal browsing tags for quick filtering
  - Weight results by supplier rating (quality first)
- **Success metric:** Homepage engagement time, browse → cart conversion
- **Maps to feedback:** "I don't know what I'm searching for... nothing for me to put in"
- **Competitor pattern:** Vinted (showcase), Depop (editorial), eBay (tags)

**2. Starter Bundle Visibility (P0 - CRITICAL IF DATA CONFIRMS)**
- **Effort:** Low-Medium (depends on if bundles exist or need creation)
- **Impact:** Very High IF financial risk is validated blocker
- **Scope:**
  - If £50-100 bundles exist: Surface them prominently ("Starter bundles for new resellers")
  - If they don't exist: Work with suppliers to create them (out of scope for 6 weeks, advocate to leadership)
  - Highlight affordable options in personalized recommendations
  - "First order" badge or filter
- **Success metric:** % of first-time buyers purchasing bundles under £150
- **Maps to feedback:** "Higher priced things out of my price range... £400-500... if smaller bundles were cheaper, I'd pick them up"
- **Data dependency:** MUST validate this is real blocker (what % are priced out?)

**3. Bundle Clarity & Modular Details (P1)**
- **Effort:** Medium (UI redesign + data structure)
- **Impact:** Medium (reduces product uncertainty)
- **Scope:**
  - Bundle page with modular sections:
    - "What's included": Size breakdown, brand breakdown, material breakdown, quantity
    - "Delivery": Estimated time, global shipping (prominent!)
    - "Supplier": Rating breakdown, specialization, about
    - "Similar bundles": Alternatives
  - Clear labeling: "Example items" vs "You will receive these exact items" (if Fleek Sort available)
- **Success metric:** Bundle page → cart conversion
- **Maps to feedback:** "I've got no idea... how many units small, medium, what material"
- **Competitor pattern:** Etsy (modular cart details)

#### Sprint 3 Deliverables (Scope Dependent on Data)
- ✅ Browse-first users have clear entry points
- ✅ Affordable starter bundles visible (if they exist)
- ✅ Bundle contents transparent, expectations set
- ✅ Users can find first purchase with confidence

---

## Alternative Prioritization (Data-Dependent)

### If Data Shows Financial Risk is NOT Primary Blocker:
**Replace:** Starter Bundle Visibility initiative
**With:** 
- Cart performance improvements (reduce "spinning" at checkout)
- Desktop experience optimization (if Jordan persona is priority)
- OR double down on trust/transparency initiatives

### If Data Shows Jordan (Large Retailer) Has Activation Problem (Not Casey):
**Pivot focus to:**
- Desktop experience overhaul
- Search optimization (they search, not browse)
- Bulk purchase features
- Supplier relationship tools

### If Data Shows Trust is 90% of Problem (Not 60%):
**Add to Sprint 1:**
- Quality control transparency page (show the process)
- Success stories from real buyers (social proof)
- Money-back guarantee prominence

---

## Out of Scope (Advocate for Future)

**Not addressable in 6 weeks but important:**

1. **Supply-Side Solutions**
   - Supplier bundle creation (£50-100 starter bundles)
   - Supplier description templates/guidelines
   - Supplier photo quality enforcement
   - Supplier onboarding for "About" sections

2. **Post-Purchase Experience**
   - Order tracking visibility
   - Delivery transparency
   - Post-delivery review prompting

3. **Tech-Heavy Features**
   - Magic link authentication
   - Photo search
   - Advanced recommendation algorithms
   - Mobile app performance optimization

4. **Women's Wear Hand-Pick Experience**
   - Depends on Fleek Sort (100% inventory online end of March)
   - Custom bundle builder redesign
   - Individual item selection flow

---

## Success Validation Plan

### Week 1-2 (Sprint 1)
**Measure:**
- Design QA (does it look professional?)
- Review view → cart rate (vs. baseline)
- Buyer protection page views

**Decision point:** If trust signals improving, continue to Sprint 2. If not, diagnose why.

### Week 3-4 (Sprint 2)
**Measure:**
- Personalization completion rate
- Homepage engagement (time, items viewed)
- Personalized section CTR vs. generic content
- Supplier page → cart conversion

**Decision point:** If personalization feedback loop working, continue to Sprint 3. If not, iterate.

### Week 5-6 (Sprint 3)
**Measure:**
- First-time activation rate (primary metric)
- Time to first purchase
- Browse → cart → checkout funnel
- Starter bundle CTR (if applicable)

**Decision point:** Did activation rate improve meaningfully? (Target: +20-30% relative improvement)

### Post-Launch (Week 7+)
**Measure:**
- 7-day retention cohorts
- First → second purchase rate
- Qualitative feedback (support tickets about trust/scams decreasing?)

---

## Build vs. Buy vs. Leverage Decisions

### Build (Custom Development Required)
- Personalization feedback loop
- Review relevance algorithm
- Supplier transparency page
- Curated content sections

### Update/Refresh (Existing Systems)
- Design assets (graphics, icons, templates)
- Onboarding copy and flow
- Homepage layout and weights

### Leverage Existing (If Available)
- Fleek Sort data for bundle transparency (end of March)
- Existing recommendation system (if present)
- Analytics infrastructure for experiment tracking

---

## Risk Mitigation

### Technical Risks
- **Risk:** Recommendation logic doesn't exist or is complex
- **Mitigation:** Start with rule-based (if user selected "men's vintage" → show men's vintage bundles)

- **Risk:** Supplier data incomplete (no years active, about sections)
- **Mitigation:** Start with suppliers who have data, incentivize others to complete profiles

### Product Risks
- **Risk:** Starter bundles don't exist at £50-100 price point
- **Mitigation:** Advocate to leadership for supply-side initiative, focus on other blockers

- **Risk:** Visual design refresh doesn't move trust needle
- **Mitigation:** Combine with other trust signals (buyer protection, QC transparency, success stories)

### Scope Risks
- **Risk:** 6 weeks not enough for all initiatives
- **Mitigation:** Prioritize P0 items, cut nice-to-haves (swipeable onboarding, advanced features)

---

## Experiment Hypotheses (See experiment-ideas.md for Details)

**Sprint 1:**
- H1: Professional design → increased trust → higher activation
- H2: Relevant reviews (not just recent bad ones) → less drop-off at supplier page

**Sprint 2:**
- H3: Personalization feedback loop → users browse more → higher cart add rate
- H4: Supplier transparency → users can assess risk → higher purchase confidence

**Sprint 3:**
- H5: Curated content → less overwhelm → faster time to cart
- H6: Starter bundle visibility → new resellers convert → higher activation (IF validated)

---

## Alignment with Business Goals

### Revenue Impact
- Higher activation → more buyers → more GMV → more commission revenue
- Focus on retention (not just acquisition) aligns with leadership priority

### Fleek Sort Timing
- 100% inventory online by end of March = perfect timing for Sprint 3 bundle clarity initiative
- Can leverage individual item images for transparency

### Competitive Positioning
- Depop/Vinted have trust, but not B2B focus
- Traditional wholesalers lack digital polish
- Fleek can win by combining: Depop-level UX + wholesale supply chain + AI transparency

---

## Next Steps

1. **Pre-Sprint 0: Data Analysis**
   - Segment users and validate personas
   - Map drop-off points in current funnel
   - Confirm which blockers have highest impact
   - Set baseline metrics

2. **Sprint Planning**
   - Prioritize based on data findings
   - Scope initiatives to 2-week sprints
   - Define success criteria per initiative
   - Set up experiment tracking

3. **Design Phase**
   - Visual design refresh (can start immediately)
   - Wireframes for personalization feedback loop
   - Supplier transparency page mockups
   - Curated content section layouts

4. **Implementation**
   - Sprint 1: Trust & polish
   - Sprint 2: Personalization & transparency
   - Sprint 3: Discovery & affordability (data-dependent)

---

## References

- UX audit: [`ux-analysis/fleek-current-state.md`](../ux-analysis/fleek-current-state.md)
- Competitor patterns: [`/projects/competitors/ux-patterns-benchmarking.md`](../../competitors/ux-patterns-benchmarking.md)
- User feedback: [`/projects/personas/fleek-user-feedback-mapping.md`](../../personas/fleek-user-feedback-mapping.md)
- Experiments: [`planning/experiment-ideas.md`](./experiment-ideas.md)
- Metrics: [`/projects/product-artifacts/metrics/fleek-activation-metrics.md`](../../product-artifacts/metrics/fleek-activation-metrics.md)
