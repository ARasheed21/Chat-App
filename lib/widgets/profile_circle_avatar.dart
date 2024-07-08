import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class ProfileCircleAvatar extends StatelessWidget {
  ProfileCircleAvatar({super.key, this.image});

  final image;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15), // 15% opacity
            spreadRadius: 0,
            blurRadius: 8,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 60,
        backgroundColor: Colors.white,
        backgroundImage: image != null? image:null,
        child: image == null? Icon(
          Icons.person_rounded,
          size: 80,
          color: AppColors.primary,
        ):null,
      ),
    );
  }
}

/*
Icon(
          Icons.person_rounded,
          size: 80,
          color: AppColors.primary,
        ),
* */
