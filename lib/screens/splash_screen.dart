import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_chat_app/models/user_model.dart';
import 'package:my_chat_app/screens/home_screen.dart';
import 'package:my_chat_app/screens/login_screen.dart';
import 'package:my_chat_app/services/sharedpreference_service.dart';
import 'package:my_chat_app/utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    // Simulate a short delay for the splash screen
    await Future.delayed(Duration(seconds: 2));

    try{
      FirebaseAuth.instance.authStateChanges().listen((User? user) async{
        if (user == null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        } else {
          String email = FirebaseAuth.instance.currentUser!.email!;
          String username = await SharedPreferencesService.getUsername() ?? 'username';
          String? photoUrl =  await SharedPreferencesService.getPhotoUrl() ?? null;
          UserModel currentUser = UserModel(id: email, username: username,photoUrl: photoUrl);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen(currentUser:currentUser)),
          );
        }
      });
    }catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/chat1.jpg'),
          SizedBox(
            width: 200,
            child: LinearProgressIndicator(
              color: AppColors.primary,
              backgroundColor: Color(0xff75829b),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
