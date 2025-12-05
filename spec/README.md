# Property-Based Testing Suite

This directory contains property-based tests for the professional website redesign.

## Setup

Install the required gems:

```bash
bundle install
```

## Running Tests

Run all tests:

```bash
bundle exec rspec
```

Run a specific test file:

```bash
bundle exec rspec spec/navigation_consistency_spec.rb
```

## Test Structure

### Content Validation and Testing

**File**: `spec/content_validation_spec.rb`

**Purpose**: Validates that all key content requirements are met across the website, ensuring the professional website redesign specifications are properly implemented.

**Validates**: Requirements 1.1, 1.2, 1.3, 4.1, 5.2, 7.1, 7.4

The test verifies:

**Homepage Content:**
- Professional tagline: "AI Consultant · Cloud Architect · Applied Researcher · Writer"
- Geographic subtitle: "From Mozambique to Mexico and globally"
- Primary CTA button linking to Work With Me
- Secondary CTA button linking to Contact
- "What I Do" section with four key areas (AI Strategy & Advisory, Cloud & Software Engineering, Enterprise Automation, Training & Upskilling)

**Work With Me Page:**
- All six service categories are listed (AI Strategy & Advisory, LLM & ML Systems, Cloud Architecture, Product Execution, Technical Leadership, Training & Upskilling)
- Detailed service descriptions for each category
- "Who I Work With" section
- "Approach" section with Strategy → Architecture → Delivery
- CTA linking to Contact page

**Contact Page:**
- Email contact information (gafar_meque@hotmail.com)
- LinkedIn link
- No contact forms (direct contact methods only)
- WhatsApp with click-to-reveal functionality
- Response time expectation statement

**About Page:**
- Link to My Story page
- Professional summary (Executive Summary)
- Journey section mentioning Mozambique and Mexico
- Current Focus section

**Writing Page:**
- Hero section with tagline about writing
- Three sub-sections: Essays, Medium, LinkedIn
- Navigation for the three sections

**Academic CV Page:**
- PDF download link
- Education section
- Research Experience section
- Publications section
- Teaching Experience section
- Technical Skills section

**Navigation Links:**
- All navigation links work (no 404s)
- Navigation contains all required items in correct order

**External Links:**
- External links open in new tabs (target="_blank")
- Internal links do not have target="_blank" (except PDFs)

### Academic Journey Path Verification

**File**: `spec/academic_journey_spec.rb`

**Purpose**: Verifies that the academic journey path (Publications → Academic CV → About) is properly implemented and accessible.

**Validates**: Requirements 10.2

The test verifies:
1. All academic journey pages exist (Publications, Academic CV, About)
2. Publications page contains categorized sections (Peer-Reviewed Papers, Workshop Publications, Datasets, Thesis)
3. Academic CV page has PDF download button and key sections (Education, Research Experience, Publications, Teaching Experience, Technical Skills)
4. About page links to My Story and contains professional summary
5. Navigation menu is present and functional on all academic pages

### Navigation Consistency Test

**File**: `spec/navigation_consistency_spec.rb`

**Property**: For any page on the website, the navigation menu should contain exactly these items in order:
- Home
- About
- Work With Me
- Work & Projects
- Publications
- Writing
- Academic CV
- My Story
- Contact

**Validates**: Requirements 6.1

**Iterations**: 100 (as specified in the design document)

The test:
1. Verifies the `_data/navigation.yml` file contains the expected navigation structure
2. Runs a property-based test across 100 random pages from the built site
3. Ensures each page has consistent navigation with the correct titles and URLs in the correct order

### Build Stability Test

**File**: `spec/build_stability_spec.rb`

**Property**: For any valid configuration change in _config.yml, the Jekyll build should complete successfully without errors and all existing pages should remain accessible.

**Validates**: Requirements 9.2

**Iterations**: 100 (as specified in the design document)

The test:
1. Captures the initial state of all existing pages
2. Runs a property-based test with 100 random valid configuration changes including:
   - Site title and subtitle
   - Site description
   - Author name, bio, and location
   - Locale and timezone settings
   - Words per minute setting
3. For each change, verifies:
   - Jekyll build completes successfully
   - All previously existing pages remain accessible
4. Automatically restores the original configuration after each test
5. Includes unit tests for specific configuration changes
6. Tests edge cases like empty values and multiple sequential changes

## Prerequisites

The Jekyll site must be built before running tests:

```bash
bundle exec jekyll build
```

The tests will automatically check for the `_site` directory and prompt to build if needed.
