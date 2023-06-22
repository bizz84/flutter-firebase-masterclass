import 'package:flutter/material.dart';
import 'package:ecommerce_app/src/app_bootstrap_fakes.dart';
import 'package:ecommerce_app/src/app_bootstrap.dart';
// ignore:depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // turn off the # in the URLs on the web
  usePathUrlStrategy();
  // ensure URL changes in the address bar when using push / pushNamed
  // more info here: https://docs.google.com/document/d/1VCuB85D5kYxPR3qYOjVmw8boAGKb7k62heFyfFHTOvw/edit
  GoRouter.optionURLReflectsImperativeAPIs = true;
  // create an app bootstrap instance
  final appBootstrap = AppBootstrap();
  // create a container configured with all the "fake" repositories
  final container = await appBootstrap.createFakesProviderContainer();
  // use the container above to create the root widget
  final root = appBootstrap.createRootWidget(container: container);
  // start the app
  runApp(root);
}
