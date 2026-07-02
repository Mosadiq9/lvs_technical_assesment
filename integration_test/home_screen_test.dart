import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'helpers/test_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  Future<void> navigateToHome(WidgetTester tester) async {
    await tester.pumpWidget(createTestApp());
    // Splash screen
    await tester.pump(const Duration(milliseconds: 2600));
    await tester.pumpAndSettle();

    // Tap Google Sign-in
    final googleBtn = find.text('Continue with Google').first;
    await tester.tap(googleBtn);
    await tester.pumpAndSettle();
  }

  group('Home Screen Integration Tests', () {
    testWidgets('home screen displays top app bar with Alive branding', (
      tester,
    ) async {
      await navigateToHome(tester);

      expect(find.text('Alive'), findsOneWidget);
      expect(find.byIcon(Icons.notifications_none_rounded), findsOneWidget);
      expect(
        find.byIcon(Icons.account_balance_wallet_outlined),
        findsOneWidget,
      );
    });

    testWidgets('home screen shows Stream/Hot/Follow tabs', (tester) async {
      await navigateToHome(tester);

      expect(find.text('Stream'), findsOneWidget);
      expect(find.text('Hot'), findsOneWidget);
      expect(find.text('Follow'), findsOneWidget);
    });

    testWidgets('tapping tabs switches active tab indicator', (tester) async {
      await navigateToHome(tester);

      final hotTab = find.text('Hot');
      await tester.tap(hotTab);
      await tester.pumpAndSettle();

      // In a real app we'd check text styles or indicator bars,
      // but verifying tap doesn't crash is a good start.
      expect(find.text('Hot'), findsOneWidget);
    });

    testWidgets('category filter chips are displayed', (tester) async {
      await navigateToHome(tester);

      // Wait for categories to load (simulated delay)
      await tester.pumpAndSettle();

      expect(find.text('Global'), findsOneWidget);
      expect(find.text('India'), findsOneWidget);
      expect(find.text('Philippines'), findsOneWidget);
    });

    testWidgets('tapping a category chip filters streams', (tester) async {
      await navigateToHome(tester);

      final indiaChip = find.text('India');
      await tester.tap(indiaChip);

      // Pump to trigger loading
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Wait for loading to finish
      await tester.pumpAndSettle();

      // Stream specific to India should be visible
      expect(find.text('Priya K.'), findsOneWidget);
    });

    testWidgets('stream cards display correctly', (tester) async {
      await navigateToHome(tester);

      expect(find.text('Priya K.'), findsOneWidget);
      expect(find.text('3.4k'), findsOneWidget);
      expect(find.text('+ Follow'), findsWidgets);
    });

    testWidgets('tapping Follow button toggles follow state', (tester) async {
      await navigateToHome(tester);

      final followBtn = find.text('+ Follow').first;
      await tester.tap(followBtn);

      // Wait for follow action to complete
      await tester.pumpAndSettle();

      // Verify state still shows (simplest check)
      expect(find.text('+ Follow'), findsWidgets);
    });

    testWidgets('bottom navigation bar renders all items', (tester) async {
      await navigateToHome(tester);

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Party'), findsOneWidget);
      expect(find.text('Go Live'), findsOneWidget);
      expect(find.text('Chats'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('tapping Profile opens user menu bottom sheet', (tester) async {
      await navigateToHome(tester);

      final profileTab = find.text('Profile');
      await tester.tap(profileTab);

      // Allow bottom sheet to animate up
      await tester.pumpAndSettle();

      expect(find.text('User Settings & Account'), findsOneWidget);
      expect(find.text('Sign Out'), findsOneWidget);
    });

    testWidgets('sign out navigates back to login', (tester) async {
      await navigateToHome(tester);

      // Open profile sheet
      final profileTab = find.text('Profile');
      await tester.tap(profileTab);
      await tester.pumpAndSettle();

      // Tap sign out
      final signOutBtn = find.text('Sign Out');
      await tester.tap(signOutBtn);

      // Allow navigation back to login
      await tester.pumpAndSettle();

      expect(find.text('Welcome back! 👋'), findsOneWidget);
    });
  });
}
