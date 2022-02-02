import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/controllers/chat_room_controller/chat_room_bloc.dart';
import 'package:social_app/data/repository/messages_repo/messages_repository.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/utills/consistent/consistent.dart';

class ChatRoomScreen extends StatelessWidget {
  ChatRoomScreen({Key? key, required this.userModel}) : super(key: key);
  final UserModel userModel;
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ChatRoomBloc(messagesRepository: MessagesRepository())
            ..add(
              GetMessagesEvent(receiverId: userModel.uId!),
            ),
      child: Builder(builder: (context) {
        return BlocListener<ChatRoomBloc, ChatRoomState>(
          listener: (context, state) {
            if (state is ChatRoomUpdateMessages) {
              messageController.clear();
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  CircleAvatar(
                      backgroundImage: NetworkImage(userModel.profileImage!)),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Text(userModel.name!)
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: SingleChildScrollView(
                      reverse: true,
                      child: BlocBuilder<ChatRoomBloc, ChatRoomState>(
                        builder: (context, state) {
                          if (state is ChatRoomInitial) {
                            return const CircularProgressIndicator.adaptive();
                          } else if (state is ChatRoomUpdateMessages) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              itemBuilder: (context, index) {
                                MessageModel message = state.messages[index];
                                if (message.senderId == currentUserId) {
                                  return buildMyMessage(context, message);
                                } else {
                                  return buildOtherUserMessage(
                                      context, userModel, message);
                                }
                              },
                              itemCount: state.messages.length,
                            );
                          } else if (state is ChatRoomGetMessagesError) {
                            return const Center(
                              child: Text(
                                  'Something went wrong please try again later.'),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ),
                ),
                sentMessageCard(context),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget sentMessageCard(BuildContext context) {
    return BlocBuilder<ChatRoomBloc, ChatRoomState>(
      builder: (context, state) {
        return Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 20,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: messageController,
                    minLines: 1,
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: 'Write you message',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    if (messageController.text.isNotEmpty) {
                      BlocProvider.of<ChatRoomBloc>(context).add(
                        SendMessagesEvent(
                          receiverId: userModel.uId!,
                          receiverName: userModel.name!,
                          receiverToken: userModel.token!,
                          message: messageController.text,
                        ),
                      );
                    }
                  },
                  child: CircleAvatar(
                    radius: 22,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Icon(
                      FontAwesomeIcons.solidPaperPlane,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Align buildMyMessage(BuildContext context, MessageModel message) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: const BoxDecoration(
            color: Colors.deepOrangeAccent,
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(15),
              topStart: Radius.circular(15),
              bottomEnd: Radius.circular(15),
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message.message!,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOtherUserMessage(
      BuildContext context, UserModel userModel, MessageModel message) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(15),
              topEnd: Radius.circular(15),
              bottomEnd: Radius.circular(15),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              userModel.name!,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            Text(
              message.message!,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
