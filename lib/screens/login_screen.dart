import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_chat_app/screens/home_screen.dart';
import 'package:my_chat_app/utils/app_colors.dart';
import 'package:my_chat_app/widgets/custome_button.dart';
import 'package:my_chat_app/widgets/custome_text_field.dart';
import 'package:my_chat_app/widgets/have_account_row.dart';
import 'package:provider/provider.dart';
import '../cubits/auth_cubit/auth_cubit.dart';
import '../provider/password_visibility_provider.dart';
import '../widgets/profile_circle_avatar.dart';
import '../widgets/snackbar.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: context.watch<AuthCubit>().isLoading,
          child: SingleChildScrollView(
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
                          'Welcome Back',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Sign in to your account',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
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
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
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
                              'Sign in',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary),
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
                              height: 20,
                            ),
                            BlocConsumer<AuthCubit, AuthState>(
                              listener: (context, state) {
                                if (state is AuthSuccess) {
                                  showSnackBar(context, 'Login Successfully');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return HomeScreen(
                                          currentUser: state.user,
                                        );
                                      },
                                    ),
                                  );
                                } else if (state is AuthFailure) {
                                  showSnackBar(context, state.error);
                                }
                              },
                              builder: (context, state) {
                                return CustomeButton(
                                  text: 'Sign In',
                                  onTap: () async {
                                    if (formKey.currentState!.validate()) {
                                      context.read<AuthCubit>().loginUser(
                                        emailController.text,
                                        passwordController.text,
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            HaveAccountRow(
                              text1: 'Don’t have an account?',
                              text2: 'Register',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return RegisterScreen();
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 125,
                    left: MediaQuery.of(context).size.width / 2.7,
                    child: ProfileCircleAvatar(),
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
