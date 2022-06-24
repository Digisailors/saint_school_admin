import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/constants/constant.dart';
import 'package:school_app/screens/Form/appointment_form.dart';
import 'package:school_app/screens/list/source/appointmentsource.dart';
import 'package:school_app/models/appointment.dart';

import '../../constants/get_constants.dart';
import '../../controllers/session_controller.dart';
import '../Form/controllers/student_form_controller.dart';

class AppoinmentList extends StatefulWidget {
  const AppoinmentList({Key? key}) : super(key: key);
  static const routeName = '/passArguments';
  @override
  State<AppoinmentList> createState() => _AppoinmentListState();
}

class _AppoinmentListState extends State<AppoinmentList> {
  StudentFormController get controller => session.formcontroller;

  List<Appointment> source = [
    // Appointment(date: DateTime.now(), status: A, approvedBy: 'Admin', location: 'Thoothukudi', raisedBy: 'Rampwiz', participants: []),
    // Appointment(date: DateTime.now(), status: 2, approvedBy: 'Admin', location: 'Thoothukudi', raisedBy: 'Rampwiz', participants: []),
    // Appointment(date: DateTime.now(), status: 1, approvedBy: 'Admin', location: 'Thoothukudi', raisedBy: 'Rampwiz', participants: []),
    // Appointment(date: DateTime.now(), status: 1, approvedBy: 'Admin', location: 'Thoothukudi', raisedBy: 'Rampwiz', participants: []),
    // Appointment(date: DateTime.now(), status: 2, approvedBy: 'Admin', location: 'Thoothukudi', raisedBy: 'Rampwiz', participants: []),
    // Appointment(date: DateTime.now(), status: 1, approvedBy: 'Admin', location: 'Thoothukudi', raisedBy: 'Rampwiz', participants: []),
    // Appointment(date: DateTime.now(), status: 1, approvedBy: 'Admin', location: 'Thoothukudi', raisedBy: 'Rampwiz', participants: []),
    // Appointment(date: DateTime.now(), status: 2, approvedBy: 'Admin', location: 'Thoothukudi', raisedBy: 'Rampwiz', participants: []),
    // Appointment(date: DateTime.now(), status: 1, approvedBy: 'Admin', location: 'Thoothukudi', raisedBy: 'Rampwiz', participants: []),
  ];

  @override
  Widget build(BuildContext context) {
    var sourcelist = AppointmentSource(
      source,
      context,
    );

    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(isMobile(context) ? 2 : 8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: isMobile(context) ? getWidth(context) * 3 : getWidth(context) * 0.80,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: isMobile(context) ? MainAxisAlignment.start : MainAxisAlignment.end,
                        children: [
                          const Text(''),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: ElevatedButton(
                                onPressed: () {
                                  Get.to(const AppointmentPage());
                                },
                                child: const Text("Add")),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {});
                              },
                              child: const Text("Refresh"))
                        ],
                      ),
                    ),
                  ),
                ),
                StreamBuilder<List<Appointment>>(
                    stream: firestore
                        .collection('appointments')
                        .snapshots()
                        .map((event) => event.docs.map((e) => Appointment.fromJson(e.data(), e.reference.id)).toList()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active && snapshot.hasData) {
                        sourcelist = AppointmentSource(snapshot.data!, context);
                        return Table(
                          children: [
                            TableRow(
                              children: [
                                PaginatedDataTable(
                                  dragStartBehavior: DragStartBehavior.start,
                                  columns: AppointmentSource.getCoumns(),
                                  source: sourcelist,
                                  rowsPerPage: isDesktop(context) ? 14 : 10,
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ],
            ),
          )),
    );
  }
}

  // List<Bio> getList() {
  //   switch (widget.entityType) {
  //     case EntityType.student:
  //       return StudentController.studentList.toList();
  //     case EntityType.teacher:
  //       return TeacherController.teacherList.toList();
  //     case EntityType.parent:
  //       return ParentController.parentsList.toList();
  //     case EntityType.admin:
  //       return AdminController.adminList.toList();
  //   }
  // }

//   getStream() {
//     switch (widget.entityType) {
//       case EntityType.student:
//         return StudentController.listenStudents();
//       case EntityType.teacher:
//         return TeacherController.listenTeachers();
//       case EntityType.parent:
//         return ParentController.listenParents();
//       case EntityType.admin:
//         return AdminController.adminList.stream;
//     }
//   }
// }
