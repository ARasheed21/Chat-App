import 'package:flutter/material.dart';
import 'package:my_chat_app/screens/login_screen.dart';
import 'package:my_chat_app/services/auth_service.dart';
import 'package:my_chat_app/services/sharedpreference_service.dart';
import 'package:my_chat_app/utils/app_colors.dart';

import '../models/user_model.dart';

class DrawerList extends StatelessWidget {
  DrawerList({super.key, required this.currentUser});

  final UserModel currentUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5,
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primary,
            ), //BoxDecoration
            child: Align(
              alignment: Alignment.center,
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: AppColors.primary),
                accountName: Text(
                  currentUser.username,
                  style: TextStyle(fontSize: 18),
                ),
                accountEmail: Text(currentUser.id),
                currentAccountPictureSize: Size.square(50),
                currentAccountPicture: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  backgroundImage: currentUser.photoUrl != null? NetworkImage(currentUser.photoUrl!):null,
                  child: currentUser.photoUrl == null ?Icon(
                    Icons.person_rounded,
                    size: 45,
                    color: AppColors.primary,
                  ):null,
                ), //circleAvatar
              ),
            ), //UserAccountDrawerHeader
          ), //DrawerHeader
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(' My Profile '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text(' Edit Profile '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log Out'),
            onTap: () async {
              await AuthService.signOut();
              await SharedPreferencesService.deleteUsername();
              await SharedPreferencesService.deletePhotoUrl();
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (_) {
                return LoginScreen();
              }), (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
