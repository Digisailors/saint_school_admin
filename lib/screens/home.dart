import 'package:flutter/material.dart';
import 'package:school_app/controllers/session_controller.dart';
import 'package:school_app/screens/dashboard.dart';
import 'package:school_app/screens/student_form.dart';
import 'package:school_app/widgets/sidebar.dart';

import 'student_list.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final pages = [
    Dashboard(),
    StudentList(),
    const StudentForm(formMode: FormMode.add),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Expanded(
          child: SideMenu(),
          flex: 1,
        ),
        Expanded(
            flex: 5,
            child: PageView.builder(
                controller: session.controller,
                itemCount: pages.length,
                itemBuilder: ((context, index) => pages[index])))
      ],
    ));
  }
}
