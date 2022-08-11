import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/controllers/Attendance%20API/trnasaction_controller.dart';
import 'package:school_app/controllers/attendance_controller.dart';
import 'package:school_app/controllers/Attendance%20API/department_controller.dart';
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
  // FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
  Get.put(SessionController(MySession()));
  Get.put(AuthController());

  await AttendanceController.loadToken();
  Get.put(TransactionController());
  Get.put(DepartmentController());
  if (auth.currentUser != null) {
    await auth.reloadClaims();
  }
  // ignore: avoid_print
  print("\x1B[2J\x1B[0;0H");
  runApp(const AuthRouter());
}
