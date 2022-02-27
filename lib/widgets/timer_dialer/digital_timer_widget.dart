import 'package:egg_timer/controllers/timer_controller.dart';
import 'package:egg_timer/utils/screen_utils/text_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';

class DigitalTimerWidget extends StatelessWidget {
  const DigitalTimerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GetX<TimerController>(builder: (timerController) {
        int minutes = timerController.currentTime.value.inMinutes;
        int seconds = (timerController.currentTime.value.inSeconds) - (minutes * 60);
        return Text(
          "$minutes:$seconds",
          style: AppTextThemes().largeText.copyWith(
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
        );
      }),
    );
  }
}
