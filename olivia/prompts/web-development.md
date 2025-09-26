# Web Development Prompts - SCPO Vibecoding

## 🌐 Frontend Development

### SCPO_HTML_CSS_STARTER

````
ROLE: Frontend Developer
TASK: Generate clean, responsive HTML + CSS starter with no dependencies
CONSTRAINTS: Mobile-first, minimal design, semantic HTML, modern CSS

HTML_CSS_STRUCTURE:
## HTML Foundation
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>[PROJECT_NAME]</title>
    <meta name="description" content="[SEO_DESCRIPTION]">
    <link rel="stylesheet" href="styles.css">
    <link rel="icon" href="favicon.ico" type="image/x-icon">
</head>
<body>
    <header class="header">
        <nav class="nav">
            <div class="nav__brand">
                <h1>[BRAND_NAME]</h1>
            </div>
            <ul class="nav__links">
                <li><a href="#home" class="nav__link">Home</a></li>
                <li><a href="#about" class="nav__link">About</a></li>
                <li><a href="#contact" class="nav__link">Contact</a></li>
            </ul>
        </nav>
    </header>

    <main class="main">
        <!-- Homepage Section -->
        <section id="home" class="hero">
            <div class="container">
                <h2 class="hero__title">[HERO_TITLE]</h2>
                <p class="hero__subtitle">[HERO_DESCRIPTION]</p>
                <a href="#contact" class="btn btn--primary">Get Started</a>
            </div>
        </section>

        <!-- About Section -->
        <section id="about" class="about">
            <div class="container">
                <h2 class="section__title">About Us</h2>
                <div class="about__content">
                    <p>[ABOUT_CONTENT]</p>
                </div>
            </div>
        </section>

        <!-- Contact Section -->
        <section id="contact" class="contact">
            <div class="container">
                <h2 class="section__title">Contact</h2>
                <form class="contact__form" action="#" method="POST">
                    <div class="form__group">
                        <label for="name" class="form__label">Name</label>
                        <input type="text" id="name" name="name" class="form__input" required>
                    </div>

                    <div class="form__group">
                        <label for="email" class="form__label">Email</label>
                        <input type="email" id="email" name="email" class="form__input" required>
                    </div>

                    <div class="form__group">
                        <label for="message" class="form__label">Message</label>
                        <textarea id="message" name="message" class="form__textarea" rows="5" required></textarea>
                    </div>

                    <button type="submit" class="btn btn--primary btn--full">Send Message</button>
                </form>
            </div>
        </section>
    </main>

    <footer class="footer">
        <div class="container">
            <p>&copy; 2024 [BRAND_NAME]. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
````

## CSS Foundation (Mobile-First)

```css
/* Reset and Base Styles */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

:root {
  /* Color Palette */
  --primary-color: #2563eb;
  --primary-dark: #1d4ed8;
  --secondary-color: #64748b;
  --accent-color: #06b6d4;
  --text-primary: #1f2937;
  --text-secondary: #6b7280;
  --background: #ffffff;
  --surface: #f9fafb;
  --border: #e5e7eb;

  /* Typography */
  --font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
    sans-serif;
  --font-size-sm: 0.875rem;
  --font-size-base: 1rem;
  --font-size-lg: 1.125rem;
  --font-size-xl: 1.25rem;
  --font-size-2xl: 1.5rem;
  --font-size-3xl: 2rem;

  /* Spacing */
  --spacing-xs: 0.5rem;
  --spacing-sm: 0.75rem;
  --spacing-md: 1rem;
  --spacing-lg: 1.5rem;
  --spacing-xl: 2rem;
  --spacing-2xl: 3rem;

  /* Layout */
  --container-width: 1200px;
  --border-radius: 0.5rem;
  --shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

body {
  font-family: var(--font-family);
  font-size: var(--font-size-base);
  line-height: 1.6;
  color: var(--text-primary);
  background-color: var(--background);
}

/* Layout Components */
.container {
  max-width: var(--container-width);
  margin: 0 auto;
  padding: 0 var(--spacing-md);
}

/* Header & Navigation */
.header {
  background: var(--background);
  box-shadow: var(--shadow);
  position: fixed;
  top: 0;
  width: 100%;
  z-index: 100;
}

.nav {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: var(--spacing-md) 0;
}

.nav__brand h1 {
  color: var(--primary-color);
  font-size: var(--font-size-xl);
}

.nav__links {
  display: none;
  list-style: none;
  gap: var(--spacing-lg);
}

.nav__link {
  text-decoration: none;
  color: var(--text-primary);
  font-weight: 500;
  transition: color 0.2s ease;
}

.nav__link:hover {
  color: var(--primary-color);
}

/* Main Content */
.main {
  margin-top: 80px; /* Account for fixed header */
}

/* Hero Section */
.hero {
  background: linear-gradient(
    135deg,
    var(--primary-color),
    var(--accent-color)
  );
  color: white;
  text-align: center;
  padding: var(--spacing-2xl) 0;
}

.hero__title {
  font-size: var(--font-size-3xl);
  font-weight: 700;
  margin-bottom: var(--spacing-md);
}

.hero__subtitle {
  font-size: var(--font-size-lg);
  margin-bottom: var(--spacing-xl);
  opacity: 0.9;
}

/* Sections */
.about,
.contact {
  padding: var(--spacing-2xl) 0;
}

.about {
  background: var(--surface);
}

.section__title {
  font-size: var(--font-size-2xl);
  font-weight: 600;
  text-align: center;
  margin-bottom: var(--spacing-xl);
  color: var(--text-primary);
}

/* Form Styles */
.contact__form {
  max-width: 600px;
  margin: 0 auto;
}

.form__group {
  margin-bottom: var(--spacing-lg);
}

.form__label {
  display: block;
  margin-bottom: var(--spacing-xs);
  font-weight: 500;
  color: var(--text-primary);
}

.form__input,
.form__textarea {
  width: 100%;
  padding: var(--spacing-sm);
  border: 1px solid var(--border);
  border-radius: var(--border-radius);
  font-size: var(--font-size-base);
  transition: border-color 0.2s ease, box-shadow 0.2s ease;
}

.form__input:focus,
.form__textarea:focus {
  outline: none;
  border-color: var(--primary-color);
  box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
}

/* Button Styles */
.btn {
  display: inline-block;
  padding: var(--spacing-sm) var(--spacing-lg);
  text-decoration: none;
  border-radius: var(--border-radius);
  font-weight: 500;
  text-align: center;
  cursor: pointer;
  border: none;
  transition: all 0.2s ease;
}

.btn--primary {
  background-color: var(--primary-color);
  color: white;
}

.btn--primary:hover {
  background-color: var(--primary-dark);
  transform: translateY(-1px);
}

.btn--full {
  width: 100%;
}

/* Footer */
.footer {
  background: var(--text-primary);
  color: white;
  text-align: center;
  padding: var(--spacing-xl) 0;
}

/* Responsive Design */
@media (min-width: 768px) {
  .nav__links {
    display: flex;
  }

  .hero__title {
    font-size: 3.5rem;
  }

  .container {
    padding: 0 var(--spacing-xl);
  }
}

@media (min-width: 1024px) {
  .hero {
    padding: 5rem 0;
  }

  .about,
  .contact {
    padding: 4rem 0;
  }
}

/* Utility Classes */
.sr-only {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border: 0;
}

.text-center {
  text-align: center;
}

.hidden {
  display: none;
}

@media (prefers-reduced-motion: reduce) {
  * {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
  }
}
```

**ACCESSIBILITY:** WCAG AA compliant, keyboard navigable, screen reader friendly
**PERFORMANCE:** Optimized CSS, minimal HTTP requests, fast loading
**SEO:** Semantic HTML, proper meta tags, structured content

```

### SCPO_RESPONSIVE_COMPONENTS
```

ROLE: UI Component Developer
TASK: Create responsive component library for [PROJECT_TYPE]
CONSTRAINTS: CSS Grid/Flexbox, no frameworks, reusable patterns

COMPONENT_LIBRARY:

## Card Component

```css
.card {
  background: var(--background);
  border-radius: var(--border-radius);
  box-shadow: var(--shadow);
  padding: var(--spacing-lg);
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.card:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.card__header {
  margin-bottom: var(--spacing-md);
}

.card__title {
  font-size: var(--font-size-xl);
  font-weight: 600;
  color: var(--text-primary);
}

.card__subtitle {
  color: var(--text-secondary);
  font-size: var(--font-size-sm);
}

.card__content {
  margin-bottom: var(--spacing-md);
}

.card__footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
```

```html
<div class="card">
  <div class="card__header">
    <h3 class="card__title">Card Title</h3>
    <p class="card__subtitle">Card subtitle</p>
  </div>
  <div class="card__content">
    <p>Card content goes here...</p>
  </div>
  <div class="card__footer">
    <span class="card__meta">Date: 2024-01-01</span>
    <button class="btn btn--secondary">Action</button>
  </div>
</div>
```

## Grid System

```css
.grid {
  display: grid;
  gap: var(--spacing-lg);
  grid-template-columns: 1fr;
}

.grid--2-cols {
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
}

.grid--3-cols {
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
}

.grid--4-cols {
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
}

/* Responsive grid adjustments */
@media (min-width: 768px) {
  .grid--2-cols {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (min-width: 1024px) {
  .grid--3-cols {
    grid-template-columns: repeat(3, 1fr);
  }

  .grid--4-cols {
    grid-template-columns: repeat(4, 1fr);
  }
}
```

## Modal Component

```css
.modal {
  display: none;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.5);
  z-index: 1000;
  animation: fadeIn 0.3s ease;
}

.modal.is-active {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: var(--spacing-md);
}

.modal__content {
  background: var(--background);
  border-radius: var(--border-radius);
  padding: var(--spacing-xl);
  max-width: 500px;
  width: 100%;
  max-height: 90vh;
  overflow-y: auto;
  animation: slideUp 0.3s ease;
}

@keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

@keyframes slideUp {
  from {
    transform: translateY(20px);
    opacity: 0;
  }
  to {
    transform: translateY(0);
    opacity: 1;
  }
}
```

```html
<div class="modal" id="example-modal">
  <div class="modal__content">
    <h2>Modal Title</h2>
    <p>Modal content...</p>
    <div class="modal__actions">
      <button class="btn btn--secondary" onclick="closeModal()">Cancel</button>
      <button class="btn btn--primary">Confirm</button>
    </div>
  </div>
</div>
```

```javascript
function openModal(modalId) {
  document.getElementById(modalId).classList.add("is-active");
  document.body.style.overflow = "hidden";
}

function closeModal(modalId) {
  document.getElementById(modalId).classList.remove("is-active");
  document.body.style.overflow = "auto";
}
```

**USAGE:** Copy components and customize CSS variables for brand consistency
**ACCESSIBILITY:** Focus management, ARIA labels, keyboard navigation included

```

## 🔧 Interactive Features

### SCPO_VANILLA_JS_FEATURES
```

ROLE: Frontend Developer (Vanilla JS)
TASK: Add interactive features without framework dependencies
CONSTRAINTS: Modern JS (ES6+), progressive enhancement, performance optimized

INTERACTIVE_FEATURES:

## Form Validation

```javascript
class FormValidator {
  constructor(formElement) {
    this.form = formElement;
    this.errors = {};
    this.init();
  }

  init() {
    this.form.addEventListener("submit", (e) => this.handleSubmit(e));
    this.form.addEventListener("input", (e) => this.handleInput(e));
  }

  handleSubmit(e) {
    e.preventDefault();

    if (this.validateForm()) {
      this.submitForm();
    } else {
      this.displayErrors();
    }
  }

  handleInput(e) {
    const field = e.target;
    this.clearFieldError(field);
    this.validateField(field);
  }

  validateField(field) {
    const rules = field.dataset.rules?.split("|") || [];

    rules.forEach((rule) => {
      const [ruleName, ruleValue] = rule.split(":");

      switch (ruleName) {
        case "required":
          if (!field.value.trim()) {
            this.addError(field.name, "This field is required");
          }
          break;

        case "email":
          const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
          if (field.value && !emailRegex.test(field.value)) {
            this.addError(field.name, "Please enter a valid email");
          }
          break;

        case "min":
          if (field.value.length < parseInt(ruleValue)) {
            this.addError(
              field.name,
              `Minimum ${ruleValue} characters required`
            );
          }
          break;
      }
    });
  }

  addError(fieldName, message) {
    if (!this.errors[fieldName]) {
      this.errors[fieldName] = [];
    }
    this.errors[fieldName].push(message);
  }

  clearFieldError(field) {
    delete this.errors[field.name];
    const errorElement = field.parentElement.querySelector(".field-error");
    if (errorElement) {
      errorElement.remove();
    }
    field.classList.remove("error");
  }

  displayErrors() {
    Object.keys(this.errors).forEach((fieldName) => {
      const field = this.form.querySelector(`[name="${fieldName}"]`);
      const errorMessage = this.errors[fieldName][0];

      field.classList.add("error");

      const errorElement = document.createElement("div");
      errorElement.className = "field-error";
      errorElement.textContent = errorMessage;

      field.parentElement.appendChild(errorElement);
    });
  }

  validateForm() {
    this.errors = {};
    const fields = this.form.querySelectorAll("[data-rules]");
    fields.forEach((field) => this.validateField(field));
    return Object.keys(this.errors).length === 0;
  }

  async submitForm() {
    const formData = new FormData(this.form);

    try {
      const response = await fetch(this.form.action, {
        method: "POST",
        body: formData,
      });

      if (response.ok) {
        this.showSuccess("Form submitted successfully!");
        this.form.reset();
      } else {
        this.showError("Submission failed. Please try again.");
      }
    } catch (error) {
      this.showError("Network error. Please try again.");
    }
  }

  showSuccess(message) {
    this.showNotification(message, "success");
  }

  showError(message) {
    this.showNotification(message, "error");
  }

  showNotification(message, type) {
    const notification = document.createElement("div");
    notification.className = `notification notification--${type}`;
    notification.textContent = message;

    document.body.appendChild(notification);

    setTimeout(() => {
      notification.classList.add("notification--show");
    }, 10);

    setTimeout(() => {
      notification.classList.remove("notification--show");
      setTimeout(() => notification.remove(), 300);
    }, 3000);
  }
}

// Initialize form validation
document.addEventListener("DOMContentLoaded", () => {
  const forms = document.querySelectorAll("[data-validate]");
  forms.forEach((form) => new FormValidator(form));
});
```

## Smooth Scrolling Navigation

```javascript
class SmoothScroller {
  constructor() {
    this.init();
  }

  init() {
    // Smooth scroll for anchor links
    document.querySelectorAll('a[href^="#"]').forEach((link) => {
      link.addEventListener("click", (e) => {
        e.preventDefault();
        const targetId = link.getAttribute("href").substring(1);
        const target = document.getElementById(targetId);

        if (target) {
          this.scrollToElement(target);
        }
      });
    });

    // Update active navigation on scroll
    window.addEventListener("scroll", () => this.updateActiveNav());
  }

  scrollToElement(element) {
    const headerOffset = 80; // Account for fixed header
    const elementPosition = element.getBoundingClientRect().top;
    const offsetPosition = elementPosition + window.pageYOffset - headerOffset;

    window.scrollTo({
      top: offsetPosition,
      behavior: "smooth",
    });
  }

  updateActiveNav() {
    const sections = document.querySelectorAll("section[id]");
    const navLinks = document.querySelectorAll(".nav__link");

    let currentSection = "";

    sections.forEach((section) => {
      const sectionTop = section.getBoundingClientRect().top;
      if (sectionTop <= 100) {
        currentSection = section.getAttribute("id");
      }
    });

    navLinks.forEach((link) => {
      link.classList.remove("nav__link--active");
      if (link.getAttribute("href") === `#${currentSection}`) {
        link.classList.add("nav__link--active");
      }
    });
  }
}

new SmoothScroller();
```

## Loading States & Lazy Loading

```javascript
class LazyLoader {
  constructor() {
    this.imageObserver = null;
    this.init();
  }

  init() {
    if ("IntersectionObserver" in window) {
      this.imageObserver = new IntersectionObserver((entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            this.loadImage(entry.target);
            this.imageObserver.unobserve(entry.target);
          }
        });
      });

      document.querySelectorAll("img[data-src]").forEach((img) => {
        this.imageObserver.observe(img);
      });
    }
  }

  loadImage(img) {
    img.src = img.dataset.src;
    img.classList.add("loaded");

    img.addEventListener("load", () => {
      img.classList.add("fade-in");
    });
  }
}

// Loading spinner utility
function showLoading(element) {
  element.classList.add("loading");
  element.setAttribute("aria-busy", "true");
}

function hideLoading(element) {
  element.classList.remove("loading");
  element.setAttribute("aria-busy", "false");
}

new LazyLoader();
```

**PERFORMANCE:** Optimized for 60fps animations, minimal DOM manipulation
**ACCESSIBILITY:** ARIA attributes, keyboard navigation, screen reader support
**BROWSER_SUPPORT:** Modern browsers (ES6+), graceful degradation for older browsers

```

---

*These web development prompts provide complete, production-ready solutions following SCPO token efficiency principles while maintaining modern web standards and best practices.*
```
