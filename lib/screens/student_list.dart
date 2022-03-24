import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:school_app/constants/constant.dart';
import 'package:school_app/controllers/session_controller.dart';
import 'package:school_app/models/student.dart';
import 'package:school_app/screens/student_form.dart';

class StudentList extends StatelessWidget {
  Query<Map<String, dynamic>> query = students.orderBy("id");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: query.snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.active &&
              snapshot.hasData) {
            var docs = snapshot.data!.docs;
            var students = docs.map((e) => Student.fromJson(e.data())).toList();
            if (students.isNotEmpty) {
              session.selectedStudent = students[session.selectedIndex];
            }
            return GetBuilder(
                init: session,
                builder: (_) {
                  return Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: ListTile(
                                  title: TextFormField(
                                    decoration: const InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                  trailing: Container(
                                    color: Colors.white,
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.search)),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: students.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      horizontalTitleGap: 32,
                                      leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              students[index].image ?? '')),
                                      title: Text(students[index].id),
                                      subtitle: Text(students[index].name),
                                      selected: session.selectedIndex == index,
                                      selectedColor: Colors.white,
                                      trailing: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.delete)),
                                      onTap: () {
                                        session.selectedIndex = index;

                                        session.selectedStudent =
                                            students[session.selectedIndex];
                                        print(session.student!.toJson());
                                        session.update();
                                      },
                                      hoverColor: Colors.blue.shade100,
                                      selectedTileColor: Colors.blueAccent,
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                      const Expanded(
                        flex: 5,
                        child: StudentForm(formMode: FormMode.update),
                      ),
                    ],
                  );
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class StudentListTile extends StatelessWidget {
  const StudentListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
    this.selected = false,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      selected: selected,
      selectedTileColor: Colors.blueAccent,
      hoverColor: Colors.blue.shade100,
      horizontalTitleGap: 0.0,
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
