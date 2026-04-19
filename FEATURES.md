# 🌟 Features - Syrian Mine Detection App

The mobile application is designed to be a resilient, life-saving tool with advanced MVC architecture and state management provided by Cubit.

## 🗂 Codebase Architecture Principles
- **Model-View-Controller (MVC) Architecture**: Predictable, clearly decoupled layers isolating business logic from the view.
- **Flutter Bloc (Cubit)**: Highly predictable state management bridging Controllers and the UI.
- **Dio Client Interceptors**: Generic HTTP client robustness, auto-incorporating authorization tokens seamlessly.
- **Hive-CE**: Background Key-Value database integration aiming to handle offline caching and local data querying.

## 🔐 Authentication Module
- Clean token-based login flow.
- Secure, context-agnostic storage of session tokens bridging `AuthService` and `AuthCubit`.

## 🗺️ Map & Zones Module
- Zone extraction handling both direct and strictly formatted GeoJSON API responses (`fromFeature`).
- Graceful Offline Resilience: Zones are transparently persisted using `Hive-CE` and served immediately when the backend is inaccessible via `OfflineException` traps.

## 📝 Reporting Module
- Fully mapped data model connecting `Visitor` generated incident submissions natively. 
- Integrated capabilities natively accepting combined `multipart/form-data` (merging imagery streams with precise map coordinate parameters).

## 📊 Administrator & Statistics Module
- High-level dashboards analyzing broad system statistics (total mines, safe/unsafe zone statuses, and specific report classifications).
- Native tracking systems evaluating distinct `MineType` variables for granular discovery inputs.
