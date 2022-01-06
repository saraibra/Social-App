import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app2/models/post_model.dart';
import 'package:social_app2/models/user_model.dart';
import 'package:social_app2/shared/cubit/app_cubit.dart';
import 'package:social_app2/shared/cubit/app_cubit_states.dart';
import 'package:social_app2/shared/style/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..getUserData()
        ..getPosts(),
      child: BlocConsumer<AppCubit, AppCubitStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition: AppCubit.get(context).posts.length > 0 &&
                  AppCubit.get(context).model != null,
              fallback: (context) =>
                  Center(child: const CircularProgressIndicator()),
              builder: (context) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: const Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 10,
                          margin: EdgeInsets.all(8.0),
                          child: Image(
                              fit: BoxFit.cover,
                              height: 200,
                              image: NetworkImage(
                                  'https://image.freepik.com/free-photo/joyful-black-author-works-writing-new-book-readers_273609-28047.jpg')),
                        ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => buildPost(
                            AppCubit.get(context).posts[index], context, index),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 8.0,
                        ),
                        itemCount: AppCubit.get(context).posts.length,
                      ),
                      SizedBox(height: 8)
                    ],
                  ),
                );
              });
        },
      ),
    );
  }

  Widget buildPost(PostModel model, BuildContext context, index) => Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage('${model.image}'),
              ),
              const SizedBox(width: 15),
              Expanded(
                  child: Column(
                children: [
                  Row(
                    children: [
                      Text('${model.name}'),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.check_circle_outline,
                        color: Colors.blueAccent,
                        size: 16,
                      )
                    ],
                  ),
                  Text('${model.dateTime}')
                ],
              )),
              const SizedBox(width: 15),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    size: 16,
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          Text('${model.text}'),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 10.0),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 8.0),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //                 minWidth: 1.0,
          //                 padding: EdgeInsets.zero,
          //                 onPressed: () {},
          //                 child: const Text('#Software',
          //                     style: TextStyle(color: Colors.blue))),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 8.0),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //                 minWidth: 1.0,
          //                 padding: EdgeInsets.zero,
          //                 onPressed: () {},
          //                 child: const Text('#Software',
          //                     style: TextStyle(color: Colors.blue))),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 8.0),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //                 minWidth: 1.0,
          //                 padding: EdgeInsets.zero,
          //                 onPressed: () {},
          //                 child: const Text('#Software',
          //                     style: TextStyle(color: Colors.blue))),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 8.0),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //                 minWidth: 1.0,
          //                 padding: EdgeInsets.zero,
          //                 onPressed: () {},
          //                 child: const Text('#Software',
          //                     style: TextStyle(color: Colors.blue))),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          if (model.postImage != '')
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 15.0),
              child: Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage('${model.postImage}')),
                  )),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      AppCubit.get(context)
                          .likePosts(AppCubit.get(context).postsId[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          const Icon(IconBroken.Heart,
                              color: Colors.red, size: 16),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${AppCubit.get(context).likes[index]}',
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(IconBroken.Chat,
                              color: Colors.orangeAccent, size: 16),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '120 comment',
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(
                            '${AppCubit.get(context).model!.image}'),
                      ),
                      SizedBox(width: 15),
                      Text('Write a comment ......')
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  children: const [
                    Icon(IconBroken.Heart, color: Colors.red, size: 16),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Like',
                    )
                  ],
                ),
              ),
            ],
          )
        ]),
      ));
}
