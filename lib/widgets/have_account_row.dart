import 'package:flutter/cupertino.dart';

import '../utils/app_colors.dart';

class HaveAccountRow extends StatelessWidget {
  HaveAccountRow({super.key, required this.text1, required this.text2, required this.onTap});

  final String text1;
  final String text2;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text1,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            text2,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: AppColors.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
