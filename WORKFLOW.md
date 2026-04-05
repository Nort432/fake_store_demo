# WORKFLOW.md

## Implementation order
Follow this order exactly.

### Step 1 — project bootstrap
- create flutter project
- setup dependencies
- setup folder structure
- setup formatting/lints if needed

Checks:
- `flutter pub get`
- `dart format .`
- `flutter analyze`

Commit:
- `chore: initialize flutter project`

### Step 2 — app shell
- setup theme
- setup fonts
- setup colors/tokens
- setup router
- setup DI
- create reusable base widgets

Checks:
- run app
- verify fonts and theme load
- `flutter analyze`

Commit:
- `chore: setup app shell, routing, and dependency injection`

### Step 3 — welcome + login
- implement Welcome screen
- implement Login screen UI
- validation
- password visibility
- auth cubit
- login request
- navigate to home on success

Checks:
- test invalid form states
- test login loading/error/success
- `flutter analyze`

Commit:
- `feat: implement welcome and login flow`

### Step 4 — home + product list
- implement Home screen
- create product model/entity mapping
- fetch products
- product list bloc
- lazy loading
- reusable product card
- bottom nav

Checks:
- first page load
- scroll load more
- no duplicate pagination calls
- `flutter analyze`

Commit:
- `feat: implement products list with pagination`

### Step 5 — product details
- implement Product Page
- show image, title, category, rating, price
- add to cart action
- wishlist toggle UI if supported at this point

Checks:
- open from list
- add to cart works
- layout matches Figma
- `flutter analyze`

Commit:
- `feat: implement product details screen`

### Step 6 — cart
- cart cubit
- quantity selector
- remove item
- total price
- bottom checkout bar
- cart tab navigation

Checks:
- add item
- increase/decrease quantity
- remove item
- total recalculates correctly
- `flutter analyze`

Commit:
- `feat: implement cart state and cart screen`

### Step 7 — wishlist (optional)
- local persistence with shared_preferences
- wishlist screen
- add/remove from wishlist
- add to cart from wishlist

Checks:
- persistence survives restart
- active tab works
- `flutter analyze`

Commit:
- `feat: implement wishlist persistence and screen`

### Step 8 — cleanup and delivery
- README
- time estimate
- final cleanup
- quick smoke test
- prepare Loom explanation points

Checks:
- `flutter analyze`
- `flutter test` if tests exist
- run app through main flows

Commit:
- `docs: add readme and delivery notes`

## Validation loop after every step
Always do:
1. implement one small scope
2. format
3. analyze
4. run the relevant flow
5. fix issues
6. commit
7. push

## Push rule
Do not postpone push until the end.
Push after each verified step.

## Testing minimum
At least one small test is welcome:
- cart logic
or
- repository/model mapping
