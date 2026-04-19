# Project Overview: Mine Detection System (Mobile)

## 1. Executive Summary
The **Syrian Mine Detection App** is a life-saving mobile extension of the existing web platform. It leverages real-time GPS tracking, offline data persistence, and an intuitive UI to help users report explosive remnants of war (ERW) and navigate safe zones within Syria.

## 2. Core Technical Stack
* **Frontend:** Flutter (Cross-platform Android/iOS).
* **State Management:** **Cubit** (A lightweight version of Bloc for predictable state changes).
* **Architecture:** **MVC (Model-View-Controller)**.
    * **Model:** Data structures (Report, User, Zone) and Repository layers.
    * **View:** Flutter Widgets and UI Screens.
    * **Controller:** Cubits that handle business logic and update the UI.
* **Backend Integration:** REST API (hosted on PythonAnywhere).
* **Local Storage:** Hive or SQLite (for offline report caching).

---

## 3. High-Level Architecture Flow
1.  **View (UI):** User interacts with the Map or the Reporting Form.
2.  **Cubit (Controller):** Receives the event (e.g., `SubmitReport`), triggers the loading state, and calls the Repository.
3.  **Model (Data/Repository):** Communicates with the API. If the device is offline, it saves the data to the local database.
4.  **Cubit (State Change):** Once the data is sent/saved, the Cubit emits a `Success` state.
5.  **View (UI):** Listens to the state change and shows the Success Screen.

---

## 4. Key Functional Modules

### A. Map & Geolocation Module
* **Function:** Display safety polygons and user location.
* **Cubit Logic:** `MapCubit` manages the fetching of zone coordinates and user permission handling.

### B. Reporting Module (The "Action" Module)
* **Function:** Multi-step form for reporting.
* **Cubit Logic:** `ReportCubit` manages form validation, image picking (Camera/Gallery), and the API POST request.

### C. Offline Sync Module
* **Function:** Queues reports when no internet is available.
* **Logic:** A background service or a "Sync" Cubit that checks for connectivity and flushes the local database to the server.

---

## 5. Technical Requirements & Permissions
To ensure the app functions correctly, the following mobile permissions must be implemented:
* **Location:** `ACCESS_FINE_LOCATION` (High accuracy for mine pinning).
* **Camera:** `CAMERA` (For taking photos of objects).
* **Storage:** `READ_EXTERNAL_STORAGE` (To upload existing photos).
* **Internet:** `INTERNET` (To sync with PythonAnywhere).

---

## 6. Project Roadmap (Phases)
| Phase | Focus | Deliverables |
| :--- | :--- | :--- |
| **Phase 1** | **Foundation** | Project structure (MVC folders), Cubit setup, Theme configuration. |
| **Phase 2** | **Map Integration** | Integrating Google Maps/Mapbox and displaying API zone data. |
| **Phase 3** | **Reporting System** | Camera integration, form validation, and API POST implementation. |
| **Phase 4** | **Local Persistence** | Implementing local storage for offline mode using Hive. |
| **Phase 5** | **QA & Deployment** | Stress testing GPS accuracy and publishing to Play Store/App Store. |

---

## 7. Folder Structure (MVC + Cubit)
```text
lib/
├── models/         # Data classes (e.g., report_model.dart)
├── views/          # UI Screens and Widgets (e.g., map_screen.dart)
├── controllers/    # Cubits (e.g., report_cubit.dart, report_state.dart)
├── repositories/   # API and Database calls
├── core/           # Constants, Themes, and App Config
└── main.dart       # App Entry point
```
# Mine-Detection-System---Syria
