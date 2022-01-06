import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app2/shared/components/components.dart';
import 'package:social_app2/shared/components/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
enum AppState {
  free,
  picked,
  
}

class _ProfileScreenState extends State<ProfileScreen> {
    AppState? state;
    String? uid = FirebaseAuth.instance.currentUser?.uid;
  File? _image;
final picker = ImagePicker();

   Future getImage(BuildContext context) async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(
          pickedFile.path);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('No file was selected'),
        ));
      }
    });
  }
 @override
  void initState() {
    state = AppState.free;
    super.initState();
    
  }

  Future uploadPic(BuildContext context) async {
    String fileName = basename(_image!.path);

    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask storageUploadTask = storageReference.putFile(_image!);
    TaskSnapshot taskSnapshot = await storageUploadTask;
    String uri = await taskSnapshot.ref.getDownloadURL();

    FirebaseFirestore.instance.collection('users').doc(uid).update({
      'image': uri,
    });
   
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:  Text('Profile picture updated!'),
      ));
  
  }

final globalScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
 void getImage(BuildContext context) async {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.camera,
                ),
                onPressed: () async {
                  XFile? pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);

                  setState(() {
                    if (pickedFile != null) {
                      state = AppState.picked;

                      _image = File(pickedFile.path);

                    } else {
                    }
                  });
                    if (state == AppState.picked) uploadPic(context);
                  
                }),
            IconButton(
                icon: Icon(
                  Icons.camera_alt,
                ),
                onPressed: () async {
                  XFile? pickedFile =
                      await picker.pickImage(source: ImageSource.camera);

                  setState(() {
                    if (pickedFile != null) {
                      state = AppState.picked;

                      _image = File(pickedFile.path);
                    } else {
                      print('No image selected.');
                    }
                  });
                  if (pickedFile != null) {
                    if (state == AppState.picked) uploadPic(context);
                  }
                }),
          ],
        ),
      ));
    }

    return Scaffold(
                key: globalScaffoldKey,
        appBar: AppBar(title: const Text('Profile ')),
        body: Builder(
            builder: (BuildContext context) => Container(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(uid)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        //  print( snapshot.data['image']);
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }

                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(
                                    radius: 55,
                                    child: ClipOval(
                                      child: SizedBox(
                                          width: 110,
                                          height: 110,
                                          child: Image.network(
                                              snapshot.data['image'],
                                              fit: BoxFit.fill)),
                                    ),
                                  ),
                                  IconButton(
                                      icon: const Icon(
                                        Icons.camera_alt,
                                        size: 36,
                                        //  color: color2,
                                      ),
                                      onPressed: () {
                                              if (state ==
                                                          AppState.free)
                                                        getImage(context);
                                                    
                                      })
                                ],
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.person_pin,
                                  size: 32,
                                ),
                                title: const Text(
                                  "Name",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 4.0,
                                  ),
                                  child: Text(
                                    snapshot.data['name'],
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                ),
                                trailing: IconButton(
                                    onPressed: () => showDialog<AlertDialog>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          TextEditingController nameController =
                                              TextEditingController();
                                          var formKey = GlobalKey<FormState>();
                                          String? uid = FirebaseAuth
                                              .instance.currentUser?.uid;
                                          Size size =
                                              MediaQuery.of(context).size;
                                          return AlertDialog(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0))),
                                              actionsPadding:
                                                  const EdgeInsets.only(
                                                      bottom: 16),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      top: 32),
                                              content: Container(
                                                width: size.width - 64,
                                                height: 120,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 24.0),
                                                  child: Container(
                                                    height: 70,
                                                    child: Form(
                                                      key: formKey,
                                                      child: Column(
                                                        children: <Widget>[
                                                          const Text(
                                                            "UPDATE USER NAME",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color:
                                                                    kPrimaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          const SizedBox(
                                                              height: 16),
                                                          Container(
                                                            height: 70,
                                                            child:
                                                                buildTextFormField(
                                                                //  initialValue:'',
                                                                    size: size,
                                                                    controller:
                                                                        nameController,
                                                                    type: TextInputType
                                                                        .name,
                                                                    validate:
                                                                        (String
                                                                            value) {
                                                                      if (value
                                                                          .isEmpty) {
                                                                        return 'Please enter your name ';
                                                                      }
                                                                    },
                                                                    label:
                                                                        'Name',
                                                                    icon:Icon( Icons
                                                                        .person)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              actions: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 16.0),
                                                  child: IconButton(
                                                      icon: const Icon(
                                                        Icons.check,
                                                        color: kPrimaryColor,
                                                      ),
                                                      onPressed: () {
                                                        if (formKey
                                                            .currentState!
                                                            .validate()) {
                                                          try {
                                                            
                                                            // Navigator.of(context).pop();
                                                            Navigator.pop(
                                                                context);
                                                          } catch (e) {}
                                                        }
                                                      }),
                                                ),
                                                SizedBox(
                                                  width: 130,
                                                ),
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.close,
                                                  ),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                )
                                              ]);
                                        }),
                                    icon: const Icon(Icons.edit)),
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.email,
                                  size: 32,
                                ),
                                title: const Text(
                                  "Email",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 4.0,
                                  ),
                                  child: Text(
                                    snapshot.data['email'],
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                ),
                              )
                            ],
                          );
                        }
                      }),
                )));
  }

  updateName(BuildContext context) async {
    showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) {
          TextEditingController nameController = TextEditingController();
          var formKey = GlobalKey<FormState>();
          String? uid = FirebaseAuth.instance.currentUser?.uid;
          Size size = MediaQuery.of(context).size;
          return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              actionsPadding: const EdgeInsets.only(bottom: 16),
              contentPadding: const EdgeInsets.only(top: 32),
              content: Container(
                width: size.width - 64,
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Container(
                    height: 70,
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          const Text(
                            "UPDATE USER NAME",
                            style: TextStyle(
                                fontSize: 16,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            height: 70,
                            child: buildTextFormField(
                                                       // initialValue:'',

                                size: size,
                                controller: nameController,
                                type: TextInputType.name,
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your name ';
                                  }
                                },
                                label: 'Name',
                                icon:Icon (Icons.person)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: IconButton(
                      icon: const Icon(
                        Icons.check,
                        color: kPrimaryColor,
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          try {
                           
                            // Navigator.of(context).pop();
                          } catch (e) {}
                        }
                      }),
                ),
                const SizedBox(
                  width: 130,
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                  ),
                  onPressed: () => Navigator.pop(context),
                )
              ]);
        });
  }


  

}
