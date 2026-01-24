import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:daily_zikr/main.dart';

void main() {
  testWidgets('App should render home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const DailyZikrApp());
    
    // Verify the home screen renders with key elements
    expect(find.text('Morning Adhkar'), findsOneWidget);
    expect(find.text('Evening Adhkar'), findsOneWidget);
  });
}
