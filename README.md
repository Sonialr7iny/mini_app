# Flutter Widget Catalog & Theming Demo

This Flutter application serves as a mini widget catalog, demonstrating various built-in Flutter widgets, animations, and a dynamic light/dark theming system. It includes features like a draggable scrollable sheet, custom drawer, and interactive UI elements.

## Features

*   **Widget Showcase:**
    *   **Animations:** `AnimatedCrossFade`, `AnimatedContainer`, `AnimatedAlign`, `AnimatedBuilder` (for rotation), `AnimatedDefaultTextStyle`.
    *   **Input & Selection:** `Switch`, `IconButton` (standard and outlined), `Badge`, `Checkbox`, `Radio`, `SegmentedButton`, `Chip`.
    *   **Buttons:** `OutlinedButton`, `FilledButton`, `FilledButton.tonal`, `ElevatedButton` (with custom `WidgetStateProperty` styling).
    *   **Progress Indicator:** `LinearProgressIndicator` animated with a controller.
    *   **Layout & Display:** `Stack`, `Positioned`, `Row`, `Column`, `Expanded`, `SingleChildScrollView`, `Card`, `ListTile`, `Divider`, `FlutterLogo`.
    *   **Interactive Sheet:** `DraggableScrollableSheet` populated with data from a local JSON file.
    *   **Navigation:** `AppBar`, `Drawer`.
*   **Dynamic Theming:**
    *   Supports both **Light and Dark themes**.
    *   Theme can be toggled via an icon button in the `AppBar`.
    *   Customized theme properties for `scaffoldBackgroundColor`, `appBarTheme`, `cardTheme`, `drawerTheme`, `bottomSheetTheme`, and `textTheme`.
    *   `DraggableScrollableSheet` and `Drawer` components adapt their appearance based on the selected theme.
*   **Data Handling:**
    *   Loads list data asynchronously from a local `assets/data.json` file to populate the `DraggableScrollableSheet`.
*   **Interactivity:**
    *   Stateful widgets managing various UI states (animations, selections, theme).
    *   GestureDetectors for triggering animations.

## App Structure

*   **`main.dart`:** Contains the root `MyApp` widget and the main `MyHomePage` widget.
    *   **`MyApp`:** Sets up `MaterialApp` with light and dark theme configurations and manages the current theme mode (`isDark`).
    *   **`MyHomePage`:** The main screen that displays the widget catalog. It includes:
        *   An `AppBar` with a theme toggle.
        *   A `Stack` layout to layer background elements and the main content.
        *   A `SingleChildScrollView` to allow scrolling of the widget demonstrations if they exceed screen height.
        *   A `DraggableScrollableSheet` at the bottom, themed dynamically.
        *   A `Drawer` for navigation, also themed.

## Key Widgets Demonstrated

*   **`MaterialApp`:** For theme setup (`theme`, `darkTheme`, `themeMode`).
*   **`Scaffold`:** Basic material design visual layout structure.
*   **`AppBar`:** Application bar with title and actions.
*   **`Stack` & `Positioned`:** For complex layered UIs and precise element placement.
*   **`Column` & `Row`:** For linear layouts.
*   **`SingleChildScrollView`:** For making content scrollable.
*   **`DraggableScrollableSheet`:** For creating a sheet that can be dragged up and down.
*   **`ListView.separated`:** For efficiently displaying lists with separators.
*   **`Card` & `ListTile`:** For structured content display.
*   **Various `Animated...` Widgets:** For creating smooth UI transitions and effects.
*   **`Theme.of(context)`:** Used extensively to access current theme properties and make UI elements adaptive.


[Watch demo video](recorded/mini_app.webm)


## Setup & Running

1.  **Ensure Flutter is installed.** (See [flutter.dev](https://flutter.dev/))
2.  **Clone the repository (if applicable) or have the project files.**
3.  **Create `assets/data.json`:**
    Make sure you have a JSON file at `assets/data.json`. An example format is:


    
    
