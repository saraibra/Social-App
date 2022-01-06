import 'dart:io';
import 'package:path/path.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app2/models/message_model.dart';
import 'package:social_app2/models/post_model.dart';
import 'package:social_app2/models/user_model.dart';
import 'package:social_app2/screens/chat/chat_screen.dart';
import 'package:social_app2/screens/feeds/feeds_screen.dart';
import 'package:social_app2/screens/new_posts/new_posts_screen.dart';
import 'package:social_app2/screens/settings/settings_screen.dart';
import 'package:social_app2/screens/users/users_screen.dart';
import 'package:social_app2/shared/components/constants.dart';
import 'package:social_app2/shared/cubit/app_cubit_states.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AppCubit extends Cubit<AppCubitStates> {
  AppCubit() : super(InitalState());
  static AppCubit get(context) => BlocProvider.of(context);
  UserModel? model;
 getUserData() {
    emit(GetUserSuccessLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) => {
              model = UserModel.fromJson(value.data()),
              emit(GetUserSuccessState()),
            })
        .catchError((error) {
      emit(GetUserErrorState(error.toString()));
    });
  }

  List<UserModel> allUsers = [];
  void getAllUsers() {
    allUsers = [];
    if (allUsers.length == 0) emit(GetAllUsersSuccessLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                if (element.data()['uid'] != uid){
                  print(element.data()['uid']);
                  allUsers.add(UserModel.fromJson(element.data()));
                  emit(GetAllUsersSuccessState());

                }
              }),
              emit(GetAllUsersSuccessState())
            })
        .catchError((error) {
      emit(GetAllUsersErrorState(error));
    });
  }

/////////// change user image and cover///////
  File? profileImage;
  final picker = ImagePicker();

  Future getProfileImage(BuildContext context) async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      if (profileImage != null) {
        uploadProfileImage();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No file was selected'),
      ));
      emit(ProfileImageErrorState('No file was selected'));
    }
  }

  File? coverImage;

  Future getCoverImage(BuildContext context) async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(ProfileCoverSuccessState());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No file was selected'),
      ));
      emit(ProfileCoverErrorState('No file was selected'));
    }
  }

  /////////////////////// upload user Image and cover////////////
  String profileImageUrl = '';
  void uploadProfileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) => {
              value.ref
                  .getDownloadURL()
                  .then((value) => {
                        profileImageUrl = value,
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(model!.uid)
                            .update({'image': profileImageUrl})
                            .then((value) => {
                                  getUserData(),
                                })
                            .catchError((error) {
                              emit(UserUpdateErrorState(error));
                            }),
                      })
                  .catchError((error) {
                emit(ProfileImageErrorState(error));
              })
            })
        .catchError((error) {
      emit(ProfileImageErrorState(error));
    });
  }

  String coverImageUrl = '';
  void uploadCoverImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) => {
              value.ref
                  .getDownloadURL()
                  .then((value) => {
                        coverImageUrl = value,
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(model!.uid)
                            .update({'cover': value})
                            .then((value) => {
                                  getUserData(),
                                })
                            .catchError((error) {
                              emit(UserUpdateErrorState(error));
                            }),
                      })
                  .catchError((error) {
                emit(ProfileCoverErrorState(error));
              })
            })
        .catchError((error) {
      emit(ProfileCoverErrorState(error));
    });
  }

  ///////////////////// update user's data ///////////////
  UserModel? userModel;

  void updateUserData({required name, required phone, required bio}) {
    userModel = UserModel(
        name: name,
        phone: phone,
        email: model!.email,
        uid: model!.uid,
        image: model!.image,
        cover: model!.cover,
        bio: bio,
        isEmailVerified: true);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .update(userModel!.toMap())
        .then((value) => {
              getUserData(),
            })
        .catchError((error) {
      emit(UserUpdateErrorState(error));
    });
  }

//////////////////// create post ///////////////////
  File? postImage;

  Future getPostImage(BuildContext context) async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostImageSuccessState());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No file was selected'),
      ));
      emit(PostImageErrorState('No file was selected'));
    }
  }

  void uploadPostImage({required String dateTime, required String text}) {
    emit(CreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) => {
              value.ref
                  .getDownloadURL()
                  .then((value) => {
                        createNewPost(
                            dateTime: dateTime, text: text, postImage: value)
                      })
                  .catchError((error) {
                emit(CreatePostErrorState(error));
              })
            })
        .catchError((error) {
      emit(CreatePostErrorState(error));
    });
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImageSuccessState());
  }

  void createNewPost(
      {required String dateTime, required String text, String? postImage}) {
    emit(CreatePostLoadingState());

    PostModel postModel = PostModel(
        name: model!.name,
        uid: model!.uid,
        image: model!.image,
        text: text,
        dateTime: dateTime,
        postImage: postImage ?? '');
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) => {emit(CreatePostSuccessState())})
        .catchError((error) {
      emit(CreatePostErrorState(error));
    });
  }

  ///////// get posts ///////
  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

 getPosts() {
    emit(GetPostsSuccessLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                element.reference
                    .collection('likes')
                    .get()
                    .then((value) => {
                          likes.add(value.docs.length),
                          postsId.add(element.id),
                          posts.add(PostModel.fromJson(element.data())),

                  emit(GetPostsSuccessState())

                })
                    .catchError((error) {});
              }),
              emit(GetPostsSuccessState())
            })
        .catchError((error) {
      emit(GetPostsErrorState(error));
    });
  }

  ////// like posts //////
  void likePosts(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uid)
        .set({'like': true})
        .then((value) => {emit(LikePostsSuccessState())})
        .catchError((error) {
          emit(LikePostsErrorState(error));
        });
  }
////////////////////// send messags/////////

  void sendMessage({
    required String recieverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel messageModel = MessageModel(
        text: text,
        recieverId: recieverId,
        dateTime: dateTime,
        senderId:uid);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) => {emit(SendMessageSuccessState())})
        .catchError((error) {
      emit(SendMessageErrorState(error));
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(recieverId)
        .collection('chats')
        .doc(userModel!.uid)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) => {emit(SendMessageSuccessState())})
        .catchError((error) {
      emit(SendMessageErrorState(error));
    });
  }

//////////// get chat  messages /////////
  List<MessageModel> messages = [];
  void getMessages({
    required String recieverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
       // emit(GetMessagesSuccessState());

      });
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(recieverId)
        .collection('chats')
        .doc(uid)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
        //emit(GetMessagesSuccessState());

      });

    });
    emit(GetMessagesSuccessState());

  }

/////////////////////////////////////////////////////
  int currentIndex = 0;
  List<Widget> screens = [
    const FeedsScreen(),
    const ChatScreen(),
    const NewPostScreen(),
    const UsersScreen(),
    const SettingsScreen()
  ];
  List<String> titles = ['New Feeds', 'Chats', 'Post', 'Friends', 'Settings'];
  void changeCurrentIndex(int index) {
    if (index == 1) getAllUsers();
    if (index == 2) {
      emit(NewPostState());
    } else {
      currentIndex = index;
      emit(ChangeBottomNavState());
    }
  }
}
