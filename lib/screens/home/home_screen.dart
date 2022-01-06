import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app2/screens/new_posts/new_posts_screen.dart';
import 'package:social_app2/shared/components/components.dart';
import 'package:social_app2/shared/components/constants.dart';
import 'package:social_app2/shared/cubit/app_cubit.dart';
import 'package:social_app2/shared/cubit/app_cubit_states.dart';
import 'package:social_app2/shared/style/icon_broken.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppCubitStates>(
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          cubit.getPosts();
          return Scaffold(
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(IconBroken.Notification)),
                IconButton(
                    onPressed: () {}, icon: const Icon(IconBroken.Search)),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Chat), label: 'Chat'),
                      BottomNavigationBarItem(
                    icon: Icon(IconBroken.Paper_Upload), label: 'Add Post'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Location), label: 'Users'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Setting), label: 'Settings'),
              ],
              onTap: (index) {
                cubit.changeCurrentIndex(index);
              },
              currentIndex: cubit.currentIndex,
            ),
          );
        },
        listener: (context, state) {
          if(state is NewPostState){
            navigateTo(context, NewPostScreen());
          }
        });
  }
}
