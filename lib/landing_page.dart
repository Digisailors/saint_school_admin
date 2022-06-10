import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/controllers/auth_controller.dart';
import 'package:school_app/screens/carousel.dart';
import 'package:school_app/screens/home.dart';
import 'package:school_app/screens/log_in.dart';
import 'package:school_app/screens/student_form.dart';
import 'package:school_app/screens/studentform.dart';
import 'package:school_app/screens/test2.dart';
import 'package:school_app/screens/testscreen.dart';

import 'controllers/class_controller.dart';
import 'controllers/session_controller.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active && snapshot.hasData) {
          Get.put(MySession());
          Get.put(ClassController());

          return  Home( );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const LoginPage();
      },
    );
  }
}
