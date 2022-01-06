import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app2/models/user_model.dart';
import 'package:social_app2/screens/chat/chat_details_screen.dart';
import 'package:social_app2/shared/components/components.dart';
import 'package:social_app2/shared/cubit/app_cubit.dart';
import 'package:social_app2/shared/cubit/app_cubit_states.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppCubitStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.allUsers.length>0,
            builder: (context)=>ListView.separated(
              physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildChatItem( cubit.allUsers[index],context),
                separatorBuilder: (context, index) => const Divider(
                      color: Colors.grey,
                    ),
                itemCount:  cubit.allUsers.length),
                fallback: (context)=>const Center(
                  child: CircularProgressIndicator(),
                ),

   );
        },

    );
  }

  Widget buildChatItem(UserModel model,context) => InkWell(
    onTap: (){
    navigateTo(context, ChatDetailsScreen(userModel: model,));  
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage('${model.image}'),
              ),
              const SizedBox(width: 15),
                                Text('${model.name}'),
  
  ],
          ),
    ),
  );
}
