# Product-Level Artifacts

## Purpose
This folder contains product-level artifacts that span across multiple initiatives: roadmap, engineering backlog, and feedback repository.

## Structure

### `roadmap/`
High-level product roadmap and strategic planning
- Quarterly roadmaps
- Theme-based roadmap views
- Prioritization frameworks
- Strategic bets and initiatives

### `backlog/`
Engineering and discovery backlogs
- **Engineering backlog** - Validated work ready for implementation
- **Discovery backlog** - Research questions and opportunities to explore
- **Technical debt** - Architecture and infrastructure work

### `feedback/`
Centralized customer and user feedback
- Customer feedback logs
- Feature requests
- User research themes
- Support ticket patterns
- Usage insights

---

## How These Connect to Initiatives

```
/product/roadmap/          →  Informs which initiatives to start
     ↓
/projects/initiatives/[name]/       →  Active work (discovery + delivery)
     ↓
/product/backlog/          →  Validated work waiting to be scheduled
     ↓
/product/feedback/         →  Captures learnings and requests
     ↓ (loops back)
/product/roadmap/          →  Informs future roadmap updates
```

## Usage Patterns

### Roadmap Planning
1. Review company-level strategy and OKRs
2. Analyze feedback themes and user needs
3. Prioritize opportunities for next quarter
4. Create initiatives for highest-priority work
5. Document in `roadmap/roadmap-[year]-[quarter].md`

### Backlog Management
- **Discovery backlog:** Research questions from user feedback, data analysis, or strategy
- **Engineering backlog:** Validated features from completed discovery, ready for delivery
- **Prioritize regularly:** Weekly or bi-weekly review against current capacity

### Feedback Processing
1. Log all feedback in `feedback/feedback-log.md`
2. Tag by theme, user segment, urgency
3. Synthesize monthly into themes
4. Use themes to inform discovery research questions
5. Connect to opportunities in active initiatives

---

## File Naming Conventions

### Roadmap
- `roadmap-2025-Q1.md` - Quarterly roadmap
- `roadmap-themes.md` - Theme-based view
- `prioritization-framework.md` - How we prioritize

### Backlog
- `engineering-backlog.md` - Ready-to-build features
- `discovery-backlog.md` - Research questions
- `technical-debt.md` - Infrastructure work

### Feedback
- `feedback-log.md` - Running log of all feedback
- `themes-[month].md` - Monthly synthesis
- `feature-requests.md` - Specific feature asks

---

## Integration with Frameworks

- **Strategic Review:** Use `@pm-toolkit/1-strategy/product-strategy-review.mdc` to evaluate roadmap alignment
- **OKRs:** Connect roadmap to `@projects/company-context/okrs/`
- **Prioritization:** Use `@pm-toolkit/4-prioritization/calculate-ice-score.mdc` for backlog prioritization
- **Feedback Analysis:** Use `@pm-toolkit/8-analytics/quick-insights.mdc` for feedback theme extraction

---

**This folder keeps product-level artifacts separate from initiative-specific work while maintaining clear connections between them.**
