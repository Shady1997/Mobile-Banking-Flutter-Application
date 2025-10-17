# 🏦 Mobile Banking Flutter Application

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?style=flat&logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?style=flat&logo=dart)](https://dart.dev)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.0+-6DB33F?style=flat&logo=springboot)](https://spring.io/projects/spring-boot)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A comprehensive cross-platform mobile banking management system built with Flutter and Spring Boot. Manage users, accounts, and transactions with a modern, responsive interface that works on Web, Desktop, Android, and iOS.

---

## 📋 Table of Contents

- [Features](#-features)
- [Prerequisites](#-prerequisites)
- [Project Structure](#-project-structure)
- [Installation](#-installation)
- [Running the Application](#-running-the-application)
  - [Step 1: Start Backend Server](#step-1-start-backend-server)
  - [Step 2: Run Flutter Web (Recommended)](#step-2-run-flutter-web-recommended)
  - [Step 3: Run on Desktop](#step-3-run-on-desktop-optional)
  - [Step 4: Run on Android](#step-4-run-on-android-optional)
  - [Step 5: Run on iOS](#step-5-run-on-ios-optional)
- [Testing](#-testing)
- [Troubleshooting](#-troubleshooting)
- [API Documentation](#-api-documentation)
- [Contributing](#-contributing)
- [License](#-license)

---

## ✨ Features

### 🔐 **Authentication**
- Secure login system with credential validation
- Session management and state persistence
- Protected routes and authorization

### 👥 **User Management**
- ✅ Create, read, and delete users
- ✅ Search by username
- ✅ View all users in paginated tables
- ✅ Validation for username, email, password, phone

### 💳 **Account Management**
- ✅ Multiple account types (Savings, Checking, Credit)
- ✅ Balance tracking and credit limit management
- ✅ Account status monitoring (Active, Frozen, Closed)
- ✅ Search by account number or user ID

### 💸 **Transaction Processing**
- ✅ Multiple transaction types (Deposit, Withdrawal, Transfer, Payment)
- ✅ Real-time transaction processing
- ✅ Transaction history and status tracking
- ✅ Fee calculation and reference tracking

### 🎨 **Modern UI/UX**
- ✅ Material Design 3
- ✅ Gradient backgrounds and smooth animations
- ✅ Tab-based navigation
- ✅ Responsive design (Mobile, Tablet, Desktop)
- ✅ Real-time feedback messages
- ✅ Loading states and empty state handling

---

## 📦 Prerequisites

### **Required Software**

| Software | Version | Platform | Download Link |
|----------|---------|----------|---------------|
| **Flutter SDK** | ≥ 3.0.0 | All | [flutter.dev](https://flutter.dev/docs/get-started/install) |
| **Dart SDK** | ≥ 3.0.0 | All | Included with Flutter |
| **Java JDK** | ≥ 17 | All | [Oracle JDK](https://www.oracle.com/java/technologies/downloads/) |
| **Maven** | ≥ 3.8 | All | [maven.apache.org](https://maven.apache.org/download.cgi) |
| **Git** | Latest | All | [git-scm.com](https://git-scm.com/downloads) |
| **Android Studio** | Latest | Android | [developer.android.com](https://developer.android.com/studio) |
| **Xcode** | Latest | iOS/macOS | [Mac App Store](https://apps.apple.com/us/app/xcode/id497799835) |

### **Platform-Specific Requirements**

#### **Windows Desktop**
```bash
# Visual Studio 2022 with C++ development tools
# Download from: https://visualstudio.microsoft.com/downloads/
```

#### **macOS Desktop**
```bash
# Xcode command line tools
xcode-select --install
```

#### **Linux Desktop**
```bash
# Required packages (Ubuntu/Debian)
sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev
```

#### **Android**
- Android SDK (API level 21+)
- Android emulator or physical device
- USB debugging enabled

#### **iOS**
- macOS with Xcode installed
- iOS Simulator or physical device
- Apple Developer account (for physical devices)

---

## 📁 Project Structure

```
mobile-banking-flutter/
│
├── backend/                              # Spring Boot Backend
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/banking/
│   │   │   │   ├── controller/          # REST Controllers
│   │   │   │   ├── model/               # Entity Models
│   │   │   │   ├── repository/          # JPA Repositories
│   │   │   │   ├── service/             # Business Logic
│   │   │   │   └── MobileBankingApplication.java
│   │   │   └── resources/
│   │   │       └── application.properties
│   │   └── test/                        # Backend Tests
│   ├── pom.xml
│   └── README.md
│
├── frontend/                             # Flutter Frontend
│   ├── lib/
│   │   ├── main.dart                    # Main entry point
│   │   ├── models/
│   │   │   ├── user.dart
│   │   │   ├── account.dart
│   │   │   └── transaction.dart
│   │   ├── services/
│   │   │   └── api_service.dart
│   │   ├── screens/
│   │   │   ├── login_page.dart
│   │   │   ├── dashboard_page.dart
│   │   │   ├── users_tab.dart
│   │   │   ├── accounts_tab.dart
│   │   │   └── transactions_tab.dart
│   │   └── widgets/
│   ├── test/
│   │   └── widget_test.dart             # 73+ Comprehensive Tests
│   ├── web/
│   ├── windows/                         # Windows Desktop
│   ├── macos/                           # macOS Desktop
│   ├── linux/                           # Linux Desktop
│   ├── android/                         # Android App
│   ├── ios/                             # iOS App
│   ├── pubspec.yaml
│   └── README.md
│
└── README.md                             # This file
```

---

## 🚀 Installation

### **1. Clone the Repository**

```bash
git clone https://github.com/yourusername/mobile-banking-flutter.git
cd mobile-banking-flutter
```

### **2. Verify Flutter Installation**

```bash
flutter doctor -v
```

**Expected Output:**
```
✓ Flutter (Channel stable, 3.x.x)
✓ Android toolchain - develop for Android devices
✓ Xcode - develop for iOS and macOS
✓ Chrome - develop for the web
✓ Android Studio
✓ VS Code
✓ Connected device
```

**Fix any issues shown by `flutter doctor` before proceeding.**

### **3. Enable Flutter Platforms**

```bash
# Enable web support
flutter config --enable-web

# Enable desktop support
flutter config --enable-windows-desktop  # Windows
flutter config --enable-macos-desktop    # macOS
flutter config --enable-linux-desktop    # Linux
```

### **4. Verify Available Devices**

```bash
flutter devices
```

**Expected Output:**
```
4 connected devices:

Windows (desktop) • windows • windows-x64    • Microsoft Windows
Chrome (web)      • chrome  • web-javascript • Google Chrome
Web Server (web)  • web-server • web-javascript • Flutter Tools
Edge (web)        • edge    • web-javascript • Microsoft Edge
```

---

## 🏃 Running the Application

## **Step 1: Start Backend Server**

### **Option A: Using Maven (Recommended)**

```bash
# Navigate to backend directory
cd backend

# Clean and install dependencies
mvn clean install

# Run the Spring Boot application
mvn spring-boot:run
```

### **Option B: Using Java JAR**

```bash
cd backend

# Build the JAR
mvn clean package

# Run the JAR
java -jar target/mobile-banking-api-1.0.0.jar
```

### **Option C: Using IDE**

1. Open `backend` folder in IntelliJ IDEA or Eclipse
2. Locate `MobileBankingApplication.java`
3. Right-click and select "Run"

### **✅ Verify Backend is Running**

Open browser and navigate to:
```
http://localhost:8083/api/users
```

You should see an empty JSON array `[]` or error page (which confirms the API is running).

**Backend logs should show:**
```
Started MobileBankingApplication in X.XXX seconds
Tomcat started on port(s): 8083 (http)
```

---

## **Step 2: Run Flutter Web (Recommended)**

**Open a NEW terminal window** (keep backend running).

### **Navigate to Frontend**

```bash
cd frontend
# Or from project root:
cd mobile-banking-flutter/frontend
```

### **Install Dependencies**

```bash
flutter pub get
```

### **🌐 Run Web Application (Web Server Mode)**

```bash
flutter run -d web-server --web-port=8080
```

**Output:**
```
Launching lib/main.dart on Web Server in debug mode...
Building application for the web...                                                     
Serving web application at http://localhost:8080
```

### **✅ Access the Application**

Open your browser and navigate to:
```
http://localhost:8080
```

**Login Credentials:**
- **Username:** `shady1997`
- **Password:** `shady1997`

### **🔥 Hot Reload Commands**

While the app is running in terminal:
- Press `r` - Hot reload
- Press `R` - Hot restart
- Press `h` - Help
- Press `q` - Quit

---

## **Step 3: Run on Desktop (Optional)**

### **Windows Desktop**

```bash
# From frontend directory
flutter run -d windows
```

### **macOS Desktop**

```bash
# From frontend directory
flutter run -d macos
```

### **Linux Desktop**

```bash
# From frontend directory
flutter run -d linux
```

### **Build Desktop Release**

```bash
# Windows
flutter build windows --release

# macOS
flutter build macos --release

# Linux
flutter build linux --release
```

**📦 Find executables in:**
- Windows: `build/windows/runner/Release/mobile_banking_flutter.exe`
- macOS: `build/macos/Build/Products/Release/mobile_banking_flutter.app`
- Linux: `build/linux/x64/release/bundle/mobile_banking_flutter`

---

## **Step 4: Run on Android (Optional)**

### **Prerequisites**

1. **Android Studio installed**
2. **Android emulator running** OR **physical device connected**
3. **USB debugging enabled** (for physical devices)

### **Check Connected Devices**

```bash
flutter devices
```

You should see Android device listed:
```
Android SDK built for x86 (mobile) • emulator-5554 • android-x86 • Android 11 (API 30)
```

### **Run on Android**

```bash
# From frontend directory
flutter run -d <device-id>

# Or simply (if only one device connected)
flutter run
```

### **Build Android APK**

```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# Split APKs per ABI (smaller size)
flutter build apk --split-per-abi --release
```

**📦 Find APK in:**
```
build/app/outputs/flutter-apk/app-release.apk
```

### **Install APK on Device**

```bash
flutter install
```

---

## **Step 5: Run on iOS (Optional)**

### **Prerequisites**

1. **macOS with Xcode installed**
2. **iOS Simulator running** OR **physical device connected**
3. **Apple Developer account** (for physical devices)

### **Setup iOS**

```bash
# Open iOS project in Xcode
cd frontend/ios
open Runner.xcworkspace

# Or install CocoaPods dependencies
cd frontend/ios
pod install
cd ..
```

### **Run on iOS Simulator**

```bash
# List available simulators
flutter emulators

# Launch a simulator
flutter emulators --launch apple_ios_simulator

# Run app
flutter run -d <simulator-id>
```

### **Run on Physical iOS Device**

```bash
# Connect device via USB
# Trust computer on device

# Check device is detected
flutter devices

# Run app
flutter run -d <device-id>
```

### **Build iOS App**

```bash
# Build for simulator
flutter build ios --debug --simulator

# Build for device (requires Apple Developer account)
flutter build ios --release

# Build IPA for distribution
flutter build ipa --release
```

**📦 Find IPA in:**
```
build/ios/ipa/mobile_banking_flutter.ipa
```

---

## 🧪 Testing

### **Run All Tests**

```bash
cd frontend

# Run all tests
flutter test
```

**Expected Output:**
```
00:05 +73: All tests passed!
```

### **Run Specific Test File**

```bash
flutter test test/widget_test.dart
```

### **Run Specific Test Group**

```bash
# Run only login tests
flutter test --name "Login"

# Run only UI tests
flutter test --name "UI Tests"

# Run only functionality tests
flutter test --name "Functionality"
```

### **Run Tests with Verbose Output**

```bash
flutter test --reporter=expanded
```

### **Generate Test Coverage**

#### **Step 1: Run Tests with Coverage**

```bash
flutter test --coverage
```

#### **Step 2: View Coverage Report**

**On macOS/Linux:**
```bash
# Install lcov (if not installed)
# macOS:
brew install lcov

# Ubuntu/Debian:
sudo apt-get install lcov

# Generate HTML report
genhtml coverage/lcov.info -o coverage/html

# Open report
open coverage/html/index.html        # macOS
xdg-open coverage/html/index.html    # Linux
```

**On Windows:**
```bash
# Install Perl and lcov from http://strawberryperl.com/
# Or use WSL (Windows Subsystem for Linux)

# Generate HTML report
perl C:\ProgramData\chocolatey\lib\lcov\tools\bin\genhtml coverage/lcov.info -o coverage/html

# Open report
start coverage/html/index.html
```

#### **Step 3: View Coverage in VS Code**

Install **Coverage Gutters** extension:
1. Open VS Code
2. Go to Extensions (Ctrl+Shift+X)
3. Search for "Coverage Gutters"
4. Install and click "Watch" button

### **Coverage Summary**

```bash
# View coverage summary in terminal
flutter test --coverage
lcov --summary coverage/lcov.info
```

**Expected Output:**
```
Reading tracefile coverage/lcov.info
Summary coverage rate:
  lines......: 85.7% (600 of 700 lines)
  functions..: 90.2% (120 of 133 functions)
  branches...: 78.5% (200 of 255 branches)
```

### **Test Structure**

The test suite includes **73 comprehensive tests** covering:

| Test Category | Tests | Description |
|--------------|-------|-------------|
| Login Page UI | 4 | UI elements, styling, input fields |
| Login Functionality | 5 | Authentication, validation, error handling |
| Dashboard UI | 3 | Layout, components, navigation |
| Tab Navigation | 4 | Tab switching, state management |
| Users Tab UI | 3 | Forms, tables, search functionality |
| Accounts Tab UI | 3 | Account management interface |
| Transactions Tab UI | 3 | Transaction processing interface |
| Logout Functionality | 2 | Session management |
| Responsive Design | 3 | Mobile, tablet, desktop layouts |
| Form Validation | 3 | Input validation, error states |
| Icon Tests | 2 | Icon display and semantics |
| Data Table Tests | 3 | Table rendering, scrolling |
| Theme Tests | 3 | Material Design, colors |
| Accessibility | 3 | Semantics, labels, navigation |
| Edge Cases | 3 | Special characters, empty states |
| Button Functionality | 2 | Button interactions |
| Text Input | 3 | Text field inputs, validation |
| Dropdown Tests | 2 | Dropdown selections |
| Empty States | 3 | No data scenarios |
| Navigation State | 2 | State persistence |
| Widget Hierarchy | 2 | Structure validation |
| Scrolling | 1 | Scrollable content |
| Loading States | 1 | Loading indicators |
| Material Design | 2 | Material components |
| State Management | 2 | State handling |
| Performance | 2 | Render times, optimization |
| Integration | 2 | End-to-end flows |
| Final Verification | 2 | Overall validation |

### **Backend Tests**

```bash
cd backend

# Run all backend tests
mvn test

# Run with coverage
mvn clean test jacoco:report

# View coverage report
open target/site/jacoco/index.html  # macOS
xdg-open target/site/jacoco/index.html  # Linux
start target/site/jacoco/index.html  # Windows
```

---

## 🐛 Troubleshooting

### **Backend Issues**

#### **Issue 1: Port 8083 Already in Use**

**Error:** `Port 8083 is already in use`

**Solution:**
```bash
# Windows
netstat -ano | findstr :8083
taskkill /PID <PID> /F

# macOS/Linux
lsof -ti:8083 | xargs kill -9

# Or change port in application.properties
server.port=8084
```

#### **Issue 2: Database Connection Error**

**Error:** `Unable to connect to database`

**Solution:**
Edit `backend/src/main/resources/application.properties`:
```properties
# Use H2 in-memory database (no setup required)
spring.datasource.url=jdbc:h2:mem:bankingdb
spring.datasource.driverClassName=org.h2.Driver
spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
spring.jpa.hibernate.ddl-auto=create-drop
```

### **Frontend Issues**

#### **Issue 3: Flutter Web Server Port Busy**

**Error:** `Port 8080 is already in use`

**Solution:**
```bash
# Use different port
flutter run -d web-server --web-port=3000
```

#### **Issue 4: CORS Error**

**Error:** `Access to fetch has been blocked by CORS policy`

**Solution:**
Add CORS configuration to backend:

```java
// backend/src/main/java/com/banking/config/CorsConfig.java
@Configuration
public class CorsConfig {
  @Bean
  public WebMvcConfigurer corsConfigurer() {
    return new WebMvcConfigurer() {
      @Override
      public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/api/**")
                .allowedOrigins("http://localhost:8080", "http://localhost:3000")
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
                .allowedHeaders("*")
                .allowCredentials(true);
      }
    };
  }
}
```

#### **Issue 5: Flutter Doctor Issues**

**Error:** Various flutter doctor warnings

**Solution:**
```bash
# Accept Android licenses
flutter doctor --android-licenses

# Install missing dependencies
# Follow instructions from flutter doctor output
flutter doctor -v
```

#### **Issue 6: Desktop Build Fails**

**Windows:**
```bash
# Install Visual Studio 2022 with C++ tools
# Download from: https://visualstudio.microsoft.com/downloads/
```

**macOS:**
```bash
# Install Xcode command line tools
xcode-select --install
```

**Linux:**
```bash
# Install required packages
sudo apt-get update
sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev
```

#### **Issue 7: Android Build Fails**

**Error:** `Gradle build failed`

**Solution:**
```bash
cd frontend/android
./gradlew clean

cd ..
flutter clean
flutter pub get
flutter build apk
```

#### **Issue 8: iOS Build Fails**

**Error:** `Pod install failed`

**Solution:**
```bash
cd frontend/ios
pod deintegrate
pod install
cd ..
flutter clean
flutter pub get
flutter build ios
```

### **Test Issues**

#### **Issue 9: Tests Fail with Overflow Errors**

**Solution:**
Tests use large screen size by default. Overflow errors are expected on small screens. Tests handle this with `setLargeScreen()` helper.

#### **Issue 10: Coverage Report Not Generated**

**Solution:**
```bash
# Ensure lcov is installed
brew install lcov  # macOS
sudo apt-get install lcov  # Linux

# Run tests with coverage flag
flutter test --coverage

# Generate report
genhtml coverage/lcov.info -o coverage/html
```

---

## 📚 API Documentation

### **Base URL**
```
http://localhost:8083/api
```

### **Users Endpoints**

| Method | Endpoint | Description | Request Body |
|--------|----------|-------------|--------------|
| POST | `/users` | Create user | `{username, email, password, fullName, phoneNumber}` |
| GET | `/users` | Get all users | - |
| GET | `/users/{id}` | Get user by ID | - |
| GET | `/users/username/{username}` | Get by username | - |
| PUT | `/users/{id}` | Update user | `{username, email, fullName, phoneNumber}` |
| DELETE | `/users/{id}` | Delete user | - |

### **Accounts Endpoints**

| Method | Endpoint | Description | Request Body |
|--------|----------|-------------|--------------|
| POST | `/accounts` | Create account | `{accountNumber, accountType, balance, userId, creditLimit}` |
| GET | `/accounts` | Get all accounts | - |
| GET | `/accounts/{id}` | Get account by ID | - |
| GET | `/accounts/number/{accountNumber}` | Get by number | - |
| GET | `/accounts/user/{userId}` | Get by user ID | - |
| DELETE | `/accounts/{id}` | Delete account | - |

### **Transactions Endpoints**

| Method | Endpoint | Description | Request Body |
|--------|----------|-------------|--------------|
| POST | `/transactions` | Create transaction | `{transactionReference, fromAccountId, toAccountId, transactionType, amount, description, fee}` |
| GET | `/transactions` | Get all transactions | - |
| GET | `/transactions/{id}` | Get by ID | - |
| GET | `/transactions/reference/{reference}` | Get by reference | - |
| GET | `/transactions/account/{accountId}` | Get by account | - |

### **Example API Calls**

```bash
# Create User
curl -X POST http://localhost:8083/api/users \
  -H "Content-Type: application/json" \
  -d '{
    "username": "john_doe",
    "email": "john@example.com",
    "password": "password123",
    "fullName": "John Doe",
    "phoneNumber": "+201234567890"
  }'

# Get All Users
curl http://localhost:8083/api/users

# Create Account
curl -X POST http://localhost:8083/api/accounts \
  -H "Content-Type: application/json" \
  -d '{
    "accountNumber": "ACC001",
    "accountType": "SAVINGS",
    "balance": 1000.00,
    "userId": 1,
    "creditLimit": 0
  }'

# Create Transaction
curl -X POST http://localhost:8083/api/transactions \
  -H "Content-Type: application/json" \
  -d '{
    "transactionReference": "TXN001",
    "fromAccountId": 1,
    "toAccountId": null,
    "transactionType": "DEPOSIT",
    "amount": 500.00,
    "description": "Initial deposit",
    "fee": 0
  }'
```

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### **Development Guidelines**

- Write tests for new features
- Maintain test coverage above 80%
- Follow Flutter style guide
- Document public APIs
- Update README for new features

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**Shady Ahmed**

- GitHub: [@shadyahmed](https://github.com/shadyahmed)
- Email: shady@example.com

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Spring Boot for robust backend framework
- Material Design for UI/UX guidelines
- All contributors and testers

---

## 📞 Support

For support, email shady@example.com or open an issue on GitHub.

---

## 🚀 Quick Start Summary

```bash
# 1. Start Backend
cd backend
mvn spring-boot:run

# 2. In new terminal - Run Flutter Web
cd frontend
flutter pub get
flutter run -d web-server --web-port=64421

# 3. Open browser
http://localhost:64421

# 4. Login
Username: shady1997
Password: shady1997

# 5. Run Tests
flutter test --coverage

# 6. View Coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

---

**🎉 Happy Coding! 🎉**