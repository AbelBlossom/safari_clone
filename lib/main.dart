import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:safari_clone/provider/position_provider.dart';
import 'package:safari_clone/ui/browser.dart';
import 'package:safari_clone/ui/pages/test.dart';
import 'package:safari_clone/provider/ui_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UIManager(),
        ),
        Provider(create: (_) => PositionProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: const CupertinoThemeData(
        primaryColor: Colors.blue,
        brightness: Brightness.light,
      ),
      // home: const Browser(),
      initialRoute: "/",
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const CupertinoScaffold(body: Browser()),
        "/test": (context) => const CupertinoScaffold(body: TestPage())
      },
    );
  }
}
