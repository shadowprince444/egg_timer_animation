import 'package:egg_timer/controllers/timer_controller.dart';
import 'package:egg_timer/utils/app_constants/app_colors.dart';
import 'package:egg_timer/utils/app_constants/enums.dart';
import 'package:egg_timer/utils/screen_utils/size_config.dart';
import 'package:egg_timer/utils/screen_utils/widgets/responsive_safe_area.dart';
import 'package:egg_timer/widgets/gradient_cicle_widget.dart';
import 'package:egg_timer/widgets/timer_dialer/custom_paint/clock_ticker_custom_painter.dart';
import 'package:egg_timer/widgets/timer_dialer/rotating_timer_knob.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimerDialWidget extends StatelessWidget {
  const TimerDialWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(
          24.vdp(),
        ),
        child: GradientCircle(
          ///First Circle
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
          child: Padding(
            padding: EdgeInsets.all(
              64.vdp(),
            ),
            child: ResponsiveSafeArea(builder: (context, size) {
              return GestureDetector(
                onPanUpdate: (details) {
                  _panUpdateHandler(details, size.height / 2);
                },
                child: Stack(
                  children: [
                    const RotatingTimerKnob(),
                    GetBuilder<TimerController>(builder: (timerController) {
                      return SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: CustomPaint(
                          painter: ClockTickerPainter(
                            tickCounts: timerController.maxTime.inMinutes,
                            ticksPerSection: timerController.ticksPerSection,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  _panUpdateHandler(DragUpdateDetails d, double radius) {
    TimerController controller = Get.find<TimerController>();
    if (controller.timerStatus == TimerStatus.running) {
      return;
    }

    /// Pan location on the wheel
    ///

    bool onTop = d.localPosition.dy <= radius;
    bool onLeftSide = d.localPosition.dx <= radius;
    bool onRightSide = !onLeftSide;
    bool onBottom = !onTop;

    /// Pan movements
    bool panUp = d.delta.dy <= 0.0;
    bool panLeft = d.delta.dx <= 0.0;
    bool panRight = !panLeft;
    bool panDown = !panUp;

    /// Absolute change on axis
    double yChange = d.delta.dy.abs();
    double xChange = d.delta.dx.abs();

    /// Directional change on wheel
    double verticalRotation = (onRightSide && panDown) || (onLeftSide && panUp) ? yChange : yChange * -1;

    double horizontalRotation = (onTop && panRight) || (onBottom && panLeft) ? xChange : xChange * -1;

// Total computed change
    double rotationalChange = verticalRotation + horizontalRotation;
    bool movingClockwise = rotationalChange > 0;
    bool movingCounterClockwise = rotationalChange < 0;
    double _value = 0;

    _value = (controller.timerProgressPercentage * 360) + (rotationalChange);
    if (_value <= 360 && _value >= 0) {
      controller.setTimer((_value / 360));
    }
  }
}
