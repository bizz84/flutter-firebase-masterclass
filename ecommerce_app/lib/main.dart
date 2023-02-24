import 'package:flutter/material.dart';
import 'package:ecommerce_app/src/app_bootstrap_fakes.dart';
import 'package:ecommerce_app/src/app_bootstrap.dart';
// ignore:depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // turn off the # in the URLs on the web
  usePathUrlStrategy();

  final appBootstrap = AppBootstrap();

  final container = await createFakesProviderContainer();
  final root = appBootstrap.createRootWidget(container: container);
  runApp(root);
}
