import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_app/controllers/session_controller.dart';
import 'package:school_app/auth_router.dart';
import 'package:school_app/models/session.dart';
import 'package:school_app/screens/landing_page.dart.dart';
import 'package:school_app/screens/log_in.dart';
import 'package:school_app/screens/student_list.dart';

import 'controllers/auth_controller.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthController());
  Get.put(SessionController(MySession()));
  runApp(const AuthRouter());
}
