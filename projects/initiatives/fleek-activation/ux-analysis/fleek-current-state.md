# Fleek UX Audit - Current State Analysis

**Last Updated:** February 16, 2026
**Auditor:** Hugh Allen
**Purpose:** Identify UX barriers to first-time user activation

**Screenshots:** Located in `screenshots/` folder (not committed to git)

---

## Executive Summary

### Critical Issues Identified

**1. Trust Deficit (SEVERE)**
- Design inconsistency and low-quality graphics severely damage credibility
- Negative reviews surfaced prominently, reinforcing skepticism
- Buyer protection and quality control hidden/unclear

**2. Onboarding Failure (HIGH)**
- No clear rationale for personalization questions
- No feedback loop showing personalization worked
- Phone number required too early (friction)
- Can't swipe through onboarding (poor mobile UX)

**3. Discovery Overload (HIGH)**
- Too much going on at once (sliders with many concepts)
- Generic homepage despite personalization
- No clear differentiation between seller types
- "New stock drop" not useful for either persona

**4. Pricing Confusion (MEDIUM)**
- Bundles AND sliding scale pricing creates complexity
- Not clear which pricing model applies when

**5. Design Inconsistency (SEVERE - Quick Win)**
- Blurry, low-quality graphics throughout
- Inconsistent branding across app and email
- Looks unprofessional, reinforces "scam" perception

---

## Detailed Findings by User Journey Stage

### 1. Signup & First Impression

#### Issues

| Issue | Severity | Screenshot | Maps to Feedback Theme |
|-------|----------|------------|------------------------|
| Onboarding graphics blurry and unprofessional | **CRITICAL** | `fleek-signup-01.png` | Trust & Legitimacy |
| Cannot swipe through onboarding | High | `fleek-signup-02.png` | UX Friction |
| Onboarding requires scrolling | Medium | `fleek-signup-03.png` | Mobile UX |
| Phone number required first, WhatsApp after | High | `fleek-signup-04.png` | Trust & Privacy |
| "Allow tracking" opt-in (good!) | ✅ Positive | `fleek-signup-05.png` | - |

#### Analysis
**Trust damage at first touchpoint:** Blurry graphics are the **easiest quick win** to improve perceived legitimacy. Users come in skeptical ("looks like a scam") and low-quality visuals confirm their fears.

**Friction before value:** Requiring phone number before showing value adds unnecessary barrier. WhatsApp prompt could come after user sees personalized results.

#### User Feedback Connection
> "It seemed like such a scam to me like just the way it like presented itself… it just screams like red flag to me."

The visual design quality directly contributes to this perception.

---

### 2. Onboarding & Personalization

#### Issues

| Issue | Severity | Screenshot | Maps to Feedback Theme |
|-------|----------|------------|------------------------|
| Not able to swipe through screens | High | `fleek-onboarding-01.png` | UX Friction |
| Starts on "Welcome to onboarding" instead of first question | Medium | `fleek-onboarding-02.png` | Efficiency |
| Not clear WHY questions are being asked | **CRITICAL** | `fleek-onboarding-03.png` | Trust & Value |
| "Maybe later" button too prominent | Medium | `fleek-onboarding-04.png` | Conversion |
| No mission statement in onboarding | Medium | `fleek-onboarding-05.png` | Brand/Trust |
| **No feedback loop after personalization** | **CRITICAL** | `fleek-onboarding-06.png` | Product Uncertainty |

#### Analysis
**Missing the "why":** Users don't understand the benefit of answering questions. Competitors (Grailed, Depop) make it explicit: "Answer these to get personalized recommendations."

**No reward for effort:** After spending time on personalization, user sees generic homepage. No visual confirmation that personalization worked. This breaks trust in the technology.

**Prominent skip option:** "Maybe later" is too easy to click, suggesting personalization isn't important. Better: "Skip" in top-right (standard pattern).

#### User Feedback Connection
Users report browsing being overwhelming and not knowing where to start - personalization could help but isn't effectively implemented.

#### Competitor Comparison
- **Grailed:** Personalization ties directly to homepage - immediate reward
- **Depop:** Visual personalization that immediately shows in feed
- **Etsy:** Category-based personalization that floats relevant categories to top

---

### 3. Homepage & Discovery

#### Issues

| Issue | Severity | Screenshot | Maps to Feedback Theme |
|-------|----------|------------|------------------------|
| Slider has too many concepts at once | High | `fleek-homepage-01.png` | Discoverability |
| Homepage generic despite personalization | **CRITICAL** | `fleek-homepage-02.png` | Product Uncertainty |
| No clear delineation between solo seller and retailer | High | `fleek-homepage-03.png` | Product Uncertainty |
| "New stock drop" not useful | Medium | `fleek-homepage-04.png` | Relevance |
| Feels generic, not curated | High | `fleek-homepage-05.png` | Discoverability |
| Bundle builder feels separate from core app | Medium | `fleek-homepage-06.png` | UX Architecture |

#### Analysis
**Personalization doesn't work (or doesn't appear to):** This is the **biggest onboarding failure**. User invests time in personalization, then sees no evidence it worked. Creates distrust in platform.

**Too much cognitive load:** Slider with many concepts, no clear hierarchy, no personalization = user paralyzed by choice.

**"New stock drop" misses the mark:** Neither new resellers (who want guidance on what sells) nor established retailers (who want specific brands/categories) benefit from generic "new" content.

#### Better Approach (from competitors)
- **Vinted:** Showcase quality items first, weight results
- **Depop:** Editorial/curated content with lifestyle imagery
- **Grailed:** Blend of trends, edits, and follow recommendations

#### User Feedback Connection
> "I don't go on the app knowing what I'm looking for. So when I go on there, I don't know what I'm searching for."

Homepage should guide browse-first users, not assume they know what to search.

---

### 4. Search & Browse

#### Issues

| Issue | Severity | Screenshot | Maps to Feedback Theme |
|-------|----------|------------|------------------------|
| Search page: brands first (good!) | ✅ Positive | `fleek-search-01.png` | - |
| Feels generic, not suited for curated sellers | High | `fleek-search-02.png` | Discoverability |
| Not clear what supplier specializes in | High | `fleek-search-03.png` | Product Uncertainty |

#### Analysis
**Brand-first search is smart:** Aligns with how buyers think (especially Jordan and Taylor personas who need specific brands).

**Lack of supplier context:** Users don't know if supplier specializes in women's wear, vintage denim, athletic wear, etc. Hard to assess fit before clicking.

#### User Feedback Connection
Users want transparency into what they're buying and who they're buying from.

---

### 5. Supplier/Product Pages

#### Issues

| Issue | Severity | Screenshot | Maps to Feedback Theme |
|-------|----------|------------|------------------------|
| Follow icon (bell) unclear | Medium | `fleek-supplier-01.png` | UX Clarity |
| Video call in app (why?) | Low | `fleek-supplier-02.png` | Feature Bloat |
| Tags not accessible unless you press message | Medium | `fleek-supplier-03.png` | Information Architecture |
| Graphics blurry and inconsistent | **CRITICAL** | `fleek-supplier-04.png` | Trust & Legitimacy |
| **Bad reviews at top of page** | **CRITICAL** | `fleek-supplier-05.png` | Trust & Legitimacy |
| Fakes are major rating concern | High | `fleek-supplier-06.png` | Trust & Legitimacy |
| Quality not clear upfront | High | `fleek-supplier-07.png` | Product Uncertainty |

#### Analysis
**Trust killer: Bad reviews surfaced first:** When user is already skeptical, seeing negative reviews at top reinforces "this is a scam" perception. 

**Better approach:** 
- Vinted/Depop prompt positive reviews (users will complain anyway if experience is bad)
- Weight by relevance/helpfulness, not recency
- Show response from supplier (Etsy pattern)

**Graphics quality:** Blurry product photos + blurry UI graphics = looks unprofessional and untrustworthy.

**"Global shipping included" hidden:** This is HUGE value prop, should be prominent.

**Quality expectations:** Users mention in feedback that if expectations are set (low or high quality), they won't rate as negatively. Transparency needed.

#### User Feedback Connection
> "It's quite scary just knowing that there's so many fakes about and they won't be picked up. …The main selling point for me when I started buying on Fleek was that everything would be authentic and it come out at quality control… but then if it's not going to then that element of trust is definitely removed."

Reviews mentioning fakes + lack of visible QC = trust breakdown.

---

### 6. Ratings & Trust Signals

#### Issues

| Issue | Severity | Screenshot | Maps to Feedback Theme |
|-------|----------|------------|------------------------|
| Rating system confusing | High | `fleek-ratings-01.png` | Supplier Rating Opacity |
| Not clear what drives ratings | High | `fleek-ratings-02.png` | Supplier Rating Opacity |
| No breakdown of rating components | High | `fleek-ratings-03.png` | Supplier Rating Opacity |
| Reviews all bad at top | **CRITICAL** | `fleek-ratings-04.png` | Trust & Legitimacy |
| Relevance algorithm can be adjusted | Medium | `fleek-ratings-05.png` | Product Opportunity |

#### Analysis
**Universal pain point:** Rating opacity affects all personas, validated in user feedback across multiple quotes.

**Missing transparency:** Users want to know:
- Why is this supplier rated 3.5/5?
- Is it delivery speed? Product quality? Communication?
- Can I mitigate the risk?

#### User Feedback Connection
> "I can never really figure out exactly what's caused that score to be low. …Was it delivery time? Don't know. …I figure that the score should just I should know why they've got a bad score because at least then if I know what their bad points are, I can try and mitigate it."

#### Better Approach (from competitors)
- **Etsy:** Seller page shows (sales / rating / years active) clearly at top
- **Etsy:** Item page shows rating breakdown, shipping info, similar items
- **eBay:** Ratings, shipping, and similar items all prominent

---

### 7. "How It Works" & Help

#### Issues

| Issue | Severity | Screenshot | Maps to Feedback Theme |
|-------|----------|------------|------------------------|
| Links to cramped mobile site render | High | `fleek-help-01.png` | Trust & UX |
| Should be in-app and more beautiful | High | `fleek-help-02.png` | Trust & UX |
| Buyer protection hidden in settings | **CRITICAL** | `fleek-help-03.png` | Trust & Legitimacy |
| FAQs not prominent | Medium | `fleek-help-04.png` | Self-Service |

#### Analysis
**Buyer protection is a trust signal:** Should be visible early in journey, not buried in settings. Vinted makes this mistake too.

**"How it works" should be native:** Linking to mobile site feels janky and unpolished.

#### User Feedback Connection
Users need human validation before trusting. Clear "How it works" + visible buyer protection could reduce this need.

---

### 8. Email & Communications

#### Issues

| Issue | Severity | Screenshot | Maps to Feedback Theme |
|-------|----------|------------|------------------------|
| Onboarding email confusing | High | `fleek-email-01.png` | Trust & Consistency |
| Promo emails poor quality and inconsistent | High | `fleek-email-02.png` | Trust & Consistency |

#### Analysis
**Consistency matters across touchpoints:** If app is improving but emails are poor, it breaks overall trust.

---

## Summary: Priority Issues by Theme

### 🔴 Critical (Must Fix)

**Trust & Legitimacy:**
1. **Blurry, inconsistent graphics** (QUICK WIN - design refresh)
2. **Bad reviews surfaced at top** (adjust relevance algorithm)
3. **No visible quality control/buyer protection**
4. **No feedback loop after personalization** (breaks trust in tech)

**Product Uncertainty:**
5. **Homepage generic despite personalization** (no reward for effort)
6. **Quality expectations not set upfront**

### 🟡 High Priority (Should Fix)

**Onboarding:**
7. Questions don't explain "why" (rationale missing)
8. Phone number too early (friction)
9. No mission statement (brand/trust)

**Discovery:**
10. Too much going on (cognitive overload)
11. No supplier specialization context
12. Pricing confusion (bundles + sliding scale)

**Ratings:**
13. Rating system opacity (universal pain)
14. No breakdown of what drives ratings

### 🟢 Medium/Low (Nice to Have)

15. Swipe through onboarding
16. "Maybe later" too prominent
17. Video call feature (why?)
18. Bundle builder feels separate
19. Follow icon unclear

---

## Design Consistency Issues (Easy Wins)

| Element | Issue | Priority | Effort |
|---------|-------|----------|--------|
| Onboarding graphics | Blurry, low quality | P0 | Low (design refresh) |
| Product photos | Inconsistent quality | P1 | Medium (supplier guidelines) |
| Email templates | Poor quality, off-brand | P1 | Low (template update) |
| UI icons | Inconsistent style | P2 | Low (icon library) |

**Recommendation:** Bundle all design consistency fixes into Sprint 1 "Trust & Polish" initiative.

---

## Areas Identified for Improvement

### 1. **Consistency**
- Design quality (graphics, photos, icons)
- Brand voice across app and email
- Visual hierarchy and information architecture

### 2. **Trust**
- Rating transparency and breakdown
- Visible quality control process
- Buyer protection prominence
- Email onboarding quality
- Review relevance algorithm

### 3. **Discoverability**
- Reduce cognitive overload (too much at once)
- Personalization feedback loop
- Supplier specialization clarity
- Browse-first UI optimization

### 4. **Pricing**
- Clarify bundles vs. sliding scale
- Make starter bundles (£50-100) accessible

### 5. **Onboarding**
- Explain "why" for each question
- Show personalization results immediately
- Delay phone number request
- Add mission statement

---

## Holistic Experience Assessment

**Current State:** 
Platform feels generic, overwhelming, and untrustworthy. User faces trust barriers at multiple points:
1. Signup: Low-quality graphics
2. Onboarding: No clear value/rationale
3. Homepage: Personalization didn't work (or seems like it didn't)
4. Product pages: Bad reviews + blurry photos
5. Email: Inconsistent and confusing

**Desired State:**
Platform feels curated, trustworthy, and personalized. User experiences:
1. Signup: Professional visuals build credibility
2. Onboarding: Clear value, immediate feedback showing it worked
3. Homepage: Personalized results that match preferences
4. Product pages: Clear quality expectations, helpful reviews, transparent ratings
5. Email: On-brand, helpful, builds relationship

**Gap Analysis:**
Instead of narrowing toward a purchase, user hits "expanse of options" followed by "trust wall" (bad reviews). This matches user feedback perfectly.

---

## Questions for Data Analysis

1. **Where do users drop off?**
   - After signup but before onboarding?
   - After onboarding but before browsing?
   - After browsing but before adding to cart?
   - In cart before checkout?

2. **Does personalization correlate with conversion?**
   - Do users who complete personalization convert more?
   - Do they browse longer?
   - Do they return more?

3. **How do reviews impact conversion?**
   - Does viewing reviews correlate with drop-off?
   - Does supplier rating correlate with purchase?

4. **Bundle size and affordability:**
   - What's the distribution of bundle prices?
   - What's the average first-time purchase amount?
   - Do users who view cheaper bundles convert more?

---

## References

- User feedback: [`/projects/personas/fleek-user-feedback-mapping.md`](../../personas/fleek-user-feedback-mapping.md)
- Competitor patterns: [`/projects/competitors/ux-patterns-benchmarking.md`](../../competitors/ux-patterns-benchmarking.md)
- Company context: [`/projects/company-context/fleek-company-overview.md`](../../company-context/fleek-company-overview.md)
