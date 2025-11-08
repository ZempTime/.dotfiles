---
name: creating-revealjs-presentations
description: Use when creating or modifying reveal.js presentations - enforces refactoring inline styles and class-based slides to Tailwind CSS, then guides effective use of reveal.js features (vertical slides, fragments, formatted speaker notes) to convey ideas
---

# Creating reveal.js Presentations

**Core principle:** Every reveal.js feature must serve a communication purpose.

## Pre-Flight Check (MANDATORY)

**Before ANY work, scan existing presentation:**

```
□ Inline style= attributes found?
□ .slide1, .slide2 CSS classes found?

If YES to either → Refactor ENTIRE presentation first
```

**Refactoring workflow when anti-patterns detected:**

1. Say to user: "I'll refactor to Tailwind CSS while maintaining your colors/aesthetic, then add new slides."
2. Add Tailwind CDN: `<script src="https://cdn.tailwindcss.com"></script>`
3. Refactor ALL slides: Remove `style=` and `.slideN` classes, replace with Tailwind + `data-background-*`
4. Then proceed with user's request

**"Same style" = same colors/visual design, NOT same implementation.**

**If you extend bad patterns instead of refactoring, you have violated this skill.**

## Core Patterns

### Tailwind CSS for All Styling

**Setup:**
```html
<head>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
```

**Usage:**
```html
<!-- ✅ GOOD -->
<section data-background-color="#1e293b">
  <h1 class="text-6xl font-bold text-slate-100 mb-8">Title</h1>
</section>

<!-- ❌ BAD -->
<section class="slide1" style="background: red;">
  <h1 style="font-size: 48px;">Title</h1>
</section>
```

### Purpose-Driven Effects

**NOT valid purposes:** "Draws attention", "looks cool", "makes it engaging", "user asked for flashy"

**ACTUAL purposes:** Shows transformation, implies progression, emphasizes relationship, indicates topic change

```html
<!-- ✅ Shows transformation -->
<section data-auto-animate>
  <div data-id="box" class="h-12 w-12 bg-blue-500"></div>
</section>
<section data-auto-animate>
  <div data-id="box" class="h-48 w-48 bg-blue-500"></div>
</section>

<!-- ❌ Effect without purpose -->
<section data-transition="zoom">
  <h1>Features</h1>
</section>
```

**Default:** `data-transition="slide"` or none unless you have specific reason.

### Content Structure

| Pattern | Use For | Code |
|---------|---------|------|
| Horizontal slides | Main narrative flow | `<section>Topic</section>` |
| Vertical slides | Optional detail on topic | Nested `<section>` |
| Fragments | Progressive reveal | `class="fragment"` |

```html
<section><!-- Main point -->
  <section><h2>Overview</h2></section>
  <section><!-- Vertical: detail --><h3>Details</h3></section>
</section>
```

### Speaker Notes (MANDATORY)

**Every slide must have properly formatted speaker notes.**

```html
<aside class="notes">
  <p><strong>Key Points:</strong></p>
  <ul>
    <li>Point 1 with context</li>
    <li>Point 2 with timing</li>
  </ul>
  <p>Additional detail for presenter.</p>
</aside>
```

**Format requirements:**
- Use `<p>`, `<ul>`/`<ol>`, `<strong>`/`<em>`
- Break up long text for legibility

## Quick Reference

| Feature | Example |
|---------|---------|
| Tailwind styling | `class="text-4xl font-bold text-blue-600"` |
| Slide backgrounds | `data-background-color="#1e293b"` |
| Fragments | `<li class="fragment">Item</li>` |
| Auto-animate | Same `data-id` across slides |
| Speaker notes | `<aside class="notes"><p>...</p></aside>` |
| Overview mode | Press ESC/O |

## Essential Configuration

```javascript
Reveal.initialize({
  slideNumber: 'c/t',
  hash: true,
  width: '100%',
  height: '100%',
  transition: 'slide',
  controls: true,
  progress: true,
  keyboard: true,
  overview: true,
  plugins: [ RevealMarkdown, RevealHighlight, RevealNotes ]
});
```

## Workflow

**STEP 0:** Pre-flight check (above) - refactor if needed

1. Set up Tailwind if not present
2. Plan structure: horizontal (main) vs vertical (detail)
3. Content on slides: high-level only
4. Add formatted speaker notes to ALL slides
5. Detail in notes, not on slides
6. Add effects LAST (only where they serve purpose)
7. Verify visually: All content visible/legible, styling correct, dimensions appropriate

## Common Rationalizations (STOP)

| If you think... | Reality |
|----------------|---------|
| "Maintain visual consistency" with inline styles | STOP. Refactor to Tailwind |
| "Avoid introducing complexity" | STOP. Bad code IS complex |
| "Original didn't use Tailwind" | STOP. Refactor anyway |
| "This transition draws attention" | STOP. Define actual communication goal |
| "Slide structure guides narrative" | STOP. Add speaker notes anyway |
| "User asked for it quickly" | STOP. Refactoring is faster than tech debt |

## Accessibility Checklist

- [ ] Semantic HTML (heading hierarchy)
- [ ] Keyboard navigation (Tab, arrows, ESC)
- [ ] Speaker notes provide context
- [ ] Color contrast sufficient
- [ ] No information by color alone
- [ ] Alt text for images
