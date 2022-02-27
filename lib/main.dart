import 'package:egg_timer/controllers/timer_binding.dart';
import 'package:egg_timer/controllers/timer_controller.dart';
import 'package:egg_timer/views/egg_timer_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(TimerController());
    return GetMaterialApp(
      initialBinding: TimerBinding(),
      debugShowCheckedModeBanner: false,
      title: 'Egg Timer',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: EggTimerScreen(),
      getPages: [
        GetPage(
          name: '/',
          page: () => EggTimerScreen(),
          binding: TimerBinding(),
        ),
      ],
    );
  }
}
