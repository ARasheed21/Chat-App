
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomeButton extends StatelessWidget {
  CustomeButton({super.key, required this.text, required this.onTap, this.color});
  VoidCallback onTap;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}
