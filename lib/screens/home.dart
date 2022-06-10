import 'package:flutter/material.dart';
import 'package:school_app/constants/get_constants.dart';
import 'package:school_app/controllers/session_controller.dart';
import 'package:school_app/screens/dashboard.dart';
import 'package:school_app/screens/student_form.dart';
import 'package:school_app/screens/studentform.dart';
import 'package:school_app/widgets/responsivewidget.dart';
import 'package:school_app/widgets/sidebar.dart';
import 'package:school_app/widgets/theme.dart';

import 'student_list.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final pages = [
    // const Dashboard(),
    const StudentForm(),

    const Dashboard(),
  ];

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: Scaffold(
          backgroundColor: Colors.purple,
          appBar: AppBar(),


          drawer: SideMenu(),

          body: PageView.builder(
              controller: session.controller,
              itemCount: pages.length,
              itemBuilder: ((context, index) => pages[index])),
        ),
        desktop: Scaffold(
          appBar: AppBar(



            actions: [
              
              
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(onPressed: (){}, icon: Icon(Icons.monitor_rounded)),
              )

              
            ],

          ),
            body: Row(
          children: [
            const Expanded(
              child: SideMenu(),
              flex: 1,
            ),
            Expanded(
                flex: 5,
                child: PageView.builder(
                    controller: session.controller,
                    itemCount: pages.length,
                    itemBuilder: ((context, index) => pages[index]))

            )
          ],
        )),
        tablet: Scaffold(
          backgroundColor: Colors.purple,
          appBar: AppBar(),


          drawer: SideMenu(),

          body: PageView.builder(
              controller: session.controller,
              itemCount: pages.length,
              itemBuilder: ((context, index) => pages[index])),
        ));
  }
}
