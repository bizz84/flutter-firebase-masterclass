import 'package:flutter_test/flutter_test.dart';

import '../robot.dart';

void main() {
  testWidgets('Full purchase flow', (tester) async {
    // * Note: All tests are wrapped with `runAsync` to prevent this error:
    // * A Timer is still pending even after the widget tree was disposed.
    await tester.runAsync(() async {
      final r = Robot(tester);
      await r.pumpMyAppWithFakes();
      await r.fullPurchaseFlow();
    });
  });
}
