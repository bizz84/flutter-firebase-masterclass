import 'package:ecommerce_app/src/features/checkout/application/checkout_service.dart';
import 'package:ecommerce_app/src/features/checkout/presentation/payment/payment_button_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  ProviderContainer makeProviderContainer(MockCheckoutService checkoutService) {
    final container = ProviderContainer(
      overrides: [
        checkoutServiceProvider.overrideWithValue(checkoutService),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  setUpAll(() {
    registerFallbackValue(const AsyncLoading<int>());
  });

  group('pay', () {
    const isWeb = false;
    test('success', () async {
      // setup
      final checkoutService = MockCheckoutService();
      when(() => checkoutService.pay(isWeb: isWeb)).thenAnswer(
        (_) => Future.value(null),
      );
      final container = makeProviderContainer(checkoutService);
      final controller =
          container.read(paymentButtonControllerProvider.notifier);
      final listener = Listener<AsyncValue<void>>();
      container.listen(
        paymentButtonControllerProvider,
        listener.call,
        fireImmediately: true,
      );
      const data = AsyncData<void>(null);
      verify(() => listener(null, data));
      // run
      await controller.pay(isWeb: isWeb);
      // verify
      verifyInOrder([
        () => listener(data, any(that: isA<AsyncLoading>())),
        () => listener(any(that: isA<AsyncLoading>()), data),
      ]);
      verifyNoMoreInteractions(listener);
      verify(() => checkoutService.pay(isWeb: isWeb)).called(1);
    });

    test('failure', () async {
      // setup
      final checkoutService = MockCheckoutService();
      when(() => checkoutService.pay(isWeb: isWeb)).thenThrow(
        Exception('Card declined'),
      );
      final container = makeProviderContainer(checkoutService);
      final controller =
          container.read(paymentButtonControllerProvider.notifier);
      final listener = Listener<AsyncValue<void>>();
      container.listen(
        paymentButtonControllerProvider,
        listener.call,
        fireImmediately: true,
      );
      const data = AsyncData<void>(null);
      verify(() => listener(null, data));
      // run
      await controller.pay(isWeb: isWeb);
      // verify
      verifyInOrder([
        () => listener(data, any(that: isA<AsyncLoading>())),
        () => listener(
            any(that: isA<AsyncLoading>()), any(that: isA<AsyncError>())),
      ]);
      verifyNoMoreInteractions(listener);
      verify(() => checkoutService.pay(isWeb: isWeb)).called(1);
    });
  });
}
