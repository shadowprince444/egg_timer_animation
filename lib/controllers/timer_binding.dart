import 'package:egg_timer/controllers/timer_controller.dart';
import 'package:get/get.dart';

class TimerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<TimerController>(TimerController());
    Get.find<TimerController>().setTimer(.5);
  }
}
