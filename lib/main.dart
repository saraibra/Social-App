// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app2/screens/home/home_screen.dart';
import 'package:social_app2/screens/login_screen/login_cubit/cubit.dart';
import 'package:social_app2/screens/sign_up/cubit/signup_cubit.dart';
import 'package:social_app2/screens/welcome/welcome.dart';
import 'package:social_app2/shared/components/constants.dart';
import 'package:social_app2/shared/cubit/app_cubit.dart';
import 'package:social_app2/shared/network/cashe_helper.dart';

void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  Widget startWidget;
  await CasheHelper.init();
   uid  = CasheHelper.getData(key:'uid');
  if(uid != null){
    startWidget = const HomeScreen();
  }
  else{
    startWidget = const WelcomeScreen();
  }
  runApp( MyApp(startWidget:startWidget ,));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key, this.startWidget}) : super(key: key);
     final Widget startWidget;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
       BlocProvider(
        create: (BuildContext context) => RegisterCubit()),
         BlocProvider(
        create: (BuildContext context) => LoginCubit()),
        BlocProvider(
        create: (BuildContext context) => AppCubit()..getUserData()..getPosts()),
      ],
    child: MaterialApp(
                      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      theme: ThemeData(
                    scaffoldBackgroundColor: Colors.white,
                    textTheme: const TextTheme(
                      bodyText1: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                      bodyText2: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                      headline1: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    appBarTheme: const AppBarTheme(
                        titleSpacing: 20,
                        backgroundColor: Colors.white,
                        elevation: 0,
                        titleTextStyle:
                            TextStyle(color: Colors.black, fontSize: 20),
                        iconTheme: IconThemeData(color: Colors.black),
                        systemOverlayStyle: SystemUiOverlayStyle(
                            statusBarColor: Colors.white,
                            statusBarIconBrightness: Brightness.dark)),
                    primarySwatch: Colors.purple,
                    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                        type: BottomNavigationBarType.fixed,
                        selectedItemColor: Colors.purple,
                        elevation: 20)),
      home: startWidget,
    ));
  }
}

  