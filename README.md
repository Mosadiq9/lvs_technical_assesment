# Alive App — Flutter UI & Navigation Evaluation Project

A high-fidelity, pixel-accurate Flutter application demonstrating clean architecture, robust state management, and modern responsive UI design.

---

# Project Overview

Alive App is a production-grade Flutter application developed as part of a technical evaluation to showcase expertise in UI/UX fidelity, structural clean architecture, and scalable design patterns. The project demonstrates how to translate complex UI references into responsive, animated Flutter components while maintaining clear separation of concerns, reactive state management using Riverpod, and readiness for real-world enterprise backend integrations.

---

# Screens

• **Splash Screen**: Initial startup screen featuring smooth fade and scale animations of the brand logo, automatically transitioning into the authentication flow using declarative routing.
• **Login Screen (Google Authentication)**: Clean, conversion-focused sign-in page providing single-click Google Authentication powered by Firebase, complete with loading overlays, reactive error handling, and customized terms footer.
• **Home Screen**: Rich discovery interface featuring horizontal category filters, top navigation tabs (`Stream`, `Hot`, `Follow`), interactive live stream presenter cards with live indicators and follow actions, and a custom U-shaped bottom navigation bar with elevated center broadcast controls.

---

# Features

• **Google Authentication**: Single sign-on authentication flow using `firebase_auth` and `google_sign_in` with clean error propagation.
• **Responsive UI**: Adaptive layout scaling across diverse mobile screen dimensions using `flutter_screenutil` and multi-device preview tooling (`device_preview`).
• **Smooth Animations**: Micro-interactions, custom Bezier curve rendering, button scaling effects, and fluid page transitions.
• **Clean Architecture**: Strict layered modularity separating UI presentation from domain logic and data persistence.
• **MVVM Pattern**: ViewModels managing UI state mutations and isolating presentation widgets from business logic.
• **Riverpod State Management**: Type-safe, testable dependency injection and reactive state providers (`flutter_riverpod`).
• **Reusable Widgets**: Atomic design approach with dedicated widgets for buttons, cards, app bars, forms, and custom navigation components.
• **API Ready Structure**: Scalable `Dio`-based HTTP client wrapper with centralized error handling, environment configurations (`.env`), and structured repository interfaces ready for REST endpoints.
• **Custom Theme**: Centralized styling engine defining strict color palettes, typography (`GoogleFonts`), border radii, and spacing constants.
• **Navigation**: Declarative routing engine utilizing `go_router` with custom fade transition animations.
• **Firebase Integration**: Native Firebase project initialization supporting authentication and future cloud services.

---

# Architecture

The application implements **Clean Architecture** combined with the **Model-View-ViewModel (MVVM)** pattern to achieve modularity, testability, and separation of concerns.

### Presentation Layer (`presentation/`)
Responsible for rendering UI elements and capturing user actions. Consists of:
- **Pages**: Top-level screen views (`SplashPage`, `LoginPage`, `HomePage`).
- **Widgets**: Component-level modular UI elements (`StreamGrid`, `LoginHeader`, `LiveStreamCard`).
- **Providers / ViewModels**: State holders (`AuthViewModel`, `StreamViewModel`) emitting immutable state objects (`AuthState`, `StreamState`) to drive UI rebuilds reactivity.

### Domain Layer (`domain/`)
Encapsulates application business rules independent of external frameworks or UI concerns. Consists of:
- **Entities**: Pure Dart immutable data models (`UserEntity`, `StreamEntity`).
- **Repositories (Interfaces)**: Abstract contracts defining data operations (`AuthRepository`, `StreamRepository`).
- **Use Cases**: Single-responsibility executors orchestrating domain workflows (`SignInWithGoogleUseCase`).

### Data Layer (`data/`)
Manages data retrieval, API requests, and local caching. Consists of:
- **Data Sources**: Concrete implementations handling external communications (`AuthRemoteDataSource`, `StreamRemoteDataSource`).
- **Models**: Data Transfer Objects (DTOs) extending domain entities with serialization capabilities (`UserModel`, `StreamModel`).
- **Repositories (Implementations)**: Concrete classes implementing domain repository contracts (`AuthRepositoryImpl`).

---

# Folder Structure

```text
lib/
├── core/
│   ├── config/
│   │   ├── app_router.dart
│   │   └── environment.dart
│   ├── errors/
│   │   └── exceptions.dart
│   ├── network/
│   │   ├── api_client.dart
│   │   └── api_endpoints.dart
│   ├── shared/
│   │   └── widgets/
│   │       ├── app_logo.dart
│   │       ├── app_text_field.dart
│   │       ├── category_chip.dart
│   │       ├── circular_icon_button.dart
│   │       ├── country_flag.dart
│   │       ├── custom_bottom_nav_bar.dart
│   │       ├── gradient_background.dart
│   │       ├── live_stream_card.dart
│   │       ├── loading_overlay.dart
│   │       ├── network_image_widget.dart
│   │       ├── primary_button.dart
│   │       ├── social_login_button.dart
│   │       └── top_app_bar.dart
│   ├── theme/
│   │   ├── app_assets.dart
│   │   ├── app_colors.dart
│   │   ├── app_durations.dart
│   │   ├── app_radius.dart
│   │   ├── app_spacing.dart
│   │   ├── app_text_styles.dart
│   │   └── app_theme.dart
│   └── utils/
│       └── extensions.dart
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── pages/
│   │       ├── providers/
│   │       └── widgets/
│   ├── home/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │       └── pages/
│   ├── splash/
│   │   └── presentation/
│   │       └── pages/
│   └── stream/
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   └── repositories/
│       └── presentation/
│           ├── providers/
│           └── widgets/
├── app.dart
├── firebase_options.dart
└── main.dart
```

---

# State Management

**Riverpod (`flutter_riverpod`)** was selected as the core state management solution due to:
1. **Compile-Time Safety**: Eliminates runtime `ProviderNotFoundException` errors common in service locators.
2. **Immutable State Transitions**: Ensures predictable debugging and reliable widget rebuilds using sealed classes (`AuthStateAuthenticated`, `AuthStateLoading`, `AuthStateError`).
3. **Decoupled Testing**: Allows effortless overriding of data sources and use cases inside unit tests via `ProviderScope`.

### ViewModel to UI Communication
UI components extend `ConsumerWidget` or `ConsumerStatefulWidget` and observe ViewModel states using `ref.watch()`. Side effects (such as displaying snackbars or triggering navigation redirects upon successful login) are managed declaratively inside `ref.listen()` callbacks, ensuring clean separation between render logic and business side effects.

---

# Packages Used

| Package | Purpose |
| :--- | :--- |
| `flutter_riverpod` | Reactive state management and dependency injection |
| `go_router` | Declarative URL-based navigation and transition management |
| `firebase_core` / `firebase_auth` | Core Firebase infrastructure and cloud authentication |
| `google_sign_in` | Native Google OAuth sign-in integration |
| `flutter_screenutil` | Responsive layout scaling for responsive UI design |
| `dio` | HTTP client wrapper for REST API consumption |
| `google_fonts` | Modern typography rendering across platforms |
| `cached_network_image` | Efficient image caching and placeholder rendering |
| `flutter_dotenv` | Secure loading of environment variables from `.env` |
| `cupertino_icons` / `lucide_icons` / `bootstrap_icons` | High-precision icon typography matching design specs |
| `device_preview` | Multi-device viewport simulation during development |
| `freezed_annotation` / `json_annotation` | Code generation annotations for immutable models |
| `dartz` | Functional programming utilities (`Either`) for error handling |
| `logger` | Clean, readable debugging and network logging |

---

# Firebase

Firebase Authentication is natively integrated inside `AuthRemoteDataSourceImpl`:
1. **Initialization**: Initialized in `main.dart` via `Firebase.initializeApp()` using platform-specific configurations (`firebase_options.dart`).
2. **Authentication Flow**: When triggered, `GoogleSignIn` initiates the native OAuth credential exchange. The resulting access and ID tokens are passed into `FirebaseAuth.instance.signInWithCredential()`.
3. **User Mapping**: Converted seamlessly into application-level immutable `UserEntity` instances for use throughout the domain layer.

---

# Responsive Design

Responsiveness is engineered from the ground up using **`flutter_screenutil`**:
- All UI dimensions (padding, margins, font sizes, widget heights) are defined relative to a standard mobile viewport (`375x812`) using `.w` (width extension), `.h` (height extension), and `.sp` (font scaling extension).
- Ensures exact layout proportionality whether running on small Android devices, iPhones, or tablet screens.
- **Device Preview Support**: Integration with `device_preview` allows real-time verification across varied screen densities and safe area configurations.

---

# Reusable Components

• `CustomBottomNavBar`: Highly customized navigation bar featuring symmetrical Bezier curve cutouts (`CustomPaint`), floating action center broadcast button, pixel-matched icons, and manual bottom gap controls.
• `TopAppBar`: Modular header supporting search triggers, notification badges, and user profile sheet invocation.
• `LiveStreamCard`: Interactive presenter card presenting viewer counts, country flags, live badges, and follow actions.
• `LoadingOverlay`: Full-screen modal blocking loader with smooth opacity transitions during asynchronous operations.
• `PrimaryButton` & `CircularIconButton`: Standardized interactive button elements with built-in loading states and feedback styling.
• `AppTextField`: Styled input field with standardized borders and validation hooks.
• `CategoryChip`: Pill-shaped toggle filters for horizontal category selection.

---

# Navigation

Navigation is handled via **`go_router`** configured in `core/config/app_router.dart`:
- **Declarative Routes**: Clear, URL-based route definitions (`/splash`, `/login`, `/home`).
- **Custom Page Transitions**: Standardized `FadeTransition` animations between screen changes to deliver a polished feel.
- **Auth Guarding**: Clean navigation redirects decoupled from UI components triggered via reactive state listeners upon authentication events.

---

# API Ready Structure

The project is structured to seamlessly switch from local/mock data to remote REST endpoints:
- **Network Layer**: `ApiClient` wraps the `Dio` package with pre-configured request timeouts, logging interceptors, and environment-based host resolution via `API_BASE_URL`.
- **Repository Abstraction**: UI components depend solely on domain interfaces (`StreamRepository`). Replacing local mock data with remote API responses requires zero modifications to presentation code or ViewModels.
- **Structured Error Handling**: Custom exception mapping converts raw HTTP failures into predictable domain failure states.

---

# Getting Started

### Clone Repository
```bash
git clone https://github.com/Mosadiq9/lvs_technical_assesment.git
cd alive_app
```

### Install Dependencies
```bash
flutter pub get
```

### Configure Environment & Firebase
Ensure `.env` is configured in the root directory:
```env
GOOGLE_SERVER_CLIENT_ID=your_client_id_here
API_BASE_URL=https://api.aliveapp.com/v1
```

### Run Application
```bash
flutter run
```

---

# Screenshots

## Splash

![Splash](screenshots/splash.png)

## Login

![Login](screenshots/login.png)

## Home

![Home](screenshots/home.png)

---

# Project Highlights

• **Strict Layered Separation**: Complete isolation of Presentation, Domain, and Data layers ensuring effortless maintenance and testing.
• **High-Fidelity Custom Rendering**: Utilizes `CustomPaint` and complex Bezier mathematics to render exact U-shaped notch geometries.
• **Immutable State Modeling**: Zero reliance on mutable global variables; all state mutations flow through sealed classes and Riverpod providers.
• **Pixel-Perfect Scaling**: Strict adoption of design system tokens and viewport-relative scaling ensuring visual integrity on every screen size.
• **Production Security Practices**: Environment secrets managed via `.env` with strict exclusions defined in `.gitignore`.
• **Robust Exception Handling**: Comprehensive try-catch boundaries converting external API exceptions into user-friendly error feedback.
• **Enterprise Readiness**: Built with clean interfaces and modular separation making future expansions (such as websocket chat or WebRTC streaming) straightforward.

---

# Future Improvements

• **Real-Time WebRTC Streaming Integration**: Connecting the live stream cards to real-time video playback endpoints.
• **WebSocket Live Chat Module**: Implementing real-time interactive messaging overlays within live broadcast sessions.
• **Automated Unit & Integration Test Suite**: Expanding current test scaffolding into CI/CD pipelines covering 100% of domain use cases.
• **Localized Multi-Language Support (`flutter_localizations`)**: Adding dynamic internationalization support for global user bases.

---

# Author

**Name:**  
Mosadiq Shaikh

**Role:**  
Senior Flutter Developer / Tech Lead

**GitHub:**  
[https://github.com/Mosadiq9/lvs_technical_assesment](https://github.com/Mosadiq9/lvs_technical_assesment)

**LinkedIn:**  
[Mosadiq Shaikh Profile](https://www.linkedin.com/in/mosadiq-shaikh)
