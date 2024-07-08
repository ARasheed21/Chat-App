import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_chat_app/cubits/add_message_cubit/add_message_cubit.dart';
import 'package:my_chat_app/models/user_model.dart';
import 'package:my_chat_app/screens/users_screen.dart';
import 'package:my_chat_app/utils/app_colors.dart';
import 'package:my_chat_app/widgets/chat_listile.dart';
import 'package:my_chat_app/widgets/drawer.dart';
import 'package:my_chat_app/widgets/favourite_container.dart';
import '../cubits/chat_cubit/chat_cubit.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, required this.currentUser});

  final UserModel currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 30,
          backgroundColor: AppColors.primary,
          centerTitle: true,
          //elevation: 0,
          title: Text(
            'Chat App',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 25,
              color: Colors.white,
              fontFamily: 'Roboto',
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return UsersScreen();
                    },
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 25,
                  weight: 10,
                ),
              ),
            ),
          ],
        ),
        drawer: DrawerList(
          currentUser: currentUser,
        ),
        backgroundColor: AppColors.primary,
        body: BlocProvider(
          create: (context) => ChatCubit()..fetchChat(),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              children: [
                // const SizedBox(
                //   height: 10,
                // ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width,
                //   height: 200,
                //   child: ListView.separated(
                //     padding: EdgeInsets.only(bottom: 20),
                //     //shrinkWrap: true,
                //     scrollDirection: Axis.horizontal,
                //     itemBuilder: (context, i) {
                //       return FavouriteContainer();
                //     },
                //     separatorBuilder: (context, i) {
                //       return SizedBox(
                //         width: 20,
                //       );
                //     },
                //     itemCount: 5,
                //   ),
                // ),
                BlocListener<AddMessageCubit, AddMessageState>(
                  listener: (context, state) {
                    if (state is UpdateChat){
                      context.read<ChatCubit>().updateChat(state.updatedChat);
                    }
                  },
                  child: BlocBuilder<ChatCubit, ChatState>(
                    builder: (context, state) {
                      if (state is ChatLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is ChatError) {
                        return Center(
                          child: Text(state.error),
                        );
                      } else if (state is ChatSuccess) {
                        if (state.chats.isEmpty) {
                          return Center(
                            child: Text("No chats yet",style: TextStyle(color: Colors.white),),
                          );
                        }
                        return Expanded(
                          child: ListView.builder(
                            itemCount: state.chats.length,
                            itemBuilder: (context, i) {
                              return Slidable(
                                endActionPane: ActionPane(
                                  motion: const StretchMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (BuildContext context) {
                                        context
                                            .read<ChatCubit>()
                                            .deleteChat(state.chats[i].chatId);
                                      },
                                      backgroundColor: AppColors.orange,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete_outline_rounded,
                                      label: 'Delete',
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ],
                                ),
                                child: ChatLisTile(chat: state.chats[i]),
                              );
                            },
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
