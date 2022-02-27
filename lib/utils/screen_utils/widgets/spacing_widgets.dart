import 'package:egg_timer/utils/screen_utils/size_config.dart';
import 'package:flutter/material.dart';

class VSpace extends StatelessWidget {
  final double height;

  const VSpace(this.height, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: (height).vdp());
  }
}

class HSpace extends StatelessWidget {
  final double width;

  const HSpace(this.width, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: (width).hdp());
  }
}

class ExpSized extends StatelessWidget {
  const ExpSized({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(child: SizedBox());
  }
}
