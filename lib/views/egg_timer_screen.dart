import 'dart:async';

import 'package:egg_timer/controllers/timer_controller.dart';
import 'package:egg_timer/utils/app_constants/app_colors.dart';
import 'package:egg_timer/utils/app_constants/enums.dart';
import 'package:egg_timer/utils/screen_utils/size_config.dart';
import 'package:egg_timer/utils/screen_utils/widgets/responsive_safe_area.dart';
import 'package:egg_timer/utils/screen_utils/widgets/spacing_widgets.dart';
import 'package:egg_timer/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../widgets/timer_dialer/digital_timer_widget.dart';
import '../widgets/timer_dialer/timer_dialer_widget.dart';

class EggTimerScreen extends StatelessWidget {
  const EggTimerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: topGradient,
        ),
        child: ResponsiveSafeArea(
          builder: (context, size) => Container(
            decoration: gradientBoxDecoration,
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: size.height / 6,
                  // color: Colors.red,
                  child: const DigitalTimerWidget(),
                ),
                const TimerDialWidget(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomButton(
                        onTap: () {
                          final timerController = Get.find<TimerController>();
                          timerController.restart();
                        },
                        buttonIcon: Icons.refresh,
                        buttonText: "Restart",
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: CustomButton(
                        onTap: () {
                          final timerController = Get.find<TimerController>();

                          timerController.reset();
                        },
                        buttonIcon: Icons.arrow_back,
                        buttonText: "Reset",
                      ),
                    ),
                  ],
                ),
                GetBuilder<TimerController>(builder: (controller) {
                  return CustomButton(
                    onTap: () {
                      final timerController = Get.find<TimerController>();
                      startTimer(timerController);
                    },
                    buttonIcon: controller.timerStatus != TimerStatus.running ? Icons.play_arrow : Icons.pause,
                    buttonText: controller.timerStatus != TimerStatus.running ? "Start" : "Pause",
                  );
                }),
                const ExpSized(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startTimer(TimerController timerController) {
    if (timerController.timerStatus != TimerStatus.running) {
      timerController.start();
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (timerController.timerStatus == TimerStatus.running) {
          timerController.countDown(timer);
          SystemSound.play(SystemSoundType.click);
        } else {
          timer.cancel();
        }
      });
    } else {
      timerController.pause();
    }
  }
}
