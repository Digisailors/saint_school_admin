import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/controllers/admin_controller.dart';
import 'package:school_app/controllers/parent_controller.dart';
import 'package:school_app/controllers/student_controller.dart';
import 'package:school_app/controllers/teacher_controller.dart';
import 'package:school_app/models/biodata.dart';
import 'package:school_app/screens/Form/student_form.dart';
import 'package:school_app/screens/list/source/bio_source.dart';
import 'package:school_app/screens/student_form.dart' as students;
import 'package:school_app/widgets/custom_text_field.dart';

import '../../constants/get_constants.dart';
import '../../controllers/session_controller.dart';
import '../../form_controller.dart';
import '../../widgets/custom_drop_down.dart';

class EntityList extends StatefulWidget {
  const EntityList({Key? key, required this.entityType}) : super(key: key);
  final EntityType entityType;

  static const routeName = '/passArguments';
  @override
  State<EntityList> createState() => _EntityListState();
}

class _EntityListState extends State<EntityList> {

  StudentFormController get controller => session.formcontroller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.all(isMobile(context)?2:8),
        child: StreamBuilder<List<Bio>>(
            initialData: getList(),
            stream: getStream(),
            builder: (context, snapshot) {
              print(snapshot.connectionState);

              if (snapshot.connectionState == ConnectionState.active && snapshot.hasData) {
                var list = snapshot.data;
                var source = BioSource(list!, context);
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width: isMobile(context)?getWidth(context)*2:getWidth(context)*0.80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(widget.entityType.name.toString().toUpperCase()),

                              SizedBox(
                                  height: getHeight(context)*0.08,
                                  width: isMobile(context)
                                      ? getWidth(context) * 0.80
                                      : getWidth(context) * 0.20,
                                  child: Center(
                                    child: TextFormField(
                                      decoration: InputDecoration(

                                        prefixIcon: Icon(Icons.search, color: getColor(context).secondary,),
                                        border:const OutlineInputBorder(

                                        ),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                  height: getHeight(context)*0.053,
                                  width:  getWidth(context) * 0.10,
                                  child: DropdownButtonFormField<String>(
                                    decoration: const InputDecoration(
                                      labelText: 'Class',


                                      border:OutlineInputBorder(


                                      ),
                                    ), items: controller.classItems,

                                    onChanged: (text) {
                                      setState(() {
                                        if (controller.classField != text) {
                                          controller.classField = text ?? controller.classField;
                                          controller.sectionField = null;
                                        }
                                      });
                                    },
                                  )

                              ),
                              SizedBox(
                                height: getHeight(context)*0.053,
                                width:  getWidth(context) * 0.10,
                                child: DropdownButtonFormField<String?>(
                                  decoration: const InputDecoration(
                                    labelText: 'Section',


                                    border:OutlineInputBorder(


                                    ),
                                  ),
                                  items: controller.sectionItems,

                                  onChanged: (text) {
                                    setState(() {
                                      controller.sectionField =
                                          text ?? controller.sectionField;
                                    });
                                  },
                                ),
                              ),







                              ElevatedButton(
                                  onPressed: () {
                                    Get.toNamed(StudentForm.routeName, arguments: null);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: const Text("Add"),
                                  )),
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: const Text("Refresh"),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(minWidth: getWidth(context)*0.90, maxWidth:1980,),
                        child: PaginatedDataTable(
                          dragStartBehavior: DragStartBehavior.start,





                          columns: BioSource.getCoumns(widget.entityType),
                          source: source,
                          rowsPerPage:isDesktop(context)?14:10,
                        ),
                      ),
                    ],
                  ),
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
