import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app2/shared/components/components.dart';
import 'package:social_app2/shared/cubit/app_cubit.dart';
import 'package:social_app2/shared/cubit/app_cubit_states.dart';
import 'package:social_app2/shared/style/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController postController = TextEditingController();
    return BlocConsumer<AppCubit, AppCubitStates>(
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        appCubit.getUserData();
        var now = DateTime.now();
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Create Post', actions: [
            TextButton(
                onPressed: () {
                  if (appCubit.postImage == null) {
                    appCubit.createNewPost(
                        dateTime: now.toString(), text: postController.text);
                  } else {
                    appCubit.uploadPostImage(
                        dateTime: now.toString(), text: postController.text);
                  }
                },
                child: const Text('Post'))
          ]),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is CreatePostLoadingState)
                  const LinearProgressIndicator(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          'https://image.freepik.com/free-photo/portrait-fair-haired-beautiful-female-woman-with-broad-smile-thumbs-up_176420-14970.jpg'),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Text('${appCubit.model!.name}'),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: postController,
                    decoration: const InputDecoration(
                        hintText: 'What\'s on your mind?',
                        border: InputBorder.none),
                  ),
                ),
                const SizedBox(height: 20),
                if (appCubit.postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      IconButton(
                          onPressed: () {
                            AppCubit.get(context).removePostImage();
                          },
                          icon: const CircleAvatar(
                              radius: 20,
                              child: Icon(
                                Icons.close,
                                size: 16,
                              ))),
                      Container(
                          height: 140,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(appCubit.postImage!)),
                          )),
                    ],
                  ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            appCubit.getPostImage(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(IconBroken.Image),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Add Photos')
                            ],
                          )),
                    ),
                    const Expanded(child: Text('#tags')),
                  ],
                )
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
