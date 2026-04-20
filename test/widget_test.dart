import 'package:flutter_test/flutter_test.dart';

import 'package:mini_katalog_uygulamasi/main.dart';

void main() {
  testWidgets('Mini katalog ana sayfa acilir', (WidgetTester tester) async {
    await tester.pumpWidget(const MiniKatalogApp());
    await tester.pumpAndSettle();

    expect(find.text('Mini Katalog Uygulamasi'), findsOneWidget);
  });
}
