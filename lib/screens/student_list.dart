import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/controllers/session_controller.dart';
import 'package:school_app/screens/student_form.dart';

import 'ID.dart';

class StudentList extends StatelessWidget {
  const StudentList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder(
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
                              controller: session.searchController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                            ),
                            trailing: Container(
                              color: Colors.white,
                              child: IconButton(
                                  onPressed: () {
                                    session.loadStudents();
                                  },
                                  icon: const Icon(Icons.search)),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: session.kids.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                horizontalTitleGap: 32,
                                leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        session.kids[index].image ?? '')),
                                title: Text(session.kids[index].id),
                                subtitle: Text(session.kids[index].name),
                                selected: session.selectedIndex == index,
                                selectedColor: Colors.white,
                                trailing: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.delete)),
                                onTap: () {
                                  session.selectedIndex = index;

                                  session.selectedStudent =
                                      session.kids[session.selectedIndex];

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
                  // child: Idcard(student: session.student!),
                  child: StudentForm(formMode: FormMode.update),
                ),
              ],
            );
          }),
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
