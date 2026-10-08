import 'package:flutter_test/flutter_test.dart';
import 'package:open_articles_flutter/app.dart';

void main() {
  testWidgets('App loads', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.byType(App), findsOneWidget);
  });
}