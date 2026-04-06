# Fake Store Demo (LYQX Test Task)

Compact Flutter app built as a test task for **LYQX**.

## Stack
- Flutter
- Dio
- flutter_bloc
- get_it + injectable
- shared_preferences
- go_router

## Implemented Features
### Mandatory
- Welcome screen
- Login flow (`POST /auth/login` + profile fetch)
- Products list from API with lazy loading (pagination)
- Product details screen
- Cart: add/remove items, quantity control, total price

### Optional (implemented)
- Wishlist with local persistence (`shared_preferences`)
- Add/remove favorite products
- Add to cart from wishlist

## Project Structure
Feature-first, moderate clean architecture:
- `core/` — shared infrastructure (theme, DI, router, network, reusable widgets)
- `features/*/data` — DTOs, data sources, repository implementations
- `features/*/domain` — entities/repository contracts where useful
- `features/*/presentation` — pages, widgets, bloc/cubit, state

## Key Decisions
- Pagination step: **24 items**
- Duplicate load-more protection in both scroll trigger and bloc state checks
- Theme-based styling via `AppPalette` and `AppTypography`
- Reusable UI components for consistent screens (`AppTopHeader`, `AppBottomNavBar`, cards, inputs, buttons)

## Run Locally
```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

## API
Base URL:
- `https://api.escuelajs.co/api/v1`
