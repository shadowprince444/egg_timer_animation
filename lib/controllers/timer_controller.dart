import 'dart:async';

import 'package:egg_timer/utils/app_constants/enums.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TimerController extends GetxController {
  TimerStatus timerStatus = TimerStatus.reset;
  final int ticksPerSection = 5;
  var _maxTime = Duration(minutes: 30),
      _currentTime = Duration(
        minutes: 15,
      ).obs;
  Duration _previousDuration = Duration.zero;

  Duration get maxTime => _maxTime;

  Rx<Duration> get currentTime => _currentTime;
  Rx<double> timerProgressPercentage = 0.0.obs;

  set maxTime(duration) {
    _maxTime = duration;

    update();
  }

  ///Sets the timer from the [RadialScrollGesture] response.
  setTimer(double percentage) {
    int totalSeconds = (_maxTime.inSeconds * percentage).floor();

    setTimerPercentage(totalSeconds);

    _currentTime.value = getDurationFromTotalSeconds(totalSeconds);
    _previousDuration = _currentTime.value;

    update();
  }

  ///Calculates the completion percentage from pending and maximum time left
  void setTimerPercentage(int totalSeconds) {
    timerProgressPercentage.value = totalSeconds / _maxTime.inSeconds;
  }

  ///Counts down each seconds and alerts the listners.
  ///when the [totalSeconds] hits zero the timer is stopped,then the controller is reset
  countDown(Timer timer) {
    int totalSeconds = _currentTime.value.inSeconds;
    totalSeconds--;

    if (totalSeconds == 0) {
      SystemSound.play(SystemSoundType.alert);
      timer.cancel();
      reset();
    } else {
      setTimerPercentage(totalSeconds);
      _currentTime.value = getDurationFromTotalSeconds(totalSeconds);
    }
  }

  restart() {
    int totalSeconds = _previousDuration.inSeconds;

    setTimerPercentage(totalSeconds);

    setTimer(timerProgressPercentage.value);
    timerStatus = TimerStatus.restarted;
    update();
  }

  start() {
    // initializeTimer();
    timerStatus = TimerStatus.running;
    update();
  }

  void initializeTimer() {
    timerProgressPercentage.value = _currentTime.value.inSeconds / _maxTime.inSeconds;
  }

  pause() {
    timerStatus = TimerStatus.paused;
    update();
  }

  reset() {
    timerStatus = TimerStatus.reset;
    // _maxTime = const Duration();
    timerProgressPercentage.value = 0;
    _currentTime.value = const Duration();
    _previousDuration = Duration.zero;
    update();
  }

  Duration getDurationFromTotalSeconds(int totalSeconds) {
    int minutes = (totalSeconds / 60).floor();
    int seconds = totalSeconds - (minutes * 60);
    return Duration(minutes: minutes, seconds: seconds);
  }
}
