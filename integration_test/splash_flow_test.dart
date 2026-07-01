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

  group('Splash Flow Integration Tests', () {
    testWidgets('splash screen shows app logo', (tester) async {
      await tester.pumpWidget(createTestApp());
      
      // Wait for first frame
      await tester.pump();

      // Find logo image (either the Image widget or the badge error builder)
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('splash screen navigates to login after delay', (tester) async {
      await tester.pumpWidget(createTestApp());
      
      // Pump initial frame
      await tester.pump();
      
      // Wait for splash duration (AppDurations.splash is 2500ms)
      await tester.pump(const Duration(milliseconds: 2600));
      
      // Allow router to navigate
      await tester.pumpAndSettle();

      // Verify login header text is visible
      expect(find.text('Welcome back! 👋'), findsOneWidget);
    });
    
    testWidgets('splash animation runs', (tester) async {
      await tester.pumpWidget(createTestApp());
      
      // Initially AnimatedBuilder should be present
      expect(find.byType(AnimatedBuilder), findsOneWidget);
    });
  });
}
