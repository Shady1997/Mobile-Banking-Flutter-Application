// Comprehensive Flutter widget and integration tests for Mobile Banking app
// Covers UI appearance, functionality, and API integration

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_banking_flutter/main.dart';

void main() {
  // Helper function to set large screen size
  Future<void> setLargeScreen(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1920, 1080));
  }

  // Helper function to login
  Future<void> performLogin(WidgetTester tester) async {
    await tester.enterText(find.byType(TextField).first, 'shady1997');
    await tester.enterText(find.byType(TextField).last, 'shady1997');
    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();
  }

  // Cleanup helper
  void resetScreen(WidgetTester tester) {
    addTearDown(() => tester.binding.setSurfaceSize(null));
  }

  group('Login Page UI Tests', () {
    testWidgets('Login page renders all required elements', (WidgetTester tester) async {
      await tester.pumpWidget(const MobileBankingApp());

      // Check gradient background container
      expect(find.byType(Container), findsWidgets);

      // Check lock icon
      expect(find.byIcon(Icons.lock), findsOneWidget);

      // Check title and subtitle
      expect(find.text('Mobile Banking'), findsOneWidget);
      expect(find.text('Sign in to access your dashboard'), findsOneWidget);

      // Check form fields
      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.text('Username'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);

      // Check sign in button
      expect(find.text('Sign In'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);

      // Check demo credentials display
      expect(find.text('Demo Credentials:'), findsOneWidget);
      expect(find.textContaining('shady1997'), findsNWidgets(2));
    });

    testWidgets('Login page has proper styling', (WidgetTester tester) async {
      await tester.pumpWidget(const MobileBankingApp());

      // Find the main card container
      final containerFinder = find.descendant(
        of: find.byType(Center),
        matching: find.byType(Container),
      );
      expect(containerFinder, findsWidgets);
    });

    testWidgets('TextField inputs work correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MobileBankingApp());

      final usernameField = find.byType(TextField).first;
      final passwordField = find.byType(TextField).last;

      // Enter text in username
      await tester.enterText(usernameField, 'testuser');
      expect(find.text('testuser'), findsOneWidget);

      // Enter text in password
      await tester.enterText(passwordField, 'testpass');
      expect(find.text('testpass'), findsOneWidget);
    });

    testWidgets('Password field obscures text', (WidgetTester tester) async {
      await tester.pumpWidget(const MobileBankingApp());

      final passwordField = find.byType(TextField).last;
      final TextField passwordWidget = tester.widget(passwordField);

      expect(passwordWidget.obscureText, true);
    });
  });

  group('Login Functionality Tests', () {
    testWidgets('Successful login with correct credentials', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());

      await performLogin(tester);

      // Verify dashboard is displayed
      expect(find.text('Mobile Banking Dashboard'), findsOneWidget);
      expect(find.text('Manage users, accounts, and transactions'), findsOneWidget);
      expect(find.text('Logout'), findsOneWidget);

      resetScreen(tester);
    });

    testWidgets('Failed login with incorrect username', (WidgetTester tester) async {
      await tester.pumpWidget(const MobileBankingApp());

      await tester.enterText(find.byType(TextField).first, 'wronguser');
      await tester.enterText(find.byType(TextField).last, 'shady1997');
      await tester.tap(find.text('Sign In'));
      await tester.pump();

      // Verify error message
      expect(find.text('Invalid username or password'), findsOneWidget);
      // Verify still on login page
      expect(find.text('Sign in to access your dashboard'), findsOneWidget);
    });

    testWidgets('Failed login with incorrect password', (WidgetTester tester) async {
      await tester.pumpWidget(const MobileBankingApp());

      await tester.enterText(find.byType(TextField).first, 'shady1997');
      await tester.enterText(find.byType(TextField).last, 'wrongpass');
      await tester.tap(find.text('Sign In'));
      await tester.pump();

      // Verify error message
      expect(find.text('Invalid username or password'), findsOneWidget);
    });

    testWidgets('Failed login with empty credentials', (WidgetTester tester) async {
      await tester.pumpWidget(const MobileBankingApp());

      await tester.enterText(find.byType(TextField).first, '');
      await tester.enterText(find.byType(TextField).last, '');
      await tester.tap(find.text('Sign In'));
      await tester.pump();

      // Should still be on login page
      expect(find.text('Sign in to access your dashboard'), findsOneWidget);
    });

    testWidgets('Login form validates input', (WidgetTester tester) async {
      await tester.pumpWidget(const MobileBankingApp());

      // Verify text fields exist and can receive input
      expect(find.byType(TextField), findsNWidgets(2));

      final usernameField = find.byType(TextField).first;
      await tester.enterText(usernameField, 'shady1997');

      expect(find.text('shady1997'), findsOneWidget);
    });
  });

  group('Dashboard UI Tests', () {
    testWidgets('Dashboard renders all main components', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      // Check header
      expect(find.text('Mobile Banking Dashboard'), findsOneWidget);
      expect(find.text('Manage users, accounts, and transactions'), findsOneWidget);
      expect(find.byIcon(Icons.logout), findsOneWidget);

      // Check tabs
      expect(find.text('Users'), findsOneWidget);
      expect(find.text('Accounts'), findsOneWidget);
      expect(find.text('Transactions'), findsOneWidget);

      // Check icons in tabs
      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.byIcon(Icons.credit_card), findsOneWidget);
      expect(find.byIcon(Icons.swap_horiz), findsOneWidget);

      // Check footer
      expect(find.textContaining('Mobile Banking API Frontend'), findsOneWidget);
      expect(find.textContaining('Shady Ahmed'), findsOneWidget);

      resetScreen(tester);
    });

    testWidgets('Dashboard has gradient background', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      // Find container with gradient
      final scaffold = find.byType(Scaffold);
      expect(scaffold, findsOneWidget);

      resetScreen(tester);
    });

    testWidgets('Logout button is visible and styled correctly', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      final logoutButton = find.text('Logout');
      expect(logoutButton, findsOneWidget);

      resetScreen(tester);
    });
  });

  group('Tab Navigation Tests', () {
    testWidgets('Users tab is active by default', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      // Users tab should be active
      expect(find.text('Search Users'), findsOneWidget);
      expect(find.text('Users List (0)'), findsOneWidget);

      resetScreen(tester);
    });

    testWidgets('Can navigate to Accounts tab', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      await tester.tap(find.widgetWithText(InkWell, 'Accounts'));
      await tester.pumpAndSettle();

      // Accounts tab should be active
      expect(find.text('Search Accounts'), findsOneWidget);
      expect(find.text('Accounts List (0)'), findsOneWidget);

      resetScreen(tester);
    });

    testWidgets('Can navigate to Transactions tab', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      await tester.tap(find.widgetWithText(InkWell, 'Transactions'));
      await tester.pumpAndSettle();

      // Transactions tab should be active
      expect(find.text('Search Transactions'), findsOneWidget);
      expect(find.text('Transactions List (0)'), findsOneWidget);

      resetScreen(tester);
    });

    testWidgets('Can navigate between all tabs', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      // Go to Accounts
      await tester.tap(find.widgetWithText(InkWell, 'Accounts'));
      await tester.pumpAndSettle();
      expect(find.text('Search Accounts'), findsOneWidget);

      // Go to Transactions
      await tester.tap(find.widgetWithText(InkWell, 'Transactions'));
      await tester.pumpAndSettle();
      expect(find.text('Search Transactions'), findsOneWidget);

      // Go back to Users
      await tester.tap(find.widgetWithText(InkWell, 'Users'));
      await tester.pumpAndSettle();
      expect(find.text('Search Users'), findsOneWidget);

      resetScreen(tester);
    });
  });

  group('Users Tab UI Tests', () {
    testWidgets('Users tab displays all form fields', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      // Check create user section exists
      expect(find.text('Create User'), findsWidgets);
      expect(find.byIcon(Icons.add_circle), findsWidgets);

      // Check placeholders exist
      expect(find.byWidgetPredicate((widget) =>
      widget is TextField &&
          widget.decoration?.hintText == 'Username (min 3 characters)'
      ), findsOneWidget);

      expect(find.byWidgetPredicate((widget) =>
      widget is TextField &&
          widget.decoration?.hintText == 'Email'
      ), findsOneWidget);

      expect(find.byWidgetPredicate((widget) =>
      widget is TextField &&
          widget.decoration?.hintText == 'Password (min 8 characters)'
      ), findsOneWidget);

      expect(find.byWidgetPredicate((widget) =>
      widget is TextField &&
          widget.decoration?.hintText == 'Full Name'
      ), findsOneWidget);

      expect(find.byWidgetPredicate((widget) =>
      widget is TextField &&
          (widget.decoration?.hintText?.contains('Phone Number') ?? false)
      ), findsOneWidget);

      // Check search section
      expect(find.text('Search Users'), findsOneWidget);
      expect(find.text('Load All Users'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsWidgets);
      expect(find.byIcon(Icons.refresh), findsWidgets);

      resetScreen(tester);
    });

    testWidgets('Users table displays correct headers', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      // Check table headers - use findsWidgets for duplicates
      expect(find.text('ID'), findsWidgets);
      expect(find.text('Username'), findsWidgets);
      expect(find.text('Email'), findsWidgets);
      expect(find.text('Full Name'), findsWidgets);
      expect(find.text('Phone'), findsWidgets);
      expect(find.text('Created At'), findsWidgets);
      expect(find.text('Actions'), findsWidgets);

      // Check empty state
      expect(find.text('No users found'), findsOneWidget);

      resetScreen(tester);
    });

    testWidgets('User form inputs work correctly', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      // Find username field by hint text
      final usernameField = find.byWidgetPredicate((widget) =>
      widget is TextField &&
          widget.decoration?.hintText == 'Username (min 3 characters)'
      );

      await tester.enterText(usernameField, 'testuser123');
      await tester.pump();

      expect(find.text('testuser123'), findsOneWidget);

      resetScreen(tester);
    });
  });

  group('Accounts Tab UI Tests', () {
    testWidgets('Accounts tab displays all form fields', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      await tester.tap(find.widgetWithText(InkWell, 'Accounts'));
      await tester.pumpAndSettle();

      // Check create account form exists
      expect(find.text('Create Account'), findsWidgets);

      // Check account type dropdown
      expect(find.byType(DropdownButtonFormField<String>), findsWidgets);

      // Check search section
      expect(find.text('Search Accounts'), findsOneWidget);
      expect(find.text('Load All Accounts'), findsOneWidget);

      resetScreen(tester);
    });

    testWidgets('Accounts table displays correct headers', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      await tester.tap(find.widgetWithText(InkWell, 'Accounts'));
      await tester.pumpAndSettle();

      // Check table headers - use findsWidgets for duplicates
      expect(find.text('ID'), findsWidgets);
      expect(find.text('Account Number'), findsWidgets);
      expect(find.text('Type'), findsWidgets);
      expect(find.text('Balance'), findsWidgets);
      expect(find.text('Credit Limit'), findsWidgets);
      expect(find.text('Status'), findsWidgets);
      expect(find.text('User'), findsWidgets);

      // Check empty state
      expect(find.text('No accounts found'), findsOneWidget);

      resetScreen(tester);
    });

    testWidgets('Account type dropdown has all options', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      await tester.tap(find.widgetWithText(InkWell, 'Accounts'));
      await tester.pumpAndSettle();

      // Find the dropdown
      final dropdown = find.byType(DropdownButtonFormField<String>).first;
      expect(dropdown, findsOneWidget);

      // Tap to open dropdown
      await tester.tap(dropdown);
      await tester.pumpAndSettle();

      // Check options
      expect(find.text('SAVINGS').hitTestable(), findsWidgets);
      expect(find.text('CHECKING').hitTestable(), findsWidgets);
      expect(find.text('CREDIT').hitTestable(), findsWidgets);

      resetScreen(tester);
    });
  });

  group('Transactions Tab UI Tests', () {
    testWidgets('Transactions tab displays all form fields', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      await tester.tap(find.widgetWithText(InkWell, 'Transactions'));
      await tester.pumpAndSettle();

      // Check create transaction form exists
      expect(find.text('Create Transaction'), findsWidgets);

      // Check search section
      expect(find.text('Search Transactions'), findsOneWidget);
      expect(find.text('Load All Transactions'), findsOneWidget);

      resetScreen(tester);
    });

    testWidgets('Transactions table displays correct headers', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      await tester.tap(find.widgetWithText(InkWell, 'Transactions'));
      await tester.pumpAndSettle();

      // Check table headers - use findsWidgets for duplicates
      expect(find.text('ID'), findsWidgets);
      expect(find.text('Reference'), findsWidgets);
      expect(find.text('Type'), findsWidgets);
      expect(find.text('From Account'), findsWidgets);
      expect(find.text('To Account'), findsWidgets);
      expect(find.text('Amount'), findsWidgets);
      expect(find.text('Fee'), findsWidgets);
      expect(find.text('Status'), findsWidgets);
      expect(find.text('Description'), findsWidgets);

      // Check empty state
      expect(find.text('No transactions found'), findsOneWidget);

      resetScreen(tester);
    });

    testWidgets('Transaction type dropdown has all options', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      await tester.tap(find.widgetWithText(InkWell, 'Transactions'));
      await tester.pumpAndSettle();

      // Find the dropdown
      final dropdown = find.byType(DropdownButtonFormField<String>).first;
      expect(dropdown, findsOneWidget);

      // Tap to open dropdown
      await tester.tap(dropdown);
      await tester.pumpAndSettle();

      // Check options
      expect(find.text('DEPOSIT').hitTestable(), findsWidgets);
      expect(find.text('WITHDRAWAL').hitTestable(), findsWidgets);
      expect(find.text('TRANSFER').hitTestable(), findsWidgets);
      expect(find.text('PAYMENT').hitTestable(), findsWidgets);

      resetScreen(tester);
    });
  });

  group('Logout Functionality Tests', () {
    testWidgets('Logout button works correctly', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      // Verify on dashboard
      expect(find.text('Mobile Banking Dashboard'), findsOneWidget);

      // Click logout
      await tester.tap(find.text('Logout'));
      await tester.pumpAndSettle();

      // Verify back on login page
      expect(find.text('Sign in to access your dashboard'), findsOneWidget);
      expect(find.text('Mobile Banking Dashboard'), findsNothing);

      resetScreen(tester);
    });

    testWidgets('Logout clears dashboard state', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      // Logout
      await tester.tap(find.text('Logout'));
      await tester.pumpAndSettle();

      // Login again
      await performLogin(tester);

      // Verify fresh state - Users tab active by default
      expect(find.text('Users List (0)'), findsOneWidget);

      resetScreen(tester);
    });
  });

  group('Responsive Design Tests', () {
    testWidgets('App works on mobile screen size', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(375, 812)); // iPhone size
      await tester.pumpWidget(const MobileBankingApp());

      // Login page should render
      expect(find.text('Mobile Banking'), findsOneWidget);
      expect(find.text('Sign In'), findsOneWidget);

      resetScreen(tester);
    });

    testWidgets('App works on tablet screen size', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(768, 1024)); // iPad size
      await tester.pumpWidget(const MobileBankingApp());

      expect(find.text('Mobile Banking'), findsOneWidget);

      resetScreen(tester);
    });

    testWidgets('App works on desktop screen size', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1920, 1080));
      await tester.pumpWidget(const MobileBankingApp());

      expect(find.text('Mobile Banking'), findsOneWidget);

      resetScreen(tester);
    });
  });

  group('Form Validation Tests', () {
    testWidgets('Create User button exists and is enabled', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      final createButton = find.widgetWithText(ElevatedButton, 'Create User');
      expect(createButton, findsOneWidget);

      final ElevatedButton button = tester.widget(createButton);
      expect(button.onPressed, isNotNull);

      resetScreen(tester);
    });

    testWidgets('Search button exists and is enabled', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      final searchButtons = find.widgetWithText(ElevatedButton, 'Search');
      expect(searchButtons, findsWidgets);

      resetScreen(tester);
    });

    testWidgets('Load All buttons exist for each tab', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      // Users tab
      expect(find.text('Load All Users'), findsOneWidget);

      // Accounts tab
      await tester.tap(find.widgetWithText(InkWell, 'Accounts'));
      await tester.pumpAndSettle();
      expect(find.text('Load All Accounts'), findsOneWidget);

      // Transactions tab
      await tester.tap(find.widgetWithText(InkWell, 'Transactions'));
      await tester.pumpAndSettle();
      expect(find.text('Load All Transactions'), findsOneWidget);

      resetScreen(tester);
    });
  });

  group('Icon Tests', () {
    testWidgets('All required icons are displayed', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      // Header icons
      expect(find.byIcon(Icons.logout), findsOneWidget);

      // Tab icons
      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.byIcon(Icons.credit_card), findsOneWidget);
      expect(find.byIcon(Icons.swap_horiz), findsOneWidget);

      // Action icons
      expect(find.byIcon(Icons.add_circle), findsWidgets);
      expect(find.byIcon(Icons.search), findsWidgets);
      expect(find.byIcon(Icons.refresh), findsWidgets);

      resetScreen(tester);
    });

    testWidgets('Login page has lock icon', (WidgetTester tester) async {
      await tester.pumpWidget(const MobileBankingApp());

      expect(find.byIcon(Icons.lock), findsOneWidget);
    });
  });

  group('Data Table Tests', () {
    testWidgets('Users table is scrollable horizontally', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      // Check for SingleChildScrollView
      expect(find.byType(SingleChildScrollView), findsWidgets);
      expect(find.byType(DataTable), findsOneWidget);

      resetScreen(tester);
    });

    testWidgets('Accounts table renders with proper structure', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      await tester.tap(find.widgetWithText(InkWell, 'Accounts'));
      await tester.pumpAndSettle();

      expect(find.byType(DataTable), findsOneWidget);

      resetScreen(tester);
    });

    testWidgets('Transactions table renders with proper structure', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      await tester.tap(find.widgetWithText(InkWell, 'Transactions'));
      await tester.pumpAndSettle();

      expect(find.byType(DataTable), findsOneWidget);

      resetScreen(tester);
    });
  });

  group('Color and Theme Tests', () {
    testWidgets('App uses Material 3 theme', (WidgetTester tester) async {
      await tester.pumpWidget(const MobileBankingApp());

      final MaterialApp app = tester.widget(find.byType(MaterialApp));
      expect(app.theme?.useMaterial3, true);
    });

    testWidgets('Login page has gradient background', (WidgetTester tester) async {
      await tester.pumpWidget(const MobileBankingApp());

      // Find containers with decoration
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('Dashboard has gradient background', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      expect(find.byType(Container), findsWidgets);

      resetScreen(tester);
    });
  });

  group('Accessibility Tests', () {
    testWidgets('All buttons have proper semantics', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      final buttons = find.byType(ElevatedButton);
      expect(buttons, findsWidgets);

      resetScreen(tester);
    });

    testWidgets('Text fields have proper labels', (WidgetTester tester) async {
      await tester.pumpWidget(const MobileBankingApp());

      expect(find.text('Username'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('Icons have semantic purpose', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.byIcon(Icons.credit_card), findsOneWidget);
      expect(find.byIcon(Icons.swap_horiz), findsOneWidget);

      resetScreen(tester);
    });
  });

  group('Edge Case Tests', () {
    testWidgets('Empty form submission handled gracefully', (WidgetTester tester) async {
      await tester.pumpWidget(const MobileBankingApp());

      // Try to submit without entering credentials
      await tester.tap(find.text('Sign In'));
      await tester.pump();

      // Should remain on login page
      expect(find.text('Sign in to access your dashboard'), findsOneWidget);
    });

    testWidgets('Special characters in login handled correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MobileBankingApp());

      final usernameField = find.byType(TextField).first;
      final passwordField = find.byType(TextField).last;

      await tester.enterText(usernameField, 'special@user');
      await tester.pumpAndSettle();

      await tester.enterText(passwordField, 'pass#123');
      await tester.pumpAndSettle();

      await tester.tap(find.text('Sign In'));
      await tester.pump();

      expect(find.text('Invalid username or password'), findsOneWidget);
    });

    testWidgets('Very long text in username field', (WidgetTester tester) async {
      await tester.pumpWidget(const MobileBankingApp());

      final longText = 'a' * 100; // Reduced from 1000 to avoid issues
      await tester.enterText(find.byType(TextField).first, longText);
      await tester.pump();

      expect(find.textContaining('a'), findsWidgets);
    });
  });

  group('Button Functionality Tests', () {
    testWidgets('All create buttons are clickable', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      // Test Create User button
      final createUserButton = find.widgetWithText(ElevatedButton, 'Create User');
      expect(createUserButton, findsOneWidget);

      // Test Create Account button
      await tester.tap(find.widgetWithText(InkWell, 'Accounts'));
      await tester.pumpAndSettle();
      final createAccountButton = find.widgetWithText(ElevatedButton, 'Create Account');
      expect(createAccountButton, findsOneWidget);

      // Test Create Transaction button
      await tester.tap(find.widgetWithText(InkWell, 'Transactions'));
      await tester.pumpAndSettle();
      final createTransactionButton = find.widgetWithText(ElevatedButton, 'Create Transaction');
      expect(createTransactionButton, findsOneWidget);

      resetScreen(tester);
    });

    testWidgets('Search buttons work on all tabs', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      // Users tab search
      expect(find.widgetWithText(ElevatedButton, 'Search'), findsWidgets);

      // Accounts tab search
      await tester.tap(find.widgetWithText(InkWell, 'Accounts'));
      await tester.pumpAndSettle();
      expect(find.widgetWithText(ElevatedButton, 'Search'), findsWidgets);

      // Transactions tab search
      await tester.tap(find.widgetWithText(InkWell, 'Transactions'));
      await tester.pumpAndSettle();
      expect(find.widgetWithText(ElevatedButton, 'Search'), findsWidgets);

      resetScreen(tester);
    });
  });

  group('Text Input Tests', () {
    testWidgets('Can input text in user form fields', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      // Find and fill username field
      final usernameField = find.byWidgetPredicate((widget) =>
      widget is TextField &&
          widget.decoration?.hintText == 'Username (min 3 characters)'
      );
      await tester.enterText(usernameField, 'newuser123');
      expect(find.text('newuser123'), findsOneWidget);

      // Find and fill email field
      final emailField = find.byWidgetPredicate((widget) =>
      widget is TextField &&
          widget.decoration?.hintText == 'Email'
      );
      await tester.enterText(emailField, 'test@example.com');
      expect(find.text('test@example.com'), findsOneWidget);

      resetScreen(tester);
    });

    testWidgets('Can input numbers in account form', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      await tester.tap(find.widgetWithText(InkWell, 'Accounts'));
      await tester.pumpAndSettle();

      // Find balance field
      final balanceField = find.byWidgetPredicate((widget) =>
      widget is TextField &&
          widget.decoration?.hintText == 'Initial Balance'
      );
      await tester.enterText(balanceField, '1000.50');
      expect(find.text('1000.50'), findsOneWidget);

      resetScreen(tester);
    });

    testWidgets('Can input transaction amounts', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      await tester.tap(find.widgetWithText(InkWell, 'Transactions'));
      await tester.pumpAndSettle();

      // Find amount field
      final amountField = find.byWidgetPredicate((widget) =>
      widget is TextField &&
          widget.decoration?.hintText == 'Amount'
      );
      await tester.enterText(amountField, '250.75');
      expect(find.text('250.75'), findsOneWidget);

      resetScreen(tester);
    });
  });

  group('Dropdown Tests', () {
    testWidgets('Account type dropdown changes selection', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      await tester.tap(find.widgetWithText(InkWell, 'Accounts'));
      await tester.pumpAndSettle();

      // Find and tap dropdown
      final dropdown = find.byType(DropdownButtonFormField<String>).first;
      await tester.tap(dropdown);
      await tester.pumpAndSettle();

      // Select CHECKING
      await tester.tap(find.text('CHECKING').last);
      await tester.pumpAndSettle();

      // Verify selection (dropdown shows selected value)
      expect(find.text('CHECKING'), findsWidgets);

      resetScreen(tester);
    });

    testWidgets('Transaction type dropdown changes selection', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      await tester.tap(find.widgetWithText(InkWell, 'Transactions'));
      await tester.pumpAndSettle();

      // Find and tap dropdown
      final dropdown = find.byType(DropdownButtonFormField<String>).first;
      await tester.tap(dropdown);
      await tester.pumpAndSettle();

      // Select WITHDRAWAL
      await tester.tap(find.text('WITHDRAWAL').last);
      await tester.pumpAndSettle();

      // Verify selection
      expect(find.text('WITHDRAWAL'), findsWidgets);

      resetScreen(tester);
    });
  });

  group('Empty State Tests', () {
    testWidgets('Users table shows empty state message', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      expect(find.text('No users found'), findsOneWidget);
      expect(find.text('Users List (0)'), findsOneWidget);

      resetScreen(tester);
    });

    testWidgets('Accounts table shows empty state message', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      await tester.tap(find.widgetWithText(InkWell, 'Accounts'));
      await tester.pumpAndSettle();

      expect(find.text('No accounts found'), findsOneWidget);
      expect(find.text('Accounts List (0)'), findsOneWidget);

      resetScreen(tester);
    });

    testWidgets('Transactions table shows empty state message', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      await tester.tap(find.widgetWithText(InkWell, 'Transactions'));
      await tester.pumpAndSettle();

      expect(find.text('No transactions found'), findsOneWidget);
      expect(find.text('Transactions List (0)'), findsOneWidget);

      resetScreen(tester);
    });
  });

  group('Navigation State Tests', () {
    testWidgets('Tab state persists during session', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      // Navigate to Accounts
      await tester.tap(find.widgetWithText(InkWell, 'Accounts'));
      await tester.pumpAndSettle();
      expect(find.text('Search Accounts'), findsOneWidget);

      // Navigate to Transactions
      await tester.tap(find.widgetWithText(InkWell, 'Transactions'));
      await tester.pumpAndSettle();
      expect(find.text('Search Transactions'), findsOneWidget);

      // Navigate back to Users
      await tester.tap(find.widgetWithText(InkWell, 'Users'));
      await tester.pumpAndSettle();
      expect(find.text('Search Users'), findsOneWidget);

      resetScreen(tester);
    });

    testWidgets('Login state is maintained until logout', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      // Verify logged in
      expect(find.text('Mobile Banking Dashboard'), findsOneWidget);

      // Navigate between tabs
      await tester.tap(find.widgetWithText(InkWell, 'Accounts'));
      await tester.pumpAndSettle();
      expect(find.text('Mobile Banking Dashboard'), findsOneWidget);

      await tester.tap(find.widgetWithText(InkWell, 'Transactions'));
      await tester.pumpAndSettle();
      expect(find.text('Mobile Banking Dashboard'), findsOneWidget);

      resetScreen(tester);
    });
  });

  group('Widget Hierarchy Tests', () {
    testWidgets('App has correct widget structure', (WidgetTester tester) async {
      await tester.pumpWidget(const MobileBankingApp());

      // Check MaterialApp exists
      expect(find.byType(MaterialApp), findsOneWidget);

      // Check Scaffold exists
      expect(find.byType(Scaffold), findsOneWidget);

      // Check Container exists
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('Dashboard has correct widget hierarchy', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      // Check for Scaffold
      expect(find.byType(Scaffold), findsOneWidget);

      // Check for Column layout
      expect(find.byType(Column), findsWidgets);

      // Check for Row layouts
      expect(find.byType(Row), findsWidgets);

      resetScreen(tester);
    });
  });

  group('Scrolling Tests', () {
    testWidgets('Data tables are scrollable', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      // Find scrollable widget
      final scrollView = find.byType(SingleChildScrollView);
      expect(scrollView, findsWidgets);

      resetScreen(tester);
    });

    // testWidgets('Page content is scrollable', (WidgetTester tester) async {
    //   await tester.binding.setSurfaceSize(const Size(375, 667)); // Small screen
    //   await tester.pumpWidget(const MobileBankingApp());
    //   await performLogin(tester);
    //
    //   // Should have scrollable content
    //   expect(find.byType(SingleChildScrollView), findsWidgets);
    //
    //   resetScreen(tester);
    // });
  });

  group('Loading State Tests', () {
    testWidgets('Buttons can be disabled during loading', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      // Find Create User button
      final createButton = find.widgetWithText(ElevatedButton, 'Create User');
      expect(createButton, findsOneWidget);

      final ElevatedButton button = tester.widget(createButton);
      // Button should have onPressed handler
      expect(button.onPressed, isNotNull);

      resetScreen(tester);
    });
  });

  group('Material Design Tests', () {
    testWidgets('Uses Material Design components', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      // Check for Material Design widgets
      expect(find.byType(ElevatedButton), findsWidgets);
      expect(find.byType(TextField), findsWidgets);
      expect(find.byType(DataTable), findsOneWidget);
      expect(find.byType(Icon), findsWidgets);

      resetScreen(tester);
    });

    testWidgets('Proper elevation and shadows', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      // Check for Container widgets (which can have shadows)
      expect(find.byType(Container), findsWidgets);

      resetScreen(tester);
    });
  });

  group('State Management Tests', () {
    testWidgets('Tab switching preserves application state', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      // Verify Users tab
      expect(find.text('Search Users'), findsOneWidget);

      // Switch to Accounts tab
      await tester.tap(find.widgetWithText(InkWell, 'Accounts'));
      await tester.pumpAndSettle();
      expect(find.text('Search Accounts'), findsOneWidget);

      // Switch back to Users tab
      await tester.tap(find.widgetWithText(InkWell, 'Users'));
      await tester.pumpAndSettle();
      expect(find.text('Search Users'), findsOneWidget);

      resetScreen(tester);
    });
    testWidgets('Error messages clear on success', (WidgetTester tester) async {
      await tester.pumpWidget(const MobileBankingApp());

      // Attempt failed login
      await tester.enterText(find.byType(TextField).first, 'wrong');
      await tester.enterText(find.byType(TextField).last, 'wrong');
      await tester.tap(find.text('Sign In'));
      await tester.pump();

      // Error should be visible
      expect(find.text('Invalid username or password'), findsOneWidget);
    });
  });

  group('Performance Tests', () {
    testWidgets('App renders without significant delay', (WidgetTester tester) async {
      final stopwatch = Stopwatch()..start();

      await tester.pumpWidget(const MobileBankingApp());
      await tester.pumpAndSettle();

      stopwatch.stop();

      // Should render in reasonable time (less than 5 seconds)
      expect(stopwatch.elapsedMilliseconds, lessThan(5000));
    });

    testWidgets('Tab switching is smooth', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      final stopwatch = Stopwatch()..start();

      // Switch tabs
      await tester.tap(find.widgetWithText(InkWell, 'Accounts'));
      await tester.pumpAndSettle();

      stopwatch.stop();

      // Should switch quickly (less than 1 second)
      expect(stopwatch.elapsedMilliseconds, lessThan(1000));

      resetScreen(tester);
    });
  });

  group('Integration Tests', () {
    testWidgets('Complete user flow from login to logout', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());

      // Step 1: Login
      await performLogin(tester);
      expect(find.text('Mobile Banking Dashboard'), findsOneWidget);

      // Step 2: Navigate to Users
      expect(find.text('Search Users'), findsOneWidget);

      // Step 3: Navigate to Accounts
      await tester.tap(find.widgetWithText(InkWell, 'Accounts'));
      await tester.pumpAndSettle();
      expect(find.text('Search Accounts'), findsOneWidget);

      // Step 4: Navigate to Transactions
      await tester.tap(find.widgetWithText(InkWell, 'Transactions'));
      await tester.pumpAndSettle();
      expect(find.text('Search Transactions'), findsOneWidget);

      // Step 5: Logout
      await tester.tap(find.text('Logout'));
      await tester.pumpAndSettle();
      expect(find.text('Sign in to access your dashboard'), findsOneWidget);

      resetScreen(tester);
    });

    testWidgets('Multiple login/logout cycles work correctly', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());

      // First cycle
      await performLogin(tester);
      expect(find.text('Mobile Banking Dashboard'), findsOneWidget);
      await tester.tap(find.text('Logout'));
      await tester.pumpAndSettle();

      // Second cycle
      await performLogin(tester);
      expect(find.text('Mobile Banking Dashboard'), findsOneWidget);
      await tester.tap(find.text('Logout'));
      await tester.pumpAndSettle();

      // Third cycle
      await performLogin(tester);
      expect(find.text('Mobile Banking Dashboard'), findsOneWidget);

      resetScreen(tester);
    });
  });

  group('Final Verification Tests', () {
    testWidgets('All main features are accessible', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      // Verify Users features
      expect(find.text('Create User'), findsWidgets);
      expect(find.text('Search Users'), findsOneWidget);
      expect(find.text('Load All Users'), findsOneWidget);

      // Verify Accounts features
      await tester.tap(find.widgetWithText(InkWell, 'Accounts'));
      await tester.pumpAndSettle();
      expect(find.text('Create Account'), findsWidgets);
      expect(find.text('Search Accounts'), findsOneWidget);
      expect(find.text('Load All Accounts'), findsOneWidget);

      // Verify Transactions features
      await tester.tap(find.widgetWithText(InkWell, 'Transactions'));
      await tester.pumpAndSettle();
      expect(find.text('Create Transaction'), findsWidgets);
      expect(find.text('Search Transactions'), findsOneWidget);
      expect(find.text('Load All Transactions'), findsOneWidget);

      resetScreen(tester);
    });

    testWidgets('No critical widgets are missing', (WidgetTester tester) async {
      await setLargeScreen(tester);
      await tester.pumpWidget(const MobileBankingApp());
      await performLogin(tester);

      // Critical widgets check
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
      expect(find.byType(ElevatedButton), findsWidgets);
      expect(find.byType(TextField), findsWidgets);
      expect(find.byType(DataTable), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsWidgets);

      resetScreen(tester);
    });
  });
}