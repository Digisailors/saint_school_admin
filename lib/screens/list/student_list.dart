import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/controllers/department_controller.dart';
import 'package:school_app/models/Attendance/department.dart';
import 'package:school_app/models/biodata.dart';
import 'package:school_app/models/student.dart';
import 'package:school_app/screens/Form/student_form.dart';
import 'package:school_app/screens/list/source/bio_source.dart';
import 'package:school_app/screens/list/source/student_source.dart';

import '../../constants/constant.dart';
import '../../constants/get_constants.dart';
import '../../controllers/session_controller.dart';
import '../Form/controllers/student_form_controller.dart';

class StudentList extends StatefulWidget {
  const StudentList({Key? key}) : super(key: key);

  static const routeName = '/passArguments';
  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  StudentFormController get controller => session.formcontroller;
  Department? classFilter;
  Department? sectionFilter;
  String? search;

  Stream<List<Student>> getStream() {
    Query<Map<String, dynamic>> query = firestore.collection('students');
    if (search != null) {
      query = query.where('search', arrayContains: search);
    }
    if (classFilter != null) {
      query = query.where('class', isEqualTo: classFilter?.id);
    }
    if (sectionFilter != null) {
      query = query.where('section', isEqualTo: sectionFilter?.id);
    }

    return query.snapshots().map((event) => event.docs.map((e) {
          return Student.fromJson(e.data());
        }).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(isMobile(context) ? 2 : 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: isMobile(context)
                      ? getWidth(context) * 2
                      : getWidth(context) * 0.80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("STUDENT LIST"),
                      Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SizedBox(
                            height: getHeight(context) * 0.08,
                            width: isMobile(context)
                                ? getWidth(context) * 0.40
                                : getWidth(context) * 0.20,
                            child: Center(
                              child: TextFormField(
                                onChanged: ((value) => search = value),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: getColor(context).secondary,
                                  ),
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SizedBox(
                            height: getHeight(context) * 0.053,
                            width: isMobile(context)
                                ? getWidth(context) * 0.40
                                : getWidth(context) * 0.20,
                            child: DropdownButtonFormField<Department?>(
                              value: classFilter,
                              decoration: const InputDecoration(
                                labelText: 'Class',
                                border: OutlineInputBorder(),
                              ),
                              items: departmentListController.getClassItems(),
                              onChanged: (text) {
                                print(text?.toJson());
                                try {
                                  setState(() {
                                    classFilter = text;
                                    sectionFilter = null;
                                  });
                                } catch (e) {
                                  classFilter = null;
                                }
                              },
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SizedBox(
                            height: getHeight(context) * 0.053,
                            width: isMobile(context)
                                ? getWidth(context) * 0.40
                                : getWidth(context) * 0.20,
                            child: DropdownButtonFormField<Department>(
                              value: sectionFilter,
                              decoration: const InputDecoration(
                                labelText: 'Section',
                                border: OutlineInputBorder(),
                              ),
                              items: departmentListController
                                  .getSectionsItems(classFilter?.id),
                              onChanged: (text) {
                                setState(() {
                                  sectionFilter = text;
                                });
                              },
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {});
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text("Search"),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed(StudentForm.routeName,
                                  arguments: null);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text("Add"),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              StreamBuilder<List<Student>>(
                  stream: getStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active &&
                        snapshot.hasData) {
                      var list = snapshot.data;
                      var source = StudentSource(list!, context);
                      return ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: getWidth(context) * 0.90,
                          maxWidth: 1980,
                        ),
                        child: PaginatedDataTable(
                          dragStartBehavior: DragStartBehavior.start,
                          columns: BioSource.getCoumns(EntityType.student),
                          source: source,
                          rowsPerPage:
                              (getHeight(context) ~/ kMinInteractiveDimension) -
                                  5,
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      if (kDebugMode) {
                        print(snapshot.error);
                      }
                      return const Text("Error occured");
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
