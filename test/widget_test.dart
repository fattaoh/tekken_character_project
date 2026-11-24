import 'package:flutter_test/flutter_test.dart';
import 'package:tekken_project/main.dart';

void main() {
  testWidgets('home shows fighters and opens a fighter profile', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Pilih petarungmu'), findsOneWidget);
    expect(find.text('Yoshimitsu'), findsOneWidget);

    await tester.tap(find.text('Yoshimitsu'));
    await tester.pumpAndSettle();

    expect(find.text('Profil petarung'), findsOneWidget);
    expect(find.text('Tentang karakter'), findsOneWidget);
    expect(find.text('Signature moves'), findsOneWidget);
  });

  testWidgets('tapping a signature move shows controller activation help', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Yoshimitsu'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Flash'));
    await tester.tap(find.text('Flash'));
    await tester.pumpAndSettle();

    expect(find.text('Input: d+1+4'), findsOneWidget);
    expect(
      find.textContaining('Tekan D-pad ke bawah sambil menekan'),
      findsOneWidget,
    );
    expect(
      find.textContaining('1 = □ (PlayStation) / X (Xbox)'),
      findsOneWidget,
    );
  });
}
