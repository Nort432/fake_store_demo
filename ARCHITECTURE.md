# ARCHITECTURE.md

## Final architecture level
Use a **feature-first, moderate-clean** structure.

This should be:
- cleaner than a throwaway demo
- much lighter than enterprise clean architecture

## Folder structure
```text
lib/
  app/
    app.dart
    router/
  core/
    di/
    network/
    theme/
    constants/
    utils/
    widgets/
  features/
    auth/
      data/
      presentation/
    products/
      data/
      domain/
      presentation/
    cart/
      domain/
      presentation/
    wishlist/
      data/
      presentation/
```

## Layer rules
### core
Shared infrastructure only:
- app theme
- routing
- DI setup
- Dio config
- constants
- reusable UI components

### data
- remote data sources
- local data sources
- DTO/models
- repository implementations

### domain
Only where useful.
Use domain lightly:
- product entity
- cart item entity
- repository contracts if they clarify structure

Avoid a use case per button press.

### presentation
- screens
- feature widgets
- blocs/cubits
- state classes

## State management
Use:
- **Login = Cubit**
- **Products list with pagination = Bloc**
- **Cart = Cubit**
- **Wishlist = Cubit**

## Routing
Use **GoRouter**.

Routes:
- `/welcome`
- `/login`
- `/home`
- `/product/:id`
- `/cart`
- `/wishlist`

## DI
Use:
- `get_it`
- `injectable`

Register:
- Dio
- API client / remote data source
- repositories
- blocs/cubits
- SharedPreferences
- wishlist local storage

## Networking
Use Dio with:
- base URL in one place
- centralized error mapping
- no network calls inside widgets

## Pagination
Must support:
- initial load
- load more on scroll
- no duplicate requests
- keep old items while loading more
- stop when there is no more data

## Reusable UI rule
The design must be **DRY**, but not over-abstracted.

Create reusable widgets only where repetition is real:
- `AppButton`
- `AppTextField`
- `ProductCard`
- `WishlistCard` or configurable product card mode
- `QuantitySelector`
- `BottomActionBar`
- `AppBottomNavBar`
- `LogoutAction`

Avoid extracting tiny meaningless wrappers.
