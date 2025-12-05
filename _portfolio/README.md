# Portfolio Collection - Work & Projects

This directory contains portfolio items that showcase professional work and case studies.

## Structure

Portfolio items are displayed at `/work-projects/` on the website.

## Creating a New Project

1. Copy `_TEMPLATE.md` to create a new project file
2. Name the file with format: `YYYY-project-name.md` (e.g., `2024-ai-telecom-bots.md`)
3. Fill in the required front matter fields
4. Use the `project` layout for case study format

## Front Matter Fields

### Required Fields

- **title**: Project name (displayed as page title)
- **excerpt**: Brief one-line description (used in grid view and meta descriptions)
- **collection**: Must be `portfolio`
- **layout**: Use `project` for case study format with Challenge/Solution/Outcome sections

### Case Study Fields (for `project` layout)

- **challenge**: Problem statement or business challenge (supports markdown)
- **solution**: Approach, architecture, and technologies used (supports markdown)
- **outcome**: Measurable results and impact (supports markdown)
- **technologies**: Array of technology names (displayed as tags)

### Optional Fields

- **header.teaser**: Thumbnail image path for grid display (e.g., `/images/project-thumb.jpg`)
- **header.image**: Full-width header image
- **header.overlay_color**: Background color for header
- **header.overlay_filter**: Opacity filter for header image
- **published**: Set to `false` to hide from site (default: `true`)
- **date**: Publication date (format: YYYY-MM-DD)

## Example

```yaml
---
title: "AI Telecom Bots"
excerpt: "Intelligent customer service automation using AWS Lex, Bedrock, and Connect"
collection: portfolio
layout: project

header:
  teaser: /images/ai-telecom-thumb.jpg

challenge: |
  A major telecommunications provider needed to modernize their customer service...

solution: |
  Designed and implemented a multi-bot conversational AI system using AWS services...

outcome: |
  - 65% reduction in average call handling time
  - 40% decrease in operational costs

technologies:
  - AWS Lex
  - Amazon Bedrock
  - Python

published: true
date: 2024-09-15
---

## Additional Content

Any markdown content here appears after the structured sections.
```

## Layouts

### `project` Layout

The `project` layout extends `single` and provides structured sections for:
- Challenge (problem statement)
- Solution (approach and implementation)
- Outcome (results and impact)
- Technologies (displayed as styled tags)

Any content in the markdown body appears after these structured sections.

### `single` Layout

For projects that don't fit the case study format, use the standard `single` layout.

## Styling

Project-specific styles are defined in `_sass/custom.scss`:
- Section headings with brand accent color
- Technology tags with styled badges
- Responsive layout for mobile devices

## Configuration

Portfolio collection is configured in `_config.yml`:

```yaml
collections:
  portfolio:
    output: true
    permalink: "/work-projects/:path/"

defaults:
  - scope:
      path: ""
      type: portfolio
    values:
      layout: single
      author_profile: true
      share: true
```

## Display Pages

- **Grid View**: `/work-projects/` - Shows all projects in a grid with thumbnails
- **Individual Pages**: `/work-projects/project-name/` - Full case study view
