# UI Design Prompts - SCPO Vibecoding

## 🎨 Design System & Interface

### SCPO_UI_DESIGN_SYSTEM

```
ROLE: Expert UI Designer
TASK: Create design system for [APP_TYPE]
CONSTRAINTS: Mobile-first, accessibility compliant, brand consistent

DESIGN_SYSTEM:
## Color Palette
### Primary Colors
- Primary: #[HEX] - Main brand color for CTAs
- Primary-light: #[HEX] - Hover states
- Primary-dark: #[HEX] - Active states

### Secondary Colors
- Secondary: #[HEX] - Supporting elements
- Accent: #[HEX] - Highlights and notifications
- Neutral: #[HEX] range (50-900) - Text and backgrounds

### Semantic Colors
- Success: #[HEX] - Positive actions
- Warning: #[HEX] - Caution states
- Error: #[HEX] - Error states
- Info: #[HEX] - Informational

## Typography Scale
- Heading 1: [size/weight] - Page titles
- Heading 2: [size/weight] - Section headers
- Heading 3: [size/weight] - Subsections
- Body: [size/weight] - Main text
- Small: [size/weight] - Captions, labels

ACCESSIBILITY: WCAG AA contrast ratios (4.5:1 minimum)
```

### SCPO_COMPONENT_LIBRARY

```
ROLE: Frontend Design Lead
TASK: Define component library for [PRODUCT_TYPE]
CONSTRAINTS: Reusable, consistent, performant

COMPONENT_SPECS:
## Button System
### Primary Button
- States: Default, Hover, Active, Disabled, Loading
- Sizes: Small (32px), Medium (40px), Large (48px)
- Variants: Solid, Outline, Ghost

### Secondary Button
- Visual hierarchy: Less prominent than primary
- Use cases: Cancel, secondary actions

## Form Controls
### Input Field
- States: Default, Focus, Error, Disabled
- Types: Text, Email, Password, Number
- Validation: Inline error messaging

### Select/Dropdown
- Multi-select capability
- Search/filter functionality
- Custom styling approach

## Navigation
### Primary Navigation
- Desktop: Horizontal bar
- Mobile: Collapsible hamburger menu
- Active state indicators

SPACING_TOKENS: 4px base unit system (4, 8, 12, 16, 24, 32, 48, 64px)
```

### SCPO_RESPONSIVE_LAYOUT

```
ROLE: UX/UI Designer
TASK: Design responsive layout system for [INTERFACE_TYPE]
CONSTRAINTS: Mobile-first approach, progressive enhancement

BREAKPOINT_SYSTEM:
## Screen Sizes
- Mobile: 320px - 767px
- Tablet: 768px - 1023px
- Desktop: 1024px - 1439px
- Large: 1440px+

## Layout Patterns
### Mobile (320-767px)
- Single column stack
- Touch-friendly targets (44px minimum)
- Simplified navigation

### Tablet (768-1023px)
- Two-column layouts where appropriate
- Larger touch targets maintained
- Side navigation consideration

### Desktop (1024px+)
- Multi-column layouts
- Hover states and interactions
- Advanced navigation patterns

GRID_SYSTEM: 12-column CSS Grid with flexible gaps
CONTAINER_MAX_WIDTH: 1200px with responsive padding
```

### SCPO_DARK_MODE_SYSTEM

```
ROLE: UI Designer
TASK: Implement dark mode for [APPLICATION]
CONSTRAINTS: Seamless switching, accessibility maintained, brand consistency

DARK_MODE_PALETTE:
## Background Colors
- bg-primary: #[HEX] - Main background
- bg-secondary: #[HEX] - Card backgrounds
- bg-tertiary: #[HEX] - Subtle sections

## Text Colors
- text-primary: #[HEX] - Main content (contrast 7:1)
- text-secondary: #[HEX] - Supporting text (contrast 4.5:1)
- text-muted: #[HEX] - Disabled/placeholder text

## Interactive Elements
- Brand colors: Adjust saturation for dark backgrounds
- Borders: Subtle, low contrast
- Shadows: Darker, more pronounced

## Toggle Implementation
- System preference detection
- Manual override option
- Persistence across sessions
- Smooth transition animations (200ms)

ACCESSIBILITY: Maintain contrast ratios, test with screen readers
```

## 🎯 User Experience Design

### SCPO_USER_FLOW_DESIGN

```
ROLE: UX Designer
TASK: Map user flow for [FEATURE/PROCESS]
CONSTRAINTS: Minimal friction, clear progress indicators, error handling

USER_FLOW_MAP:
## Entry Points
1. [How users discover/access this flow]
2. [Alternative entry methods]

## Core Steps
### Step 1: [ACTION_NAME]
- User Intent: [what they want to achieve]
- Interface: [screens/components involved]
- Success Criteria: [how we know they succeeded]
- Error Cases: [what can go wrong + handling]

### Step 2: [ACTION_NAME]
- [Same structure as Step 1]

## Exit Points
- Success: [where users end up after completion]
- Abandonment: [graceful exit options]
- Error Recovery: [how to get back on track]

OPTIMIZATION: Reduce steps, clarify actions, provide feedback
ANALYTICS: Key conversion points to measure
```

### SCPO_ONBOARDING_UX

```
ROLE: Product Designer
TASK: Design onboarding experience for [USER_TYPE]
CONSTRAINTS: Quick value demonstration, progressive disclosure, optional depth

ONBOARDING_FLOW:
## Welcome & Value Prop (Screen 1)
- Hero message: [core value in one sentence]
- Key benefits: [3 main user gains]
- Social proof: [testimonials/logos if available]

## Account Setup (Screen 2-3)
- Minimal required info
- Clear privacy/data usage
- Option to import from [relevant sources]

## First Success (Screen 4-5)
- Guided first action
- Immediate value demonstration
- Celebration of completion

## Optional Deep Dive
- Advanced features tour
- Customization options
- Skip-friendly design

SUCCESS_METRICS: Time to first value, completion rate, user activation
```

### SCPO_ACCESSIBILITY_AUDIT

```
ROLE: Accessibility Specialist
TASK: Ensure [INTERFACE] meets WCAG 2.1 AA standards
CONSTRAINTS: Screen reader compatible, keyboard navigable, inclusive design

ACCESSIBILITY_CHECKLIST:
## Visual Design
- Color contrast: 4.5:1 for normal text, 3:1 for large text
- Color independence: No information conveyed by color alone
- Focus indicators: Visible for all interactive elements
- Text scaling: Readable up to 200% zoom

## Interaction Design
- Keyboard navigation: Tab order logical and complete
- Skip links: Main content and navigation bypasses
- Error messaging: Clear, specific, actionable
- Timeout handling: Warnings and extensions available

## Screen Reader Support
- Alt text: Descriptive for images, empty for decorative
- ARIA labels: Form fields, buttons, complex widgets
- Heading structure: Logical H1-H6 hierarchy
- Landmarks: Main, nav, aside, footer regions

## Testing Strategy
- Automated: axe-core, WAVE, Lighthouse
- Manual: Screen reader testing, keyboard-only navigation
- User testing: Include users with disabilities

REMEDIATION: Priority fixes based on impact and effort
```

## 📱 Mobile & Responsive Design

### SCPO_MOBILE_FIRST_DESIGN

```
ROLE: Mobile UX Designer
TASK: Optimize [INTERFACE] for mobile experience
CONSTRAINTS: Touch-friendly, fast loading, thumb-navigable

MOBILE_OPTIMIZATION:
## Touch Interface
- Target size: 44px minimum (iOS), 48dp (Android)
- Spacing: 8px minimum between targets
- Gesture support: Swipe, pinch, long-press where appropriate
- Thumb zones: Place primary actions in easy reach

## Content Strategy
- Progressive disclosure: Show essentials first
- Scannable hierarchy: Clear headings and structure
- Minimal text input: Use selections and toggles
- Image optimization: WebP format, lazy loading

## Performance
- Loading states: Skeleton screens, progress indicators
- Offline functionality: Cache critical content
- Bundle size: Code splitting, tree shaking
- Network awareness: Adapt to connection quality

## Navigation Patterns
- Bottom tab bar: Primary navigation
- Hamburger menu: Secondary navigation
- Back button: Clear escape routes
- Search: Prominent and fast

TESTING: Device variety, different screen sizes, slow connections
```

### SCPO_INTERACTION_DESIGN

```
ROLE: Interaction Designer
TASK: Define micro-interactions for [UI_COMPONENT]
CONSTRAINTS: Purposeful animations, performance conscious, accessibility friendly

INTERACTION_PATTERNS:
## Button Interactions
- Hover: Subtle color shift (100ms ease)
- Press: Scale down 2% + darker shade
- Loading: Spinner or progress indicator
- Success: Brief checkmark animation

## Form Interactions
- Focus: Border color change + subtle glow
- Validation: Real-time with 500ms debounce
- Error: Shake animation (200ms) + red border
- Success: Green checkmark fade-in

## Navigation Transitions
- Page changes: Slide transition (300ms ease-out)
- Modal entry: Scale + fade (250ms)
- Dropdown: Slide down (200ms ease)

## Feedback Systems
- Toast notifications: Slide in from top
- Loading states: Skeleton animation
- Empty states: Gentle illustrations + helpful text

PERFORMANCE: Use transform/opacity for 60fps animations
ACCESSIBILITY: Respect prefers-reduced-motion setting
```

## 🎨 Visual Design & Branding

### SCPO_BRAND_IDENTITY

```
ROLE: Brand Designer
TASK: Develop visual identity for [PRODUCT_NAME]
CONSTRAINTS: Memorable, scalable, industry-appropriate

BRAND_ELEMENTS:
## Logo Design
- Primary mark: [description + rationale]
- Icon version: For small spaces, favicons
- Wordmark: Typography-based variant
- Usage guidelines: Minimum sizes, clear space

## Color Psychology
- Primary color: [HEX] - [emotional association]
- Supporting palette: [2-3 colors] - [usage rationale]
- Industry context: How colors differentiate from competitors

## Typography Personality
- Headings: [font choice] - [personality traits]
- Body: [font choice] - [readability focus]
- Pairing rationale: [why these work together]

## Visual Style
- Photography style: [mood, lighting, subjects]
- Illustration approach: [style, complexity, color usage]
- Icon style: [filled/outlined, corner radius, weight]

APPLICATIONS: Business cards, website headers, social media
```

### SCPO_LAYOUT_COMPOSITION

```
ROLE: Visual Designer
TASK: Create layout compositions for [PAGE_TYPE]
CONSTRAINTS: Visual hierarchy, content flow, brand consistency

LAYOUT_STRUCTURE:
## Grid System
- Columns: 12-column flexible grid
- Gutters: 24px desktop, 16px mobile
- Margins: 5% of viewport width
- Vertical rhythm: 24px baseline grid

## Visual Hierarchy
### Primary Level
- Hero sections: Large typography, high contrast
- Main CTAs: Prominent button treatment

### Secondary Level
- Section headers: Medium typography, brand color
- Supporting CTAs: Outlined button style

### Tertiary Level
- Body content: Readable typography, good spacing
- Captions: Smaller, muted color treatment

## Content Flow
- F-pattern consideration: Important content top-left
- Z-pattern for landing pages: Logo → CTA → benefits → action
- Whitespace usage: Breathing room around key elements

COMPOSITION: Balance, contrast, repetition, proximity principles
```

---

_These UI design prompts optimize for comprehensive yet efficient design decisions. Each follows SCPO token economy while generating detailed, actionable design specifications ready for implementation._
