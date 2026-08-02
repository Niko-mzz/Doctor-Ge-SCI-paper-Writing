---
name: paper-figure
description: Publication-quality figure standards for SCI papers. Use when creating, refining, or reviewing figures for academic journals (especially Journal of Luminescence, Optical Materials). Covers resolution, font sizes, color schemes, multi-panel layout, data-ink ratio, and journal-specific requirements. TIF/PNG export for final submission, PNG for drafts.
metadata:
  short-description: Publication-quality figure creation and formatting
---

# Paper Figure -- ???????

## Resolution & Format

- **Draft**: PNG, 150-300 DPI
- **Final submission**: TIF, ?600 DPI (Journal of Luminescence requires ?1200 DPI for line art)
- **Size**: Single column ~8.5 cm, double column ~17 cm width
- Never use JPG for data figures (compression artifacts)

## Typography

- All text in figures: **Arial** or **Helvetica**, 8-10 pt
- Panel labels: **(a)**, **(b)** in bold, 10-12 pt, top-left corner
- Axis labels: 9 pt, unit in parentheses: "Wavelength (nm)"
- Legend: 8 pt, placed inside plot area when possible
- No title on figure (title goes in caption)

## Color

- Use colorblind-friendly palettes (viridis, cividis, plasma)
- Never use red-green as sole contrast
- For spectral line plots: black, red, blue, dark green (most visible)
- Background: white or transparent (never gray)

## Multi-Panel Layout

- Label sequentially: (a), (b), (c), (d) -- row-major order
- Equal panel sizes within a row
- Shared axes aligned precisely
- Minimal white space between panels

## Spectral Data Plots

- X-axis: Wavelength (nm), increasing left to right
- Y-axis: Intensity (a.u.) or Normalized Intensity
- Offset stacked spectra for clarity, label each trace
- Mark key peaks with transition labels (e.g., ?S???I?)
- Energy level diagrams: clear arrows for excitation (?), emission (?), ET (dashed)

## Data-Ink Ratio (Tufte Principle)

- Remove chart borders, background grids, redundant tick marks
- Show only essential data
- Error bars where applicable
- Avoid 3D effects, shadows, gradients

## Quick Checklist

- [ ] Resolution ?300 DPI for draft, ?600 DPI for final
- [ ] Font size ?8 pt (readable when printed)
- [ ] Colorblind-friendly palette
- [ ] Panel labels: (a), (b), (c)
- [ ] No JPG artifacts
- [ ] Axes labeled with units
- [ ] Legend present and readable
- [ ] Consistent style across all figures
