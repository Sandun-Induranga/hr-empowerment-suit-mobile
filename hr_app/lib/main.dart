import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hr_app/main_app.dart';

final localhostServer = InAppLocalhostServer(documentRoot: 'assets');

Future main() async {

  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
  }

  if (!kIsWeb) {
    await localhostServer.start();
  }

  runApp(const MainApp());
}
