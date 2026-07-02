# Alive App - Technical Interview Preparation Guide

This document contains expected technical interview questions tailored specifically to the codebase, architecture, and design decisions implemented in the **Alive App** technical assessment.

---

## 1. Architecture & Design Patterns

**Q1: I see you used Clean Architecture. Can you explain how you structured the layers in this app?**
**Answer:** I structured the app into three main layers: **Domain**, **Data**, and **Presentation**, following Clean Architecture principles.
*   **Domain Layer:** This is the core. It contains Entities (business objects) and Use Cases (business logic). It has absolutely no dependencies on Flutter or external packages.
*   **Data Layer:** This implements the Domain layer's contracts. It consists of Repositories (which implement Domain repository interfaces), Data Sources (Remote/Local APIs like Firebase), and Models (which map JSON to Domain Entities).
*   **Presentation Layer:** This contains UI (Widgets/Pages) and State Management (Riverpod ViewModels). It relies on the Domain layer via Use Cases to trigger actions.
This separation of concerns makes the app highly testable, scalable, and easy to maintain.

**Q2: Why did you choose Feature-First folder structuring over Layer-First?**
**Answer:** Inside `lib/features/`, I grouped everything by feature (e.g., `auth`, `stream`, `splash`) instead of grouping all models together or all screens together globally. This means if I need to work on Authentication, everything related to it (Presentation, Domain, Data) is in one place. It scales much better for larger teams compared to a Layer-First approach where you have to jump between 10 different folders just to add one feature.

**Q3: You used the `dartz` package for functional error handling. Why use `Either<Failure, Success>` instead of standard try-catch blocks?**
**Answer:** Using `Either` forces the Presentation layer (ViewModel) to explicitly handle both the success and error states at compile-time. If I just threw an exception, the compiler wouldn't force me to catch it, which could lead to unhandled crashes in production. By returning `Either<Failure, UserEntity>`, the ViewModel *must* use `.fold(left, right)` to handle the failure case (like showing a SnackBar) and the success case (like updating the UI state).

---

## 2. State Management (Riverpod)

**Q4: Why did you choose `flutter_riverpod` over Bloc, Provider, or GetX?**
**Answer:** Riverpod is compile-safe and doesn't rely on the Flutter Widget Tree (`BuildContext`) to read state, which makes testing ViewModels incredibly easy without needing a `MaterialApp` wrapper. Compared to Bloc, it requires much less boilerplate code. Compared to Provider, it solves the `ProviderNotFoundException` since providers are globally declared but safely scoped.

**Q5: Can you explain how you managed the Authentication State using Riverpod?**
**Answer:** I used a `NotifierProvider` for the `AuthViewModel`. The state is represented by a Freezed/Sealed class called `AuthState` which has three states: `initial`, `loading`, and `authenticated(UserEntity)` or `error(String)`. When the user clicks login, the ViewModel calls the `LoginUseCase`, sets the state to `loading`, and upon receiving the `Either` result, it emits either the `authenticated` state with the user data or the `error` state.

---

## 3. Navigation (GoRouter)

**Q6: You implemented `go_router` for navigation. How did you handle route protection (checking if a user is logged in)?**
**Answer:** `go_router` has a built-in `redirect` callback. Inside the router configuration, I inject the `AuthViewModel`. Whenever the auth state changes, the router's `redirect` function is triggered. If the user is trying to access the `/home` screen but their state is `unauthenticated`, it automatically redirects them to `/login`. If they are authenticated and on the `/login` screen, it redirects them to `/home`.

---

## 4. UI, UX & Responsiveness

**Q7: How did you ensure the UI is responsive across different screen sizes?**
**Answer:** I strictly avoided hardcoding pixel values. Instead, I used the `flutter_screenutil` package. All sizes are defined dynamically (e.g., `20.w` for width, `16.sp` for font size) based on a baseline design dimension (375x812). This ensures that the layout scales proportionally whether it's running on a small iPhone SE or a large tablet.

**Q8: I noticed you implemented Shimmer loading effects instead of standard CircularProgressIndicators. Why?**
**Answer:** Shimmer loading provides a significantly better User Experience (UX). It gives the user a visual skeleton of what the layout will look like before the data arrives, which reduces the perceived loading time and prevents layout shifts (jank) once the data is injected.

---

## 5. Firebase & Backend

**Q9: How did you handle Firebase Initialization in this project?**
**Answer:** I initialized Firebase in `main.dart` before `runApp`. To support multi-platform environments seamlessly, I used the generated `firebase_options.dart` file and passed `DefaultFirebaseOptions.currentPlatform`. I also set up a safe fallback for Web testing to use Android credentials if Web options weren't explicitly generated, preventing initialization crashes.

---

## 6. Testing (TDD)

**Q10: Can you walk me through your testing strategy?**
**Answer:** The Clean Architecture approach made testing straightforward. 
*   **Domain & Data:** I wrote Unit Tests for the Repositories and Use Cases by mocking the Remote Data Sources using the `mockito` package. I tested both the success paths (returning data) and failure paths (returning ServerExceptions).
*   **Presentation:** I tested the Riverpod ViewModels by overriding the repository providers in a `ProviderContainer` with mock repositories, verifying that the state transitions correctly from `initial` -> `loading` -> `success/error`.
*   **Integration:** I wrote E2E integration tests using the `integration_test` package to simulate the full user journey from the Splash Screen to the Home Screen.

**Q11: How do you mock Riverpod providers during testing?**
**Answer:** Since Riverpod providers are declared globally, I use a `ProviderContainer` in my test setup. I can pass `overrides` to this container, allowing me to replace the real `authRepositoryProvider` with a `MockAuthRepository`. This allows me to test the `AuthViewModel` in complete isolation without hitting real Firebase APIs.

---

## 7. General Problem Solving

**Q12: If we wanted to add a "Favorites" feature to the live streams, how would you architect that?**
**Answer:** 
1. **Domain:** Create a `ToggleFavoriteUseCase` and update the `StreamEntity` to include an `isFavorite` boolean.
2. **Data:** Update the `StreamModel` and `StreamRemoteDataSource` to hit a new API endpoint or Firestore collection (e.g., `/users/{userId}/favorites`).
3. **Presentation:** In the UI, clicking the heart icon would trigger `ref.read(streamViewModelProvider.notifier).toggleFavorite(streamId)`. The ViewModel calls the Use Case. I'd use Optimistic UI updating—immediately toggling the heart to red in the local state, and if the API call fails via the `Either` return, reverting it and showing a SnackBar error.
