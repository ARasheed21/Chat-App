import 'package:flutter/material.dart';
import 'package:my_chat_app/utils/app_colors.dart';

class RememberMeRow extends StatelessWidget {
  RememberMeRow({super.key, required this.text, required this.value, required this.onChanged});

  final String text;
  bool value;
  Function(void) onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CheckboxListTile(
            contentPadding:EdgeInsets.symmetric(horizontal: 0),
            value: value,
            activeColor: AppColors.primary,
            onChanged: onChanged,
            title: Text(
              'Remember Me',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: AppColors.primary
              ),
            ),
            controlAffinity: ListTileControlAffinity.leading,
          ),
        ),
        GestureDetector(
          onTap: () {
            // Handle "Forget Password" text tap here
          },
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
                color: AppColors.secondary
            ),
          ),
        ),
      ],
    );
  }
}