import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import './state/index.dart';
import './pages/not-found/index.dart';
import './routes/index.dart';

void main(List<String> args) {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Modal(1))],
      child: const MyApp(),
    ),
  );
  configLoading();
}

// 初始化loading
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2)
    ..indicatorType = EasyLoadingIndicatorType.wave
    ..loadingStyle = EasyLoadingStyle.custom //light dart custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow // 仅对custom类型有效
    ..backgroundColor = Colors.green // 仅对custom类型有效
    ..indicatorColor = Colors.yellow // 仅对custom类型有效
    ..textColor = Colors.yellow // 仅对custom类型有效
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: routes,

      onGenerateRoute: (setting) {
        return MaterialPageRoute(builder: (context) => NotFound());
      }, //可设置路由守卫 只对命名路由有效
      builder: EasyLoading.init(), //若要使用easyloading必须加
    );
  }
}
