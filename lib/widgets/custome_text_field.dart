
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomeTextField extends StatelessWidget {
  CustomeTextField(
      {super.key,
        required this.hintText,
        this.onChanged,
        this.suffixIcon,
        this.iconOnTap,
        this.obscureText,
        required this.controller});

  final String hintText;
  Function(String)? onChanged;
  IconData? suffixIcon;
  var iconOnTap;
  bool? obscureText;
  final controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText??false,
      controller: controller,
      validator: (data) {
        if (data!.isEmpty) {
          return 'please, fill this field';
        }
      },
      onChanged: onChanged,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        errorStyle: TextStyle(height: 0),
        hintText: hintText,
        suffixIcon: GestureDetector(
          onTap: iconOnTap,
          child: Icon(
            suffixIcon,
            //color: AppColors.grey,
            size: 20,
            //weight: 0.5,
          ),
        ),
        hintStyle: TextStyle(color: AppColors.primary),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          //borderSide: BorderSide(color: AppColors.grey),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
