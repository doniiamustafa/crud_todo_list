// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:crud_local_testing_app/config/app_colors.dart';
import 'package:flutter/material.dart';

class AppGradientButton extends StatelessWidget {
  final String title;

  final double height;
  final double width;
  VoidCallback? onPressed;

  AppGradientButton(
      {super.key,
      required this.title,
      required this.height,
      required this.width,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  AppColors.buttonColor1,
                  AppColors.buttonColor2,
                ]),
            borderRadius: BorderRadius.circular(20)),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              disabledBackgroundColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              elevation: 0),
          child: Text(title, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
