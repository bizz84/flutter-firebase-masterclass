import 'package:ecommerce_app/src/features/products/presentation/products_list/product_card.dart';
import 'package:ecommerce_app/src/features/products/presentation/products_list/products_search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class ProductsRobot {
  ProductsRobot(this.tester);
  final WidgetTester tester;

  // products list
  Future<void> selectProduct({int atIndex = 0}) async {
    final finder = find.byKey(ProductCard.productCardKey);
    await tester.tap(finder.at(atIndex));
    await tester.pumpAndSettle();
  }

  void expectFindSearchBox() {
    final finder = find.byType(ProductsSearchTextField);
    expect(finder, findsOneWidget);
  }

  // * Since the product cards are loaded with a sliver grid widget, only the
  // * visible ones will be loaded, even if we use skipOffstage: false
  // * This means that on mobile we may get only one card, even if we have
  // * many more products
  void expectFindAtLeastNProductCards(int count) {
    final finder = find.byType(ProductCard, skipOffstage: false);
    expect(finder, findsAtLeastNWidgets(count));
  }

  void expectProductsListLoaded() {
    expectFindSearchBox();
    expectFindAtLeastNProductCards(1);
  }

  // product page
  Future<void> setProductQuantity(int quantity) async {
    final finder = find.byIcon(Icons.add);
    expect(finder, findsOneWidget);
    for (var i = 1; i < quantity; i++) {
      await tester.tap(finder);
      await tester.pumpAndSettle();
    }
  }
}
