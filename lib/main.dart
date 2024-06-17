import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'screens/home_page.dart';

void main() {

  // Initialize webview_flutter for Android
  if (Platform.isAndroid) {
    WebView.platform = SurfaceAndroidWebView();
  }

  runApp(MangaReaderApp());
}

class MangaReaderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manga Reader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
