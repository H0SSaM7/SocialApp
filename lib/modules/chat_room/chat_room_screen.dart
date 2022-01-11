import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class ChatRoomScreen extends StatelessWidget {
  const ChatRoomScreen({Key? key, required this.userModel}) : super(key: key);
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    var messageController = TextEditingController();
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialSuccessSendMessagesToOtherState) {
          messageController.text = '';
        }
      },
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        return Scaffold(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Column(
                  children: [
                    buildOtherUserMessage(context, userModel),
                    buildMyMessage(context),
                  ],
                ),
              ),
              const Spacer(),
              Card(
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
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Write you message',
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (messageController.text.isNotEmpty) {
                            cubit.sendMessages(
                                receiverId: userModel.uId!,
                                message: messageController.text,
                                date: DateTime.now().toString());
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
              ),
            ],
          ),
        );
      },
    );
  }
}

Align buildMyMessage(BuildContext context) {
  return Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      margin: const EdgeInsets.only(top: 10),
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: const BoxDecoration(
          color: Colors.deepOrangeAccent,
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(15),
            topStart: Radius.circular(15),
            bottomEnd: Radius.circular(15),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'lfsdf ksdfjk jdkf ksdfjsdklfjl ksdjfkl sjdlkfj ',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    ),
  );
}

Widget buildOtherUserMessage(BuildContext context, UserModel userModel) {
  return Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      margin: const EdgeInsets.only(top: 10),
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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
          Text(userModel.name!,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  )),
          const Text(
            'hello Wold dskfjls djflk sjdlfjl sjl',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
}
