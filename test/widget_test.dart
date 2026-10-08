import 'package:flutter_test/flutter_test.dart';
import 'package:open_articles_flutter/app.dart';

void main() {
  testWidgets('App loads', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();
    expect(find.byType(App), findsOneWidget);
  });
}