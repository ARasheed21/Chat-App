import 'package:flutter/material.dart';

class FavouriteContainer extends StatelessWidget {
  const FavouriteContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 105,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black54.withOpacity(0.35),
                offset: Offset(12, 14),
                blurRadius: 10,
              ),
            ],
            image: DecorationImage(
              image: AssetImage('assets/images/rasheed.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          width: 105,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff292f3f).withOpacity(0), // Start color
                Color(0xff292f3f).withOpacity(0.8), // End color
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Ahmed Rasheed',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.8)
                ),
              ),
              Icon(Icons.favorite_rounded,color: Colors.white,)
            ],
          ),
        ),

      ],
    );
  }
}
