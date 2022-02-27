import 'dart:math';

import 'package:egg_timer/controllers/timer_controller.dart';
import 'package:egg_timer/utils/app_constants/app_colors.dart';
import 'package:egg_timer/utils/screen_utils/size_config.dart';
import 'package:egg_timer/widgets/gradient_cicle_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';

import 'custom_paint/custom_arrow_painter.dart';

class RotatingTimerKnob extends StatelessWidget {
  const RotatingTimerKnob({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GetX<TimerController>(builder: (controller) {
          return Transform.rotate(
            angle: 2 * pi * controller.timerProgressPercentage.value,
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: CustomPaint(
                painter: CustomArrowPainter(),
              ),
            ),
          );
        }),
        // Transform.rotate(
        //   angle: 2 * pi * widget.rotationPercent,
        //   child: SizedBox(
        //     height: double.infinity,
        //     width: double.infinity,
        //     child: CustomPaint(
        //       painter: CustomArrowPainter(),
        //     ),
        //   ),
        // ),
        GradientCircle(
          ///Second Circle
          decoration: gradientBoxDecoration.copyWith(
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                color: Color(0x44000000),
                blurRadius: 2,
                spreadRadius: 1,
                offset: Offset(0, 1),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(
            8.vdp(),
          ),
          child: GradientCircle(
            /// Third Circle
            decoration: gradientBoxDecoration.copyWith(
              shape: BoxShape.circle,
              gradient: null,
              border: Border.all(
                color: const Color(0xffDFDFDF),
                width: 1.vdp(),
              ),
            ),
            child: GetX<TimerController>(builder: (controller) {
              return Transform.rotate(
                angle: 2 * pi * controller.timerProgressPercentage.value,
                child: const Center(
                  child: Icon(
                    Icons.flutter_dash,
                    size: 60,
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
