# Next Steps - Fleek Activation Initiative

**Last Updated:** February 16, 2026  
**Current Phase:** Fixing methodology errors → Interview prep

---

## Immediate Actions (Now)

### 1. Complete File Organization Fixes ⏳
**Priority:** High  
**Status:** In progress

**Tasks:**
- [x] Remove fabricated quotes from README.md and company-overview.md
- [x] Create .agent-memory/ folder and files
- [ ] Reorganize file structure to match dual-track model
- [ ] Update planning docs to be data-dependent (not assumption-driven)
- [ ] Explicitly mark all validation levels across documents

**Why:** Align with AGENTS.md standards, fix core methodology errors

**Owner:** AI assistant  
**Timeline:** Now

---

### 2. Decide on File Organization Approach 🤔
**Priority:** High  
**Status:** Blocked - need Hugh's decision

**Question:** Should personas be:
- **Option A:** Company-wide (`projects/product-artifacts/personas/`) because they're reusable across initiatives?
- **Option B:** Initiative-specific (`projects/initiatives/fleek-activation/personas/`) per AGENTS.md dual-track?
- **Option C:** Both (company-wide for reference, initiative-specific for work)?

**Current State:** Personas moved to `projects/product-artifacts/personas/` per jinjin1 structure

**AGENTS.md says:**
- Company-wide context goes in `projects/company-context/`
- Initiative work goes in `projects/initiatives/[name]/`
- Dual-track structure has discovery → opportunities/solutions, delivery → specs/designs

**Trade-offs:**
- Company-wide: Reusable, single source of truth, but doesn't follow initiative structure
- Initiative-specific: Follows AGENTS.md, but duplicates if multiple initiatives need personas

**Recommendation:** Keep personas company-wide for now (they're broader than just activation problem), but create initiative-specific research in proper dual-track folders

**Action needed:** Hugh confirms approach

---

### 3. Fix Planning Docs (Assumptions → Hypotheses) 📝
**Priority:** High  
**Status:** Ready to start (after Hugh confirms approach)

**Files to update:**
- `planning/activation-improvement-plan.md` - Currently assumes Persona 1 is problem
- `planning/experiment-ideas.md` - Currently designs experiments for Persona 1

**Changes needed:**
- Reframe as "IF data shows X, THEN Y" conditional logic
- Present multiple scenarios (Persona 1 vs 2 vs 3)
- Add data analysis step at beginning
- Make success metrics data-dependent

**Why:** Can't solve problem until we know which persona has it

**Confidence:** Medium - need to balance interview prep utility vs data dependency

---

## Short-Term Actions (Before Interview)

### 4. Data Analysis Preparation 📊
**Priority:** Critical  
**Status:** Not started

**What's needed:**
- SQL queries to segment users by persona indicators (budget, order size, behavior)
- Funnel analysis (Signup → Browse → Supplier → Bundle → Cart → Checkout)
- Activation rate by segment
- Drop-off point identification

**Deliverable:** Data analysis plan ready for when Hugh gets database access

**Timeline:** 24 hours before interview (per Hannah's instructions)

---

### 5. Solution Design Framework ✏️
**Priority:** High  
**Status:** Not started

**What's needed:**
- Multiple solution scenarios based on which persona has problem
- Design mocks/wireframes for top 2-3 interventions
- Experiment design for each solution
- 6-week implementation roadmap (conditional on data findings)

**Why:** Interview includes "live solution design and mockup session"

**Timeline:** After data analysis, before interview

---

### 6. Interview Prep Materials 🎯
**Priority:** Medium  
**Status:** Not started

**What's needed:**
- Case study presentation structure
- Key insights summary
- Solution options with trade-offs
- Metrics framework
- Questions to ask Hannah during interview

**Timeline:** Before interview day

---

## Medium-Term Actions (Post-Interview)

### 7. Create Dual-Track Folder Structure 📁
**Priority:** Medium (for learning, not urgent for interview)  
**Status:** Not started

**Folders to create:**
```
projects/initiatives/fleek-activation/
├── interviews/           # User research (discovery)
│   ├── transcripts/
│   ├── snapshots/
│   └── synthesis/
├── opportunities/        # Needs identified (discovery)
├── solutions/            # Solution ideas (discovery)
├── assumptions/          # Tests (discovery)
├── specs/                # PRDs (delivery)
├── designs/              # Design work (delivery)
├── tasks/                # Implementation (delivery)
└── data/                 # Analytics
```

**Why:** Proper workspace organization per AGENTS.md

**Timeline:** After interview (for learning and practice)

---

## Questions for Hugh

1. **File organization:** Keep personas company-wide or move into initiative?
2. **Planning docs:** Should we present multiple scenarios (IF Persona 1 vs 2 vs 3) in interview, or wait for data?
3. **Scope:** Is interview prep about showing process/thinking, or about having a complete solution ready?
4. **Data access:** When will you get database access for data analysis?
5. **Priorities:** What's most important to nail in the interview - data analysis, solution design, or strategic thinking?

---

## Risks & Blockers

**Risk 1:** Planning docs built on wrong assumptions  
**Mitigation:** Reframe as conditional/data-dependent

**Risk 2:** No data access before interview  
**Mitigation:** Show data analysis approach, multiple scenarios, hypothesis-driven thinking

**Risk 3:** File organization doesn't match AGENTS.md  
**Mitigation:** Fix structure, demonstrate learning from mistakes

**Blocker:** Need Hugh's guidance on file organization approach before proceeding

---

## Success Criteria (For This Work)

- [ ] All files follow AGENTS.md standards
- [ ] No fabricated quotes or unsupported claims
- [ ] All assumptions explicitly marked (✅ ⚠️ ❓)
- [ ] Dual-track structure in place
- [ ] Planning docs are data-dependent
- [ ] .agent-memory/ tracks decisions and context
- [ ] Ready for data analysis step
- [ ] Demonstrates corrected methodology in interview

---

## Learning Outcomes

**What I learned:**
1. Always read AGENTS.md first
2. Follow alwaysApply: true files (strategic copilot)
3. Evidence > opinion (don't fabricate quotes)
4. Mark all claims as validated/assumed/unknown
5. Ask clarifying questions vs assuming

**What Hugh is teaching:**
- Rigorous evidence-based PM thinking
- Proper use of workspace structure
- Intellectual honesty about unknowns
- Following established frameworks (persona-generator, strategic copilot)
