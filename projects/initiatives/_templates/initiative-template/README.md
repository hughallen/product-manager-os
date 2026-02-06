# [Initiative Name]

**Status:** [Planning/Discovery/In Progress/Complete]  
**Timeline:** [Start Date] - [Target End Date]  
**Owner:** [Product Manager Name]  
**Stakeholders:** [Key stakeholders and their roles]

## 🎯 Initiative Goal
[Clear, concise description of what we're trying to achieve and why it matters]

## 🔄 Process Model: Dual-Track Continuous Discovery

This initiative follows a **dual-track approach** where discovery and delivery run in parallel:

### 🔍 Discovery Track (Continuous - Weekly)
Ongoing research and validation to understand problems and test solutions
- **Current focus:** [What we're learning this week]
- **Latest insights:** [Recent key finding]
- **Next interviews:** [Planned research]

### 🚀 Delivery Track (Sprint-based)
Building and shipping validated solutions
- **Current sprint:** [What we're building]
- **Progress:** [Percentage or status]
- **Next milestone:** [Upcoming delivery]

---

## 📊 Status Checklist

### Discovery Track
- [ ] User Research Started
- [ ] Opportunities Identified  
- [ ] Solutions Explored
- [ ] Assumptions Tested

### Delivery Track
- [ ] PRD Drafted
- [ ] Design Complete
- [ ] Tasks Generated
- [ ] Development Started
- [ ] Analytics Instrumented
- [ ] Shipped to Users

## 🗂️ Folder Structure

### 🔍 Discovery Track (Continuous)
Research, validation, and opportunity identification happening weekly

- **[interviews/](./interviews/)** - User research and insights
  - `transcripts/` - Raw interview recordings and notes
  - `snapshots/` - Individual interview insights using `@create-interview-snapshots.mdc`
  - `synthesis/` - Cross-interview patterns using `@synthesize-interview-snapshots.mdc`
- **[opportunities/](./opportunities/)** - Identified user needs and pain points
  - Created using `@create-opportunities.mdc`
- **[solutions/](./solutions/)** - Solution explorations and ideation
  - Generated using `@generate-solutions.mdc`
- **[assumptions/](./assumptions/)** - Assumption testing and validation
  - Tracked using `@indentify-and-test-assumptions.mdc`

### 🚀 Delivery Track (Sprint-based)
Building and shipping validated solutions

- **[specs/](./specs/)** - Product requirements and specifications
  - PRDs created using `@create-prd.mdc`
  - One-pagers using `@create-1-pager.mdc`
- **[designs/](./designs/)** - Design artifacts and specifications
  - Design briefs using `@create-design-brief.mdc`
  - ASCII wireframes for rapid iteration
  - Can reference `@pm-toolkit/5-design/design-reference-library/` for consistency
- **[tasks/](./tasks/)** - Implementation work
  - Tasks generated using `@generate-tasks.mdc`
  - Processed using `@process-task-list.mdc`

### 📊 Analytics & Learning (Continuous across both tracks)
Measurement and insights informing both discovery and delivery

- **[data/](./data/)** - Analytics, metrics, experiments
  - Quick analysis using `@quick-insights.mdc`
  - Discovery analytics (usage patterns, user behavior)
  - Delivery metrics (performance, adoption, impact)

### 🧠 Shared Context
Cross-track information and decisions

- **[.agent-memory/](./.agent-memory/)** - AI context and process state
  - `decisions.md` - Key decisions and rationale
  - `context.md` - Current initiative state
  - `next-steps.md` - Recommended actions

## 🔗 Quick Links

### Discovery Track
- [User Research Summary](./interviews/synthesis/)
- [Opportunity Map](./opportunities/)
- [Solution Ideas](./solutions/)
- [Assumption Tests](./assumptions/)

### Delivery Track
- [PRD & Specs](./specs/)
- [Design Work](./designs/)
- [Implementation Tasks](./tasks/)

### Shared
- [Analytics & Data](./data/)
- [Decision Log](./.agent-memory/decisions.md)
- [Current Context](./.agent-memory/context.md)

## 📝 Notes
[Any additional context, assumptions, or important information about this initiative]

---
*Created using initiatives template. Use `@projects/initiatives/_templates/setup-new-initiative.mdc` for new initiatives.*
