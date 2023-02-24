import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce_app/src/features/cart/domain/cart.dart';
import 'package:ecommerce_app/src/features/checkout/application/fake_checkout_service.dart';
import 'package:ecommerce_app/src/features/orders/domain/order.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';

import '../../../mocks.dart';

void main() {
  const testUser = AppUser(uid: 'abc', email: 'abc@test.com');
  final testDate = DateTime(2022, 7, 13);
  setUpAll(() {
    // needed for MockOrdersRepository
    registerFallbackValue(Order(
      id: '1',
      userId: testUser.uid,
      items: const {'1': 1},
      productIds: const ['1'],
      orderStatus: OrderStatus.confirmed,
      orderDate: testDate,
      total: 15,
    ));
    // needed for MockRemoteCartRepository
    registerFallbackValue(const Cart());
  });

  late MockAuthRepository authRepository;
  late MockRemoteCartRepository remoteCartRepository;
  late MockOrdersRepository ordersRepository;
  late FakeProductsRepository productsRepository;
  setUp(() {
    authRepository = MockAuthRepository();
    remoteCartRepository = MockRemoteCartRepository();
    ordersRepository = MockOrdersRepository();
    productsRepository = FakeProductsRepository();
  });

  FakeCheckoutService makeCheckoutService() {
    return FakeCheckoutService(
      authRepository: authRepository,
      remoteCartRepository: remoteCartRepository,
      fakeOrdersRepository: ordersRepository,
      fakeProducsRepository: productsRepository,
      currentDateBuilder: () => testDate,
    );
  }

  group('placeOrder', () {
    test('null user, throws', () async {
      // setup
      when(() => authRepository.currentUser).thenReturn(null);
      final checkoutService = makeCheckoutService();
      // run
      expect(checkoutService.placeOrder, throwsA(isA<TypeError>()));
    });

    test('empty cart, throws', () async {
      // setup
      when(() => authRepository.currentUser).thenReturn(testUser);
      when(() => remoteCartRepository.fetchCart(testUser.uid)).thenAnswer(
        (_) => Future.value(const Cart()),
      );
      final checkoutService = makeCheckoutService();
      // run
      expect(checkoutService.placeOrder, throwsStateError);
    });

    test('non-empty cart, creates order and purchase, empties cart', () async {
      // setup
      when(() => authRepository.currentUser).thenReturn(testUser);
      when(() => remoteCartRepository.fetchCart(testUser.uid)).thenAnswer(
        (_) => Future.value(const Cart({'1': 1})),
      );
      when(() => ordersRepository.addOrder(testUser.uid, any())).thenAnswer(
        (_) => Future.value(),
      );
      when(() => remoteCartRepository.setCart(testUser.uid, const Cart()))
          .thenAnswer(
        (_) => Future.value(),
      );
      final checkoutService = makeCheckoutService();
      // run
      await checkoutService.placeOrder();
      // verify
      verify(() => ordersRepository.addOrder(testUser.uid, any())).called(1);
      verify(() => remoteCartRepository.setCart(testUser.uid, const Cart()))
          .called(1);
    });
  });
}
