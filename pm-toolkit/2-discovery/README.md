# 2. Discovery

## Purpose
Continuously understand user problems, identify opportunities, and validate solutions through weekly research activities.

## When to Use
- **Weekly:** Ongoing user interviews and research synthesis
- **Continuous:** Throughout product development, not just upfront
- **Parallel to delivery:** Run discovery while building to inform future work

## Available Tools

### Continuous Discovery Habits Framework
All tools in `continuous-discovery-habits/` subfolder:

#### `create-interview-snapshots.mdc`
**What:** Extract structured insights from individual user interviews  
**When:** After each user interview or usability test  
**Output:** Interview snapshot with stories, journey maps, opportunities  
**Saves to:** `projects/initiatives/[name]/interviews/snapshots/`

#### `synthesize-interview-snapshots.mdc`
**What:** Find patterns and themes across multiple interviews  
**When:** After collecting 3-5 interview snapshots  
**Output:** Synthesis document with common themes and prioritized opportunities  
**Saves to:** `projects/initiatives/[name]/interviews/synthesis/`

#### `create-opportunities.mdc`
**What:** Identify and frame user needs, pain points, and desires  
**When:** From research synthesis or user feedback analysis  
**Output:** Opportunity map or list with evidence and impact  
**Saves to:** `projects/initiatives/[name]/opportunities/`

#### `generate-solutions.mdc`
**What:** Ideate multiple solutions for identified opportunities  
**When:** After opportunities are validated and prioritized  
**Output:** Solution options with trade-offs and assumptions  
**Saves to:** `projects/initiatives/[name]/solutions/`

#### `identify-and-test-assumptions.mdc`
**What:** Surface and validate riskiest assumptions before building  
**When:** Before committing to a solution direction  
**Output:** Assumption log with test plans and results  
**Saves to:** `projects/initiatives/[name]/assumptions/`

## Typical Discovery Flow

```
1. Interview Users
   ↓ Use: create-interview-snapshots.mdc
   
2. Create Snapshots (3-5 interviews)
   ↓ Use: synthesize-interview-snapshots.mdc
   
3. Synthesize Patterns
   ↓ Use: create-opportunities.mdc
   
4. Identify Opportunities
   ↓ Prioritize top opportunities
   ↓ Use: generate-solutions.mdc
   
5. Generate Solutions
   ↓ Use: identify-and-test-assumptions.mdc
   
6. Test Assumptions
   ↓ Validate before building
   
7. Move to Planning (3-planning/)
```

## Weekly Discovery Rhythm

**Recommended cadence:**
- **2-3 user interviews per week**
- **30-60 min** synthesis session weekly
- **Create snapshots** within 24 hours of interviews
- **Monthly** opportunity review and prioritization

## Best Practices

### Interview Quality
- Focus on specific stories, not hypotheticals
- Ask about past behavior, not future intentions
- Capture context: when, where, why, with whom
- Record emotional moments and frustrations

### Synthesis Discipline
- Don't cherry-pick data to support existing ideas
- Look for disconfirming evidence
- Identify patterns across interviews, not just quotes
- Connect opportunities to specific user stories

### Continuous, Not Waterfall
- Discovery doesn't end when building starts
- Run discovery in parallel with delivery track
- Validate future opportunities while building current ones
- Weekly touchpoints with customers, not just phases

## Integration with Other Stages

**From Strategy (1-strategy/):**
- Discovery focuses on areas defined by strategy
- Opportunities ladder up to strategic goals
- Research validates strategic assumptions

**To Planning (3-planning/):**
- Validated opportunities become PRDs
- Evidence from discovery supports planning
- User stories inform requirements

**To Prioritization (4-prioritization/):**
- Opportunity size and evidence inform ICE scores
- Assumption tests provide confidence levels

## Related Resources

- [Continuous Discovery Habits book](https://www.producttalk.org/2021/05/continuous-discovery-habits/) by Teresa Torres
- Interview snapshot format based on CDH methodology
- Opportunity solution tree approach

---

**Remember:** Discovery is continuous, not a phase. Run these activities weekly to stay connected to users and validate your direction!
