import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/controllers/auth_controller.dart';
import 'package:school_app/controllers/parent_controller.dart';
import 'package:school_app/controllers/student_controller.dart';
import 'package:school_app/models/biodata.dart';
import 'package:school_app/models/session.dart';
import 'package:school_app/models/student.dart';
import 'package:school_app/screens/Form/student_form.dart';
import 'package:school_app/screens/carousel.dart';
import 'package:school_app/screens/dashboard.dart';
import 'package:school_app/screens/landing_page.dart.dart';
import 'package:school_app/screens/list/list.dart';
import 'package:school_app/screens/log_in.dart';
import 'package:school_app/widgets/theme.dart';

import 'constants/get_constants.dart';
import 'controllers/class_controller.dart';
import 'controllers/session_controller.dart';
import 'controllers/teacher_controller.dart';

class AuthRouter extends StatelessWidget {
  const AuthRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active && snapshot.hasData) {
          Get.put(SessionController(MySession()));
          Get.put(ClassController());
          ParentController.listenParents();
          StudentController.listenStudents();
          TeacherController.listenTeachers();
          return GetMaterialApp(
            scrollBehavior: MyCustomScrollBehavior(),
            defaultTransition: Transition.leftToRight,
            theme: ThemeData(
              listTileTheme: const ListTileThemeData(),
              pageTransitionsTheme: const PageTransitionsTheme(builders: {
                TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
                TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
              }),
              colorScheme: lightColorScheme,
              textTheme: myTexTheme,
              tabBarTheme: TabBarTheme(
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 4.0, color: getColor(context).tertiary),
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: lightColorScheme.secondaryContainer,
                elevation: 3,
              ),
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.blue,
            ),
            transitionDuration: const Duration(microseconds: 0),
            builder: (context, child) {
              return Overlay(
                initialEntries: [
                  OverlayEntry(builder: (context) {
                    return LandingPage(child: child ?? Container());
                  })
                ],
              );
            },
            onGenerateRoute: (settings) {
              if (settings.name == EntityList.routeName) {
                final args = settings.arguments as EntityType;
                return MaterialPageRoute(builder: (context) => EntityList(entityType: args));
              }
              if (settings.name == StudentForm.routeName) {
                final args = settings.arguments as Student?;
                return MaterialPageRoute(builder: (context) => StudentForm(student: args));
              }
              if (settings.name == Dashboard.routeName) {
                final args = settings.arguments as Student?;
                return MaterialPageRoute(builder: (context) => const Dashboard());
              }
            },
            routes: {
              '/Carousel': (context) => const Carousel(),
              Dashboard.routeName: (context) => const Dashboard(),
              '/': (context) => const Dashboard(),
            },
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return MaterialApp(
          theme: ThemeData(
            colorScheme: lightColorScheme,
            textTheme: myTexTheme,
            tabBarTheme: TabBarTheme(
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 4.0, color: getColor(context).tertiary),
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: lightColorScheme.secondaryContainer,
              elevation: 3,
            ),
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          home: const LoginPage(),
        );
      },
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
