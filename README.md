# Flutter Employee Management App

A Flutter application demonstrating CRUD operations using Back4App as the backend.

## Features

1. Authentication
   - User signup and login
   - Session management
   - Auto-logout on session expiration

2. Employee Management
   - Create, Read, Update, Delete (CRUD) operations
   - List view with employee details
   - Form validation
   - Confirmation dialogs for delete operations

3. Notification System
   - Real-time notifications for CRUD operations
   - Notification history with timestamps
   - Notification count badge
   - 24-hour notification retention
   - Persistent notifications using SharedPreferences

## Development Steps

1. Create new Flutter project:
```bash
flutter create assignement_flutter_cpad
cd assignement_flutter_cpad
```

2. Add required dependencies in `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  parse_server_sdk_flutter: ^7.0.0
  crypto: ^3.0.3
  shared_preferences: ^2.2.0
  timeago: ^3.5.0
```

3. Install dependencies:
```bash
flutter pub get
```

4. Back4App Setup:
   - Create account on [Back4App](https://www.back4app.com/)
   - Create new app
   - Get Application ID and Client Key from Security & Keys
   - Create "Employee" class with columns:
     - name (String)
     - email (String)
     - position (String)
     - salary (Number)
   - Create "User" class (automatically created by Back4App)
     - username (String)
     - password (String)
     - email (String)

5. Configure Back4App credentials:
   Create `lib/config/back4app_config.dart`:
```dart
class Back4AppConfig {
  static const String applicationId = 'YOUR_APP_ID';
  static const String clientKey = 'YOUR_CLIENT_KEY';
  static const String serverUrl = 'https://parseapi.back4app.com';
}
```

## Project Structure

### Directory Organization

```
lib/
├── config/
│   ├── back4app_config.dart    # Back4App credentials and configuration
│   └── app_config.dart         # Application-wide configuration
├── models/
│   ├── employee.dart           # Employee data model
│   └── notification_item.dart  # Notification data model
├── services/
│   ├── auth_service.dart       # Authentication handling
│   ├── employee_service.dart   # Employee CRUD operations
│   └── notification_service.dart # Notification management
├── screens/
│   ├── auth/
│   │   ├── login_screen.dart   # Login screen
│   │   └── signup_screen.dart  # Signup screen
│   ├── employee/
│   │   ├── employee_list_screen.dart  # Employee listing
│   │   └── employee_form_screen.dart  # Add/Edit employee
│   └── notification/
│       └── notification_history_screen.dart # Notification history
├── widgets/
│   ├── common/
│   │   ├── loading_indicator.dart
│   │   └── error_dialog.dart
│   ├── employee/
│   │   ├── employee_card.dart
│   │   └── employee_list_item.dart
│   └── notification/
│       ├── notification_badge.dart
│       └── notification_item_widget.dart
└── main.dart                   # Application entry point
```

### Data Models

1. Employee Model
```dart
class Employee {
  final String id;
  final String name;
  final String email;
  final String position;
  final double salary;
  
  // Constructor and methods
}
```

2. Notification Model
```dart
class NotificationItem {
  final String message;
  final NotificationType type;
  final DateTime timestamp;
  final bool isRead;
  
  // Constructor and methods
}
```

### Service Layer

1. Authentication Service
```dart
class AuthService {
  Future<User> login(String username, String password);
  Future<User> signup(String username, String password, String email);
  Future<void> logout();
  bool isAuthenticated();
}
```

2. Employee Service
```dart
class EmployeeService {
  Future<List<Employee>> getEmployees();
  Future<Employee> getEmployee(String id);
  Future<Employee> createEmployee(Employee employee);
  Future<Employee> updateEmployee(Employee employee);
  Future<void> deleteEmployee(String id);
}
```

3. Notification Service
```dart
class NotificationService {
  Future<void> addNotification(NotificationItem notification);
  Future<List<NotificationItem>> getNotifications();
  Future<void> markAsRead(String notificationId);
  Future<void> clearOldNotifications();
}
```

### Back4App Schema

1. Employee Class
```json
{
  "name": "Employee",
  "fields": {
    "name": "String",
    "email": "String",
    "position": "String",
    "salary": "Number",
    "createdAt": "Date",
    "updatedAt": "Date",
    "createdBy": "Pointer<_User>"
  }
}
```

2. User Class (Default Parse Class)
```json
{
  "name": "_User",
  "fields": {
    "username": "String",
    "password": "String",
    "email": "String",
    "emailVerified": "Boolean",
    "authData": "Object"
  }
}
```

### State Management

The application uses a combination of:
- Provider for app-wide state management
- Local state for screen-specific state
- SharedPreferences for persistent notification storage

### Asset Organization

```
assets/
├── images/
│   ├── logo.png
│   └── icons/
└── fonts/
    └── custom_icons.ttf
```

### Configuration Files

Key configuration files:
- `pubspec.yaml`: Dependencies and assets
- `lib/config/back4app_config.dart`: Backend configuration
- `android/app/build.gradle`: Android build configuration
- `ios/Runner.xcodeproj`: iOS build configuration

## Implementation Details

### Notification System
- Persistent storage using SharedPreferences
- 24-hour retention policy
- Real-time notification count updates
- Timestamp display using timeago package
- Success/Error status indicators
- Clickable notification badge

### Error Handling
1. Form Validation
   - Required fields
   - Email format
   - Numeric salary
   - Input sanitization

2. API Error Handling
   - Network errors
   - Authentication errors
   - CRUD operation failures
   - User-friendly error messages

### UI/UX Features
1. Loading Indicators
   - During API calls
   - Form submissions
   - List refreshing

2. Responsive Design
   - Adaptive layouts
   - Proper spacing
   - Material Design components

3. Visual Feedback
   - Success/Error icons
   - Notification badges
   - Operation confirmations

## Security Considerations

1. Data Protection
   - Secure credential storage
   - Input validation
   - Session management

2. Error Prevention
   - Type checking
   - Null safety
   - Form validation

3. Access Control
   - User authentication
   - Session tokens
   - API access restrictions

## Testing

1. Unit Tests
   - Model validation
   - Service methods
   - Utility functions

2. Widget Tests
   - Form validation
   - UI rendering
   - User interactions

3. Integration Tests
   - CRUD operations
   - Authentication flow
   - Navigation

## Build & Release

1. Debug Build:
```bash
flutter build apk --debug
```

2. Release Build:
```bash
flutter build apk --release
```

## Troubleshooting

1. Parse Server Connection
   - Verify credentials
   - Check network connection
   - Validate server URL

2. Build Issues
   - Clean build: `flutter clean`
   - Update dependencies: `flutter pub get`
   - Check SDK version

3. Runtime Errors
   - Type conversion issues
   - Null safety violations
   - API response handling

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details
