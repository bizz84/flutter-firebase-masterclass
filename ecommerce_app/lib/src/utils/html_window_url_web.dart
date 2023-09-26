// ignore:avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/foundation.dart';

String? getHtmlWindowUrl() {
  assert(kIsWeb, 'kIsWeb is false -> Can\'t invoke getHtmlWindowUrl');
  return html.window.location.href;
}

void setHtmlWindowUrl(String url) {
  assert(kIsWeb, 'kIsWeb is false -> Can\'t invoke setHtmlWindowUrl');
  html.window.location.href = url;
}
