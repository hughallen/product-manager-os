# PM Toolkit

## Overview
This folder contains all reusable prompts, guides, and frameworks organized by your product development workflow stages.

## How to Use
1. **Find your stage** - Navigate to the numbered folder for your current workflow stage
2. **Use with @** - Reference files in Cursor with `@pm-toolkit/[stage]/[file].mdc`
3. **Browse to discover** - Explore each stage folder to see what tools are available

## Workflow Stages

### 1. Strategy
**When:** Quarterly planning, annual strategy reviews, vision refinement  
**Tools:**
- `product-strategy-review.mdc` - PRISM framework strategy review
- `product-vision-review.mdc` - 4-criteria vision evaluation
- `okr-sparring-partner.mdc` - OKR development and coaching
- `pm-strategic-copilot.mdc` - Strategic advisor configuration

**Use when:** Setting direction, reviewing strategy, defining OKRs

---

### 2. Discovery
**When:** Weekly user research, continuous discovery activities  
**Tools in `continuous-discovery-habits/`:**
- `create-interview-snapshots.mdc` - Extract insights from interviews
- `synthesize-interview-snapshots.mdc` - Find patterns across interviews
- `create-opportunities.mdc` - Identify user needs and pain points
- `generate-solutions.mdc` - Ideate solutions for opportunities
- `identify-and-test-assumptions.mdc` - Validate riskiest assumptions

**Use when:** Conducting user research, understanding problems, identifying opportunities

---

### 3. Planning
**When:** Defining what to build, creating specifications  
**Tools:**
- `create-prd.mdc` - Product Requirements Document
- `create-1-pager.mdc` - Executive summary/one-pager

**Use when:** Documenting requirements, getting alignment on what to build

---

### 4. Prioritization
**When:** Deciding what to build first, sequencing work  
**Tools:**
- `calculate-ice-score.mdc` - ICE scoring framework (Impact, Confidence, Ease)

**Use when:** Prioritizing backlog, making trade-off decisions

---

### 5. Design
**When:** Creating design specifications, generating wireframes  
**Tools:**
- `create-design-brief.mdc` - Brief for design team
- `generate-figma-make-prompt.mdc` - Figma prompt generation
- `design-reference-library/` - Design patterns and references (optional)

**Use when:** Kicking off design work, creating wireframes, handing off to designers

**Note:** AI can generate ASCII wireframes on-the-fly - just ask!

---

### 6. Delivery
**When:** Building, implementing, shipping features  
**Tools:**
- `generate-tasks.mdc` - Break down PRD into tasks
- `process-task-list.mdc` - Systematically work through tasks
- **Handoffs folder** - Audience-specific handoff templates:
  - `handoffs/to-engineering.mdc` - Technical specs
  - `handoffs/to-design.mdc` - Design briefs
  - `handoffs/to-leadership.mdc` - Executive summaries
  - `handoffs/to-marketing.mdc` - GTM materials
  - `handoffs/to-sales.mdc` - Sales enablement
  - `handoffs/to-customer-success.mdc` - Support materials

**Use when:** Implementation planning, team handoffs, task management

---

### 7. Experimentation
**When:** Running experiments, A/B tests, prototypes  
**Tools:** (Coming soon - add your experiment frameworks here)

**Use when:** Testing hypotheses, validating solutions, measuring impact

---

### 8. Analytics
**When:** Analyzing data, measuring outcomes, extracting insights  
**Tools:**
- `quick-insights.mdc` - 30-second data analysis with ASCII visualizations

**Use when:** Analyzing CSVs, user feedback, metrics, survey results

---

### 9. Evals
**When:** Evaluating AI features, measuring AI performance  
**Tools:** (Coming soon - add your AI evaluation frameworks here)

**Use when:** Testing AI features, measuring quality, evaluating model performance

---

## Supporting Tools

**Cross-stage tools that don't fit one workflow phase:**

### `supporting/`
- `1-1s.mdc` - One-on-one meeting guide
- `writing.mdc` - Writing improvement guide
- `team-structure-guide.md` - Team organization models

**Use when:** Running meetings, improving communication, designing team structure

---

## Adding New Tools

When you create new frameworks or guides:
1. **Determine the stage** - Which workflow phase does it support?
2. **Place in appropriate folder** - Add to the numbered stage folder
3. **Update this README** - Add to the list above
4. **Use consistent naming** - Use kebab-case: `my-new-tool.mdc`

---

## Quick Reference Card

| Stage | Use When... | Key Tools |
|-------|------------|-----------|
| **1-strategy** | Setting direction | Strategy review, Vision eval, OKRs |
| **2-discovery** | Understanding problems | Interviews, Opportunities, Solutions |
| **3-planning** | Defining what to build | PRD, One-pager |
| **4-prioritization** | Deciding what's first | ICE scoring |
| **5-design** | Creating specs | Design brief, Wireframes |
| **6-delivery** | Building & shipping | Tasks, Handoffs |
| **7-experimentation** | Testing hypotheses | (Add your tools) |
| **8-analytics** | Measuring outcomes | Quick insights |
| **9-evals** | Evaluating AI | (Add your tools) |
| **supporting** | Cross-cutting needs | Meetings, Writing |

---

**Remember:** This is your toolkit library. Browse by stage to discover what's available, then reference with `@` in Cursor to use!
