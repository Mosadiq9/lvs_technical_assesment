import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'helpers/test_app.dart';
import 'helpers/fake_auth_datasource.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = true;
  });

  Future<void> navigateToLogin(WidgetTester tester) async {
    await tester.pumpWidget(createTestApp());
    await tester.pump(const Duration(milliseconds: 2600));
    await tester.pumpAndSettle();
  }

  group('Auth Flow Integration Tests', () {
    testWidgets('login screen renders all UI elements', (tester) async {
      await navigateToLogin(tester);

      expect(find.text('Welcome back! 👋'), findsOneWidget);
      expect(find.text('Email ID or Phone Number'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Forgot Password?'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
      
      // Should find at least one "Continue with Google"
      expect(find.text('Continue with Google'), findsWidgets);
      
      expect(find.text('Sign Up'), findsOneWidget);
    });

    testWidgets('tapping Login button shows snackbar message', (tester) async {
      await navigateToLogin(tester);

      final loginBtn = find.text('Login');
      await tester.tap(loginBtn);
      await tester.pumpAndSettle();

      expect(find.text('Please use Continue with Google.'), findsOneWidget);
    });

    testWidgets('password visibility toggle works', (tester) async {
      await navigateToLogin(tester);

      final passwordField = find.byType(TextFormField).last;
      await tester.enterText(passwordField, 'secret');
      await tester.pump();

      // Find the visibility icon
      final visibilityIcon = find.byIcon(Icons.remove_red_eye_outlined);
      expect(visibilityIcon, findsOneWidget);

      await tester.tap(visibilityIcon);
      await tester.pump();

      // Should now show visibility off
      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
    });

    testWidgets('Continue with Google navigates to Home on success', (tester) async {
      await navigateToLogin(tester);

      // We have duplicate buttons, just tap the first one
      final googleBtn = find.text('Continue with Google').first;
      await tester.tap(googleBtn);
      
      // Allow async auth and navigation to finish
      await tester.pumpAndSettle();

      // Verify we reached the home screen
      expect(find.text('Alive'), findsWidgets);
      expect(find.text('Live Streams'), findsOneWidget);
      expect(find.text('Stream'), findsOneWidget);
      expect(find.text('Hot'), findsOneWidget);
    });

    testWidgets('Continue with Google shows error snackbar on failure', (tester) async {
      await tester.pumpWidget(createTestApp(
        authDataSource: FailingFakeAuthDataSource(),
      ));
      
      // Splash screen delay
      await tester.pump(const Duration(milliseconds: 2600));
      await tester.pumpAndSettle();

      final googleBtn = find.text('Continue with Google').first;
      await tester.tap(googleBtn);
      
      await tester.pumpAndSettle();

      // Should still be on login screen, showing an error snackbar
      expect(find.text('Google Sign-In aborted by user.'), findsOneWidget);
      expect(find.text('Welcome back! 👋'), findsOneWidget);
    });
  });
}
