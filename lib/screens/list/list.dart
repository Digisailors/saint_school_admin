import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/controllers/admin_controller.dart';
import 'package:school_app/controllers/parent_controller.dart';
import 'package:school_app/controllers/student_controller.dart';
import 'package:school_app/controllers/teacher_controller.dart';
import 'package:school_app/models/biodata.dart';
import 'package:school_app/screens/Form/student_form.dart';
import 'package:school_app/screens/list/source/bio_source.dart';

import '../../constants/get_constants.dart';

class EntityList extends StatefulWidget {
  const EntityList({Key? key, required this.entityType}) : super(key: key);
  final EntityType entityType;

  static const routeName = '/passArguments';
  @override
  State<EntityList> createState() => _EntityListState();
}

class _EntityListState extends State<EntityList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 2000, maxWidth: (getWidth(context) < 2000 ? 2000 : getWidth(context))),
        child: StreamBuilder<List<Bio>>(
            initialData: getList(),
            stream: getStream(),
            builder: (context, snapshot) {
              print(snapshot.connectionState);

              if (snapshot.connectionState == ConnectionState.active && snapshot.hasData) {
                var list = snapshot.data;
                var source = BioSource(list!, context);
                return PaginatedDataTable(
                  header: Text(widget.entityType.toString()),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Get.toNamed(StudentForm.routeName, arguments: null);
                        },
                        child: const Text("Add")),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: const Text("Refresh"))
                  ],
                  columns: BioSource.getCoumns(widget.entityType),
                  source: source,
                  rowsPerPage: (MediaQuery.of(context).size.height ~/ kMinInteractiveDimension) - 4,
                );
              }

              if (snapshot.hasError) {
                return const Text("Error occured");
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }

  List<Bio> getList() {
    switch (widget.entityType) {
      case EntityType.student:
        return StudentController.studentList.toList();
      case EntityType.teacher:
        return TeacherController.teacherList.toList();
      case EntityType.parent:
        return ParentController.parentsList.toList();
      case EntityType.admin:
        return AdminController.adminList.toList();
    }
  }

  getStream() {
    switch (widget.entityType) {
      case EntityType.student:
        return StudentController.listenStudents();
      case EntityType.teacher:
        return TeacherController.listenTeachers();
      case EntityType.parent:
        return ParentController.listenParents();
      case EntityType.admin:
        return AdminController.adminList.stream;
    }
  }
}
