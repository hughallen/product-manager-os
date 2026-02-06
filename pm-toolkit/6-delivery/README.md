# 6. Delivery

## Purpose
Break down validated solutions into tasks, coordinate team handoffs, and ship features.

## When to Use
- **After planning:** When PRD and design specs are ready
- **During sprints:** Task generation and processing
- **For handoffs:** Preparing work for other teams

## Available Tools

### Task Management

#### `generate-tasks.mdc`
**What:** Break down PRD into granular, implementable tasks  
**When:** After PRD is complete and approved  
**Output:** Detailed task list with acceptance criteria  
**Saves to:** `projects/initiatives/[name]/tasks/`

#### `process-task-list.mdc`
**What:** Systematically work through task list with AI  
**When:** During implementation, one task at a time  
**Output:** Completed tasks with verification checkpoints

### Team Handoffs

All handoff templates in `handoffs/` subfolder:

#### `to-engineering.mdc`
**What:** Transform PRD into technical specifications  
**Output:** Technical specs with acceptance criteria, edge cases, data requirements  
**Audience:** Engineering team  
**Contains:** API requirements, data models, test scenarios, dependencies

#### `to-design.mdc`
**What:** Create design brief from product requirements  
**Output:** Design brief with user problems, flows, constraints  
**Audience:** Design team  
**Contains:** User journey, design requirements, success criteria, research insights

#### `to-leadership.mdc`
**What:** Create executive summary with business case  
**Output:** Executive brief with impact, resources, risks  
**Audience:** C-suite, VPs, leadership team  
**Contains:** Business impact, ROI, resource requirements, strategic alignment

#### `to-marketing.mdc`
**What:** Create GTM materials and positioning  
**Output:** Marketing brief with value prop, messaging, positioning  
**Audience:** Marketing/GTM team  
**Contains:** Customer value, positioning, messaging framework, launch plan

#### `to-sales.mdc`
**What:** Create sales enablement materials  
**Output:** Sales brief with pitch, demo flow, competitive positioning  
**Audience:** Sales team  
**Contains:** 30-second pitch, objection handling, ROI calculator, competitive battle cards

#### `to-customer-success.mdc`
**What:** Create support and training materials  
**Output:** Support brief with FAQs, troubleshooting, training  
**Audience:** Customer Success/Support team  
**Contains:** Feature explanation, troubleshooting guide, training scripts, known issues

## Typical Delivery Flow

```
1. PRD Complete (from 3-planning/)
   ↓ Use: generate-tasks.mdc
   
2. Generate Task List
   ↓ Use: handoffs/to-engineering.mdc
   
3. Engineering Handoff
   ↓ Use: handoffs/to-design.mdc (if needed)
   
4. Design Handoff (if applicable)
   ↓ Development begins
   ↓ Use: process-task-list.mdc
   
5. Process Tasks One by One
   ↓ Verification checkpoints
   
6. Pre-Launch Handoffs
   ↓ Use: handoffs/to-marketing.mdc
   ↓ Use: handoffs/to-sales.mdc
   ↓ Use: handoffs/to-customer-success.mdc
   
7. Launch Preparation
   ↓ All teams enabled
   
8. Ship Feature
```

## Sprint Planning Integration

**Week 1:**
- Generate tasks from PRD
- Create engineering handoff
- Estimate and sequence work

**Weeks 2-N:**
- Process task list systematically
- Verification at each checkpoint
- Track progress in task file

**Pre-Launch:**
- Complete all team handoffs
- Enable marketing, sales, support
- Final QA and launch checklist

## Handoff Best Practices

### When to Create Handoffs
- **Engineering:** As soon as PRD is approved
- **Design:** When design work kicks off (may be earlier)
- **Leadership:** For approval or major updates
- **Marketing:** 2-4 weeks before launch
- **Sales:** 1-2 weeks before launch
- **Customer Success:** 1 week before launch

### Handoff Quality
- Start from complete PRD or requirements
- Include all context from discovery and planning
- Link to evidence and research
- Specify what's in/out of scope
- Define success criteria clearly

### Multiple Handoffs
- One PRD can generate multiple handoffs
- Customize for each audience's needs
- Update handoffs as scope changes
- Version control handoff documents

## Integration with Other Stages

**From Planning (3-planning/):**
- PRD drives task generation
- Requirements inform handoffs
- Acceptance criteria become test scenarios

**From Design (5-design/):**
- Design specs supplement engineering handoff
- Wireframes inform implementation
- Design brief aligns with technical approach

**To Analytics (8-analytics/):**
- Instrumentation requirements defined
- Success metrics tracked
- Experiment setup prepared

## Task Management Tips

### Task Granularity
- **Good:** "Implement user authentication API endpoint"
- **Too big:** "Build authentication system"
- **Too small:** "Add import statement"

### Verification Checkpoints
- Each task should have clear "done" criteria
- Test scenarios for verification
- Review before moving to next task

### Progress Tracking
- Mark tasks as complete in task file
- Update `.agent-memory/context.md` with progress
- Document blockers and decisions

---

**Remember:** Delivery is about systematic execution and clear handoffs. Break work into manageable tasks and ensure all teams have what they need to succeed!
