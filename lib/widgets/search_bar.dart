
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class SearchBar extends StatelessWidget {
  SearchBar(
      {super.key,
        required this.hintText,
        required this.onChanged,
        required this.controller});

  final String hintText;
  Function(String) onChanged;
  final controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
          color: Colors.white,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.tertiary,
        hintText: hintText,
        suffixIcon: GestureDetector(
          onTap: (){},
          child: Container(
            width: 37,
            height: 37,
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.person_search_sharp,
              color: Colors.white,
              size: 30,
              weight: 10,
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
    );
  }
}
