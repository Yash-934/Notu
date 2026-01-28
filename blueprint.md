
# NOTU - A Minimalist Note-Taking App

## Overview

NOTU is a minimalist note-taking application designed for writers, students, and anyone who needs a simple, elegant tool to capture their thoughts and ideas. The app is built with Flutter and uses a local SQLite database for data persistence, ensuring that your notes are always available, even offline.

## Style, Design, and Features

### Design and Theming

*   **Modern & Minimalist UI:** The app features a clean and modern design with a focus on readability and ease of use.
*   **Light & Dark Modes:** A user-selectable theme allows for switching between light and dark modes.
*   **Custom Fonts:** The app uses Google Fonts to provide a unique and elegant typography.
    *   **Headlines:** `Playfair Display`
    *   **Titles:** `Lato`
    *   **Body:** `Open Sans`
*   **Consistent Color Scheme:** A consistent color scheme is used throughout the app, with `Colors.teal` as the primary seed color.
*   **Smooth Transitions:** The `animations` package is used to provide beautiful and seamless transitions between screens.
*   **Polished Add Book Screen:** The "Add Book" screen has been redesigned with a modern and polished look, featuring a `Card` layout, improved spacing, and a circular avatar for the thumbnail preview.

### Core Features

*   **Offline First:** All data is stored locally in an SQLite database, making the app fully functional offline.
*   **Books and Chapters:** Organize your notes into books and chapters.
*   **Book Thumbnails:** Users can add a thumbnail image to each book, which is displayed in a beautiful grid view.
*   **CRUD Operations:** Full Create, Read, Update, and Delete functionality for both books and chapters.
*   **Markdown and HTML Support:** Chapter content can be written in either Markdown or HTML/CSS/JS.
    *   The `webview_flutter` package is used to render HTML content.
*   **Polished UX:**
    *   **Snackbars:** Provide visual feedback for actions like adding, deleting, and updating items.
    *   **Haptic Feedback:** Subtle haptic feedback enhances the user experience.
    *   **Empty States:** Beautiful and informative "empty state" screens guide the user when there is no content.
*   **State Management:** The app uses a combination of `StatefulWidget` and `ChangeNotifierProvider` for state management.

## Current Plan

*   **Implement HTML/CSS/JS Support:** The user has requested the ability to add notes in HTML, CSS, and JavaScript. This involved:
    *   Adding the `webview_flutter` dependency.
    *   Updating the `Chapter` model and `DatabaseHelper` to include a `contentType` field.
    *   Modifying the `AddChapterScreen` to allow users to select the content type.
    *   Updating the `ChapterDetailsScreen` to render HTML content using a `WebView`.
*   **Enhance Visual Design:** The `AddBookScreen` has been redesigned for a more modern and polished user experience.
*   **Next Steps:**
    *   Continue to refine the visual design of the app.
    *   Add more interactive elements and animations.
    *   Implement a search functionality to easily find notes.
