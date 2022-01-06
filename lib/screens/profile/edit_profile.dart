import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app2/models/user_model.dart';
import 'package:social_app2/shared/components/components.dart';
import 'package:social_app2/shared/cubit/app_cubit.dart';
import 'package:social_app2/shared/cubit/app_cubit_states.dart';
import 'package:social_app2/shared/style/icon_broken.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<AppCubit, AppCubitStates>(
        builder: (context, state) {
          UserModel? model = AppCubit.get(context).model;
          var profileImage = AppCubit.get(context).profileImage;
          var coverImage = AppCubit.get(context).coverImage;

          nameController.text = model!.name!;
          bioController.text = model.bio!;
          phoneController.text = model.phone!;

          return Scaffold(
            appBar: defaultAppBar(
                context: context,
                title: 'Edit Profile',
                actions: [
                  TextButton(
                      onPressed: () {
                        AppCubit.get(context).updateUserData(
                            name: nameController.text,
                            phone: phoneController.text,
                            bio: bioController.text);
                      },
                      child: const Text('UPDATE')),
                  const SizedBox(
                    width: 15,
                  )
                ]),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children:  [
               if(state is UserUpdateLoadingState)const LinearProgressIndicator(),
                  const SizedBox(height: 10,),
                  Container(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    AppCubit.get(context)
                                        .getCoverImage(context);
                                  },
                                  icon: const CircleAvatar(
                                      radius: 20,
                                      child: Icon(
                                        IconBroken.Camera,
                                        size: 16,
                                      ))),
                              Container(
                                  height: 140,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: coverImage == null
                                            ? NetworkImage('${model.cover}')
                                            : FileImage(coverImage)
                                                as ImageProvider),
                                  )),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            IconButton(
                                onPressed: () {
                                  AppCubit.get(context)
                                      .getProfileImage(context);
                                },
                                icon: const CircleAvatar(
                                    radius: 20,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 16,
                                    ))),
                            CircleAvatar(
                              radius: 64,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${model.image}')
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  buildTextFormField(
                    controller: nameController,
                    label: 'Name',
                    icon:Icon( IconBroken.User),
                   // initialValue: '${model.name}',
                    size: size,
                    type: TextInputType.name,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Name must not be empty ';
                      }
                      return null;
                    },
                  ),
                  buildTextFormField(
                    controller: bioController,
                    label: 'Bio',
                    icon: Icon( IconBroken.Info_Circle),
                    size: size,
                    type: TextInputType.text,
                   // initialValue: '${model.bio}',
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your bio ';
                      }
                      return null;
                    },
                  ),
                  buildTextFormField(
                    controller: phoneController,
                    label: 'Phone',
                    icon:Icon( IconBroken.Call),
                    size: size,
                    type: TextInputType.phone,
                    //initialValue: '${model.phone}',
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your phone ';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
