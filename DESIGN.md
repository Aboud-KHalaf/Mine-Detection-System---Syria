# Design System Documentation: The Tactical Sentinel

## 1. Overview & Creative North Star
The Creative North Star for this design system is **"The Tactical Sentinel."** 

In the high-stakes environment of mine detection in Syria, the UI must transcend traditional "dashboard" aesthetics. It must function as a precision instrument—authoritative, life-saving, and devoid of visual noise. We reject the "template" look of standard enterprise software in favor of a **High-End Editorial Technical** style. 

This is achieved through:
*   **Intentional Asymmetry:** Important telemetry data is weighted heavily, using negative space to isolate critical "Danger" metrics.
*   **Tonal Depth:** We do not use lines to separate ideas. We use layers of darkness to define hierarchy.
*   **Vibrant Utility:** Color is never decorative. It is a biological signal.

The goal is a "Zero-Latency Cognition" experience where a technician in high-glare sunlight can discern safety from a lethal threat in a fraction of a second.

---

## 2. Colors
Our palette is rooted in a near-black abyss to maximize the luminosity of mission-critical indicators.

### The Palette
*   **Primary (Danger):** `primary` (#ff8e84) and `error` (#ff6e84). These are high-vibrancy reds designed to pierce through the dark background.
*   **Secondary (Safety):** `secondary` (#9df898). A cool, mint-leaning green that signifies a "Clear" status without blending into environmental foliage.
*   **Tertiary (Alert):** `tertiary` (#ffb150). An amber-gold used for "Unknown" or "Anomalous" readings.
*   **Surface:** `surface` (#0e0e0e). The foundation.

### Core Rules for Color Application
1.  **The "No-Line" Rule:** 1px solid borders are strictly prohibited for sectioning. To separate the map view from the telemetry sidebar, use a background shift from `surface` to `surface-container-low`. Boundaries are felt through tonal transitions, not drawn with lines.
2.  **Surface Hierarchy & Nesting:** Use the tiers (`surface-container-lowest` to `highest`) to create physical depth. A "Mine Profile" card should be `surface-container-high` sitting atop a `surface-container-low` panel. This creates a "stacked sheet" effect.
3.  **The "Glass & Gradient" Rule:** For floating HUD elements (like a compass or rangefinder), use `surface-variant` with a 60% opacity and a `backdrop-blur` of 12px. Apply a subtle linear gradient from `primary` to `primary-container` on high-priority buttons to give them a "machined" feel.

---

## 3. Typography
We utilize a dual-language typographic system designed for maximum legibility in high-stress scenarios.

*   **English:** **Inter**. Chosen for its tall x-height and technical "neo-grotesque" clarity.
*   **Arabic:** **Cairo**. Specifically selected for its geometric harmony with Inter, ensuring that bilingual alerts (English/Arabic) carry the same visual weight.

### Typographic Hierarchy
*   **Display (lg/md):** Reserved for singular, life-critical numbers (e.g., "Distance to Signal"). 
*   **Headline (sm/md):** Used for site locations and sector names.
*   **Label (md/sm):** Use `label-md` for all technical metadata. These should be set in all-caps with a +5% letter-spacing to enhance readability in outdoor glare.
*   **Body (md):** Standardized for reports and descriptions.

---

## 4. Elevation & Depth
In this system, elevation is conveyed through **Tonal Layering**, not structural shadows.

1.  **The Layering Principle:** Depth is achieved by "stacking" container tiers. Place a `surface-container-lowest` element (darkest) inside a `surface-container-high` element (lighter) to create an "inset" look, perfect for data input fields.
2.  **Ambient Shadows:** If an element must "float" (e.g., a critical pop-up alert), use an extra-diffused shadow: `box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4)`. The shadow must feel like ambient occlusion, not a drop shadow.
3.  **The "Ghost Border" Fallback:** For accessibility in extreme sunlight, use a "Ghost Border" on interactive elements. This is a 1px border using `outline-variant` at 15% opacity. It provides a hint of structure without cluttering the UI.
4.  **Glassmorphism:** Use semi-transparent `surface-container` tiers for overlays. This allows the underlying map or data-stream to remain partially visible, maintaining the user's spatial awareness.

---

## 5. Components

### Buttons
*   **Primary (Danger/Action):** Background `primary-container`, text `on-primary-container`. High-contrast, no border, `ROUND_FOUR`.
*   **Secondary (Navigation):** Background `surface-container-highest`, text `on-surface`.
*   **Tertiary (Minor):** Ghost style (no background) with `label-md` typography.

### Cards & Lists
*   **No Dividers:** Forbid the use of line dividers between list items. Use an 8px vertical gap (`spacing-md`) and subtle background alternates or a shift in `surface-container` depth to distinguish items.
*   **Active State:** An active list item should utilize the `secondary-container` (Green) as a subtle left-hand accent bar (4px width), never a full-box highlight.

### Input Fields
*   **Structure:** Use `surface-container-lowest` for the field background to create a "hollow" feel.
*   **Focus State:** The `outline` should glow with the `tertiary` color at 50% opacity. 

### Custom Mission Components
*   **Signal Strength Meter:** A series of vertical bars using `surface-container-highest` as the base, filling with `secondary` or `primary` based on signal intensity.
*   **Hazard Markers:** Hexagonal shapes (symbolizing precision) using the `error_dim` color for detected mines, with a `Glassmorphism` halo to indicate the radius of danger.

---

## 6. Do’s and Don’ts

### Do:
*   **Maintain Sunlight Readability:** Always check the contrast between `on-surface` and `surface`. Use high-contrast tokens for all field-op screens.
*   **Respect RTL:** Ensure that when the UI flips for Arabic (Cairo), the hierarchy remains intact. The most critical data should always be the first thing the eye hits.
*   **Use Functional Rounding:** Stick strictly to `ROUND_FOUR` for technical components and `ROUND_EIGHT` for larger containers.

### Don't:
*   **Don't use pure white:** Use `on-surface` or `surface-bright`. Pure white (#FFFFFF) in a dark UI can cause "halation" (eye strain) for operators in the dark.
*   **Don't use 1px Dividers:** If you feel the need to "separate" something, use space or a color shift. Lines are a sign of a weak hierarchy.
*   **Don't hide critical data:** Never use tooltips for essential hazard info. If it can kill you, it must be visible at all times.