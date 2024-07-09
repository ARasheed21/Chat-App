import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_chat_app/cubits/add_message_cubit/add_message_cubit.dart';
import 'package:my_chat_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:my_chat_app/provider/image_picker_provider.dart';
import 'package:my_chat_app/provider/password_visibility_provider.dart';
import 'package:my_chat_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'cubits/user_cubit/user_cubit.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyChatApp());
}

class MyChatApp extends StatelessWidget {
  const MyChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit(),
        ),
        BlocProvider(
          create: (context) => AddMessageCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        ChangeNotifierProvider(
          create: (_) => PasswordVisibilityProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ImagePickerProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
