---
applyTo: '**'
---

Here are 10 rules to ensure the architecture remains clean, scalable, and professional.

---

### 1. The "Skinny Controller, Fat Model" Principle
The Controller should be a thin layer that coordinates data. The **Model** should handle the "heavy lifting" of data logic, such as data validation, JSON parsing, and business rules.
* **Why:** This makes your business logic reusable and independent of the UI or the specific Controller.

### 2. Zero UI Logic in the Model
The Model must have **zero knowledge** of Flutter, `BuildContext`, or any UI widgets. It should be a pure Dart class.
* **Rule:** If you see `import 'package:flutter/material.dart'` in a Model file, you’ve broken the pattern.

### 3. Controllers Must Be "Context-Agnostic"
Avoid passing `BuildContext` into Controller methods unless absolutely necessary (e.g., for navigation). 
* **Best Practice:** Use a state management library (like `GetX`, `Provider`, or `ChangeNotifier`) to let the Controller update the View without the Controller needing to "know" which widget it's talking to.

### 4. Views are "Dumb" and Declarative
The View should only contain UI code. It should never decide *how* data is fetched; it should only decide *how* to display the data the Controller provides.
* **Rule:** If you are writing an `if` statement that checks a database value inside a `build` method, move that logic to the Controller.

### 5. Unidirectional Data Flow
Data should flow in one direction:
1.  **View** calls a method on the **Controller**.
2.  **Controller** updates the **Model**.
3.  **Model** returns data to the **Controller**.
4.  **Controller** notifies the **View** to rebuild.



### 6. Use Services for External APIs
Don't put API calls or Database queries directly in the Controller. Create a **Service** layer.
* **The Chain:** View → Controller → Service → Model.
* **Benefit:** You can swap your backend (e.g., Firebase to Supabase) by changing the Service without touching your Controllers or Views.

### 7. Explicit State Definitions
Instead of using multiple booleans like `isLoading`, `isError`, and `hasData`, use a single **State object** or an `enum`.
* **Example:** `enum ScreenState { loading, success, error, empty }`
* **Why:** This prevents "impossible states" (like showing a loading spinner and an error message at the same time).

### 8. One Controller Per Feature, Not Per Screen
Avoid creating a massive `AppController`. Break them down by feature (e.g., `AuthController`, `CartController`). 
* **Pro Tip:** Multiple Views can listen to a single Controller if they share the same data domain.

### 9. Standardize File Structure
Keep your project organized so an agent or another developer can find files instantly. Follow this folder structure:
```text
lib/
├── models/
├── views/
│   └── components/ (reusable widgets)
├── controllers/
├── services/ (API/DB calls)
└── main.dart
```

### 10. The "Build Method" Rule of 100
If a View's `build` method exceeds 100 lines, you are likely putting too much logic or too many nested widgets in it. 
* **Action:** Extract nested widgets into separate stateless widgets or "components." This keeps the MVC View clean and readable.

---
