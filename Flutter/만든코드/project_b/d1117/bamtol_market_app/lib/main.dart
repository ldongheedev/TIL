import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

@override
Widget build(BuildContext context){
  return GetMaterialApp(
    title: '당근마켓 클론 코딩',
    initialRoute: '/',
    getPages: [
      GetPage(
        name: '/',
        page: () => const App(),
      ),
    ]
  );
}
}