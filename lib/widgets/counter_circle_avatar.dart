import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CounterCircleAvatar extends StatelessWidget {
  CounterCircleAvatar({super.key, required this.counter});
  
  final String counter;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.45),
            spreadRadius: 0,
            blurRadius: 24,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 16,
        backgroundColor: AppColors.darkGrey,
        child: Text(
          counter,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ImagePickerCircleAvatar extends StatelessWidget {
  ImagePickerCircleAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.45),
            spreadRadius: 0,
            blurRadius: 12,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 24,
        backgroundColor: AppColors.darkGrey,
        child: Icon(Icons.add_a_photo_rounded,color: Colors.white,),
      ),
    );
  }
}

