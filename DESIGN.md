# DESIGN.md

## General visual direction
Clean, airy, minimal, soft premium e-commerce style.

Do not improvise another style.
Stay visually close to Figma.

## Main fonts
Use these roles consistently:

### Urbanist
Primary font for:
- welcome title
- login screen
- screen headers
- product titles
- CTA labels
- cart/wishlist titles

### Inter
Supporting/system font for:
- some secondary metadata
- input support text
- small UI labels
- price labels like `Price` / `Cart total`

### Lora
Accent font for:
- large money totals
- highlighted price in bottom action bars

## Core colors
- Primary light gold: `#F4D374`
- Primary strong gold: `#D59F07`
- Accent pale: `#FFE8B2`
- Accent light: `#FFE393`
- Dark button: `#1E1E1E`
- Dark text: `#252425`
- Header dark: `#1E232C`
- Inactive icon gray: `#CBCBD4`
- Meta gray: `#616161`
- Input background: `#F7F8F9`
- Input border: `#E8ECF4`
- Disabled background: `#F6F6F6`
- Error/delete red: `#CC474E`
- Active heart red: `#EB4335`

## Radius system
- Main buttons: `6`
- Inputs: `8`
- Product list cards: `10`
- Small image radius: `4`
- Back button radius: `12`

## Screen notes

### 1. Welcome
- large plant hero image
- centered branding block
- single dark CTA
- lots of whitespace

### 1.1 Login
- large welcome headline
- back button in light bordered square
- light filled inputs
- dark full-width login button

### 2 Home
- top greeting + logout CTA
- product list cards on light background
- fixed bottom nav
- clean vertical rhythm

### 2.1 Product Page
- large centered image
- airy top section
- white info block
- pale-gold sticky bottom price/add-to-cart bar

### 3. Cart
- compact rows
- quantity selector with bordered segmented control
- bottom total + checkout bar
- one swipe/delete destructive state is acceptable

### 4. Wishlist
- compact cards
- heart active in red
- white add-to-cart button inside card
- wishlist tab active in bottom nav

## Reusable component guidance
### Buttons
Support these variants:
- dark filled
- light gold filled
- strong gold filled
- outlined active
- outlined disabled
- disabled filled
- bottom action bar combination
- small and regular sizes

### Inputs
- light background
- subtle border
- rounded
- icon on password field
- no aggressive shadows

### Product cards
Keep a shared visual language between:
- home list cards
- wishlist cards
- cart rows

Do not rebuild from scratch each time.

## Bottom navigation
- minimal
- white background
- thin top divider
- active tab dark
- inactive tabs gray

## Fidelity rule
Stay close to Figma layout, spacing, hierarchy, color, and typography.

Do not waste time on pixel-perfect obsession, but do not drift visually.
