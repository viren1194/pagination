import 'package:flutter/material.dart';
import 'package:flutter_product/utils/get_di.dart' as di;
import 'package:flutter_product/view/demo.dart';
import 'package:flutter_product/view/home_page.dart';
import 'package:get/get_navigation/get_navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(title: 'Flutter Demo', home: HomePage());
  }
}
