import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app2/models/message_model.dart';
import 'package:social_app2/models/user_model.dart';
import 'package:social_app2/shared/components/constants.dart';
import 'package:social_app2/shared/cubit/app_cubit.dart';
import 'package:social_app2/shared/cubit/app_cubit_states.dart';
import 'package:social_app2/shared/style/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  ChatDetailsScreen({Key? key, required this.userModel}) : super(key: key);
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();

      return BlocConsumer<AppCubit, AppCubitStates>(
          builder: (context, state) {
            AppCubit.get(context).getUserData();
            AppCubit.get(context).getMessages(recieverId: userModel.uid!);

            return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0.0,
                  title: Row(
                    children:  [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(userModel.image!),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(userModel.name!)
                    ],
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Container(
                        height:MediaQuery.of(context).size.height*0.7,
                        width:MediaQuery.of(context).size.width ,
                        child: ConditionalBuilder(
                          fallback: (context) => Center(
                            child: Container(),
                          ),
                          condition: AppCubit.get(context).messages.length > 0,
                          builder: (context) {
                            return  Padding(
                                padding: const EdgeInsets.all(10.0),

                                      child: ListView.separated(
                                        physics: BouncingScrollPhysics(),
                                        itemBuilder: (BuildContext context, int index) {
                                          var message = AppCubit
                                              .get(context)
                                              .messages[index];
                                          if (uid == message.senderId) {
                                            return buildMessage(message);
                                          }
                                            return buildFriendMessage(message);

                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index)=>SizedBox(
                                              height: 15,
                                            ),
                                        itemCount:  AppCubit.get(context).messages.length,
                                      ),





                            );
                          },
                        ),
                      ),
                      Spacer(),
                      Container(
                        height:MediaQuery.of(context).size.height*0.08,
                        width:MediaQuery.of(context).size.width ,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 1),
                          color: Colors.grey[200],
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                  controller: messageController,
                                  decoration:  const InputDecoration(
                                    contentPadding:  EdgeInsets.all(6.0),
                                      border: InputBorder.none,
                                      hintText: 'Type your message here')),
                            ),
                            MaterialButton(
                                height: 40,
                                onPressed: () {
                                  AppCubit.get(context).sendMessage(
                                      recieverId: userModel.uid!,
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text);
                                },
                                child: const Icon(
                                  IconBroken.Send,
                                  size: 16,
                                  color: Colors.black,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ));
          },
          listener: (context, state) {});

  }

  Widget buildFriendMessage(MessageModel model) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10),
                topEnd: Radius.circular(10),
                topStart: Radius.circular(10),
              )),
          child:  Text(model.text!)),
    );
  }

  Widget buildMessage(MessageModel model) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: const BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10),
                topEnd: Radius.circular(10),
                topStart: Radius.circular(10),
              )),
          child:  Text(model.text!,
          style: TextStyle(color: Colors.white),
          ),

      ),
    );
  }
}
