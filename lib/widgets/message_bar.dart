
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class MessageBar extends StatelessWidget {
  MessageBar(
      {super.key,
        required this.hintText,
        required this.onTab,
        required this.controller});

  final String hintText;
  var onTab;
  final controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      //width: MediaQuery.of(context).size.width*0.75,
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Colors.white
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.tertiary,
          hintText: hintText,
          suffixIcon: GestureDetector(
            onTap: onTab,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.primary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}
