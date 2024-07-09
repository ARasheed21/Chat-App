import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_chat_app/models/user_model.dart';
import 'package:my_chat_app/provider/image_picker_provider.dart';
import 'package:my_chat_app/utils/app_colors.dart';
import 'package:my_chat_app/widgets/counter_circle_avatar.dart';
import 'package:my_chat_app/widgets/custome_button.dart';
import 'package:my_chat_app/widgets/custome_text_field.dart';
import 'package:provider/provider.dart';
import '../cubits/auth_cubit/auth_cubit.dart';
import '../provider/password_visibility_provider.dart';
import '../widgets/profile_circle_avatar.dart';
import '../widgets/have_account_row.dart';
import '../widgets/snackbar.dart';
import 'home_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: context.watch<AuthCubit>().isLoading,
        child: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
                    height: 230,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: AppColors.primary),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Let's Start",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Create your account',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            //fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 180,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 80, left: 16, right: 16, bottom: 16),
                      width: 500,
                      height: 600,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(32)),
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Register',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomeTextField(
                              controller: usernameController,
                              hintText: 'Username',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomeTextField(
                              controller: emailController,
                              hintText: 'Email',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Consumer<PasswordVisibilityProvider>(
                              builder: (context, provider, child) {
                                return CustomeTextField(
                                  obscureText: !provider.isVisible,
                                  controller: passwordController,
                                  hintText: 'Password',
                                  suffixIcon: provider.isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  iconOnTap: () {
                                    provider.toggleVisibility();
                                  },
                                );
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            BlocListener<AuthCubit, AuthState>(
                              listener: (context, state) {
                                if (state is AuthSuccess) {
                                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                  showSnackBar(context, 'Registered Successfully');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return HomeScreen(
                                          currentUser: UserModel(
                                              id: emailController.text,
                                              username: usernameController.text,
                                              photoUrl: context
                                                  .read<AuthCubit>()
                                                  .photoUrl),
                                        );
                                      },
                                    ),
                                  );
                                } else if (state is AuthFailure) {
                                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                  showSnackBar(context, state.error);
                                }
                              },
                              child: CustomeButton(
                                text: 'Register',
                                onTap: () async {
                                  if (formKey.currentState!.validate()) {
                                    context.read<AuthCubit>().registerUser(
                                      emailController.text,
                                      passwordController.text,
                                      usernameController.text,
                                      context
                                          .read<ImagePickerProvider>()
                                          .pickedFile,
                                    );
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            HaveAccountRow(
                              text1: 'Already have an account?',
                              text2: 'Sign In',
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Consumer<ImagePickerProvider>(
                    builder: (context, provider, child) {
                      return Positioned(
                          top: 125,
                          left: MediaQuery.of(context).size.width / 2.7,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              ProfileCircleAvatar(
                                  image: provider.pickedFile != null
                                      ? FileImage(
                                      File(provider.pickedFile!.path))
                                      : null),
                              Positioned(
                                right: -5,
                                bottom: -10,
                                child: GestureDetector(
                                  onTap: () {
                                    provider.pickImage();
                                  },
                                  child: ImagePickerCircleAvatar(),
                                ),
                              ),
                            ],
                          ));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


/*

Positioned(
                top: 20,
                left: 20,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Color(0xffc4c0c0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                  ),
                ),
              ),
 */
