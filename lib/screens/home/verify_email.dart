import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app2/screens/home/home_screen.dart';
import 'package:social_app2/shared/components/components.dart';
import 'package:social_app2/shared/components/constants.dart';
import 'package:social_app2/shared/cubit/app_cubit.dart';
import 'package:social_app2/shared/cubit/app_cubit_states.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppCubitStates>(
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
            ),
            body: ConditionalBuilder(
                fallback: (context) =>
                    const Center(child: HomeScreen()),
                condition: !FirebaseAuth.instance.currentUser!.emailVerified,
                builder: (context) {
                  return Column(
                    children: [
                      Container(
                        height: 50,
                        color: Colors.amber.withOpacity(0.6),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              const Icon(Icons.info_rounded),
                              const SizedBox(
                                width: 16,
                              ),
                              const Expanded(
                                  child: Text('Please verify your email')),
                              const Spacer(),
                              const SizedBox(
                                width: 20,
                              ),
                              textButton(
                                  child: const Text(
                                    'Send ',
                                    style: TextStyle(color: kPrimaryColor),
                                  ),
                                  onPressed: () {
                                    FirebaseAuth.instance.currentUser!
                                        .sendEmailVerification()
                                        .then((value) => {
                                              showToast(
                                                  message: 'Check your email',
                                                  color: Colors.green)
                                            })
                                        .catchError((error) {
                                      showToast(
                                          message: error.toString(),
                                          color: Colors.red);
                                    });
                                  })
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }),
          );
        },
        listener: (context, state) {});
  }
}
