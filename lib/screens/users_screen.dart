import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_chat_app/widgets/chat_listile.dart';

import '../cubits/user_cubit/user_cubit.dart';
import '../utils/app_colors.dart';
import '../widgets/search_bar.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 8.0),
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UsersSuccess) {
                return Column(
                  children: [
                    SearchBar(
                      hintText: 'Search...',
                      onChanged: (data) {
                        context.read<UserCubit>().filterUsers(data);
                      },
                      controller: controller,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.users.length,
                        itemBuilder: (context, i) {
                          return UserLisTile(
                            user: state.users[i],
                            chatId: generateChatId(FirebaseAuth.instance.currentUser!.email!,state.users[i].id),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else if (state is UsersLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is UsersError) {
                return Center(child: Text(state.message));
              } else {
                return SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }

  String generateChatId(String email1, String email2) {
    List<String> emails = [email1, email2];
    emails.sort(); // Sort emails alphabetically
    return '${emails[0]}-${emails[1]}';
  }
}
