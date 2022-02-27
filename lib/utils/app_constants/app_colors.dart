import 'package:flutter/material.dart';

const Color topGradient = Color(0xffF5F5F5);
const Color bottomGradient = Color(0xffE8E8E8);
const BoxDecoration gradientBoxDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      topGradient,
      bottomGradient,
    ],
  ),
);
