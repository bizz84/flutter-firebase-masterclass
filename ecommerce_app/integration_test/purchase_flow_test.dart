import 'package:flutter_test/flutter_test.dart';

import '../test/src/robot.dart';

void main() {
  setUpAll(() => WidgetController.hitTestWarningShouldBeFatal = true);
  testWidgets('Integration test - Full purchase flow', (tester) async {
    // * Note: All tests are wrapped with `runAsync` to prevent this error:
    // * A Timer is still pending even after the widget tree was disposed.
    await tester.runAsync(() async {
      final r = Robot(tester);
      await r.pumpMyAppWithFakes();
      await r.fullPurchaseFlow();
    });
  });
}
