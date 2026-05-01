# Task Planner Application

A powerful and efficient personal task management application built with Flutter. This app features a robust offline-first experience using a local SQLite database and follows the MVVM (Model-View-ViewModel) architecture for clean code separation and maintainability.

## Features

### Authentication System
- **Secure Login**: Access the app using email and password credentials.
- **Auto-Registration**: New users are automatically registered on their first valid login attempt.
- **Session Management**: Persistent user sessions using shared preferences (UserDefaults) for automatic login on subsequent launches.
- **Robust Validation**: Real-time email format validation and empty field handling.

### Task Management
- **Dashboard**: A centralized view showing all tasks for the logged-in user.
- **Task Creation**: Create detailed tasks with:
  - Title & Description
  - Priority levels (High, Medium, Low)
  - Due Date & Time
- **Smart Indicators**:
  - **Overdue Alerts**: Task due dates turn red once the deadline has been reached.
  - **Visual Completion**: Tasks marked as completed feature a strikethrough effect.
  - **Auto-Cleanup**: Completed tasks are automatically deleted after 4 seconds to keep your list clean.
- **Dynamic Counters**: Real-time updates for Total and Completed task counts.

## Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Local Database**: [sqflite](https://pub.dev/packages/sqflite)
- **Persistent Storage**: [shared_preferences](https://pub.dev/packages/shared_preferences)
- **Architecture**: MVVM (Model-View-ViewModel)

## Project Structure

```text
lib/
├── core/
│   ├── services/       # Database helper and core services
│   └── storage/        # Key storage and shared preferences helper
├── data/
│   └── models/         # Data models (User, Task)
├── modules/
│   ├── auth/           # Login views and view models
│   ├── dashboard/      # Main task list views and view models
│   └── task/           # Add task views and view models
└── main.dart           # Application entry point
```

## Getting Started

1. **Clone the repository**
2. **Install dependencies**:
   ```bash
   flutter pub get
   ```
3. **Run the application**:
   ```bash
   flutter run
   ```

## Database Schema

### Users Table
- `id`: Unique UUID (Primary Key)
- `email`: User Email (Unique)
- `password`: User Password

### Tasks Table
- `id`: Unique UUID (Primary Key)
- `title`: Task Title
- `details`: Task Description
- `priority`: Priority Level (Low, Medium, High)
- `dueDate`: ISO-formatted date string
- `isCompleted`: Boolean (0/1)
- `createdAt`: ISO-formatted date string
- `ownerEmail`: Foreign Key (References Users table)
