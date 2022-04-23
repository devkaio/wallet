import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wallet/shared/widgets/widgets.dart';

void main() {
  testWidgets('Should test if PrimaryButton onPress works',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: PrimaryButton(
          onPressed: null,
          text: 'press',
        ),
      ),
    );

    final primaryButtonFinder = find.byType(PrimaryButton);
    final textFinder = find.text('press'.toUpperCase());

    expect(primaryButtonFinder, findsOneWidget);
    expect(textFinder, findsOneWidget);
  });
}
