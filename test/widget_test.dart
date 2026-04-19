// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:mds/main.dart';

void main() {
  testWidgets('Home screen renders tactical sentinel entry view', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MdsApp());

    expect(find.text('Mine Detection System'), findsOneWidget);
    expect(find.text('SECTOR STATUS'), findsOneWidget);
    expect(find.text('Start Field Scan'), findsOneWidget);
    expect(find.text('Open Offline Queue'), findsOneWidget);
  });
}
