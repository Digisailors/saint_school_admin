import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/controllers/attendance_controller.dart';
import 'package:school_app/controllers/department_controller.dart';
import 'package:school_app/controllers/session_controller.dart';
import 'package:school_app/auth_router.dart';
import 'package:school_app/models/session.dart';

import 'controllers/auth_controller.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
  Get.put(SessionController(MySession()));
  Get.put(AuthController());

  await AttendanceController.loadToken();
  Get.put(DepartmentController());
  if (auth.currentUser != null) {
    await auth.reloadClaims();
  }
  runApp(const AuthRouter());
}
