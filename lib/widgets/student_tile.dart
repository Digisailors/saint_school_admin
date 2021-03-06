import 'package:flutter/material.dart';
import 'package:school_app/models/_newStudent.dart';

class StudentTile extends StatelessWidget {
  const StudentTile({
    Key? key,
    required this.student,
    required this.string,
  }) : super(key: key);

  final Student student;
  final String string;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: const Color(0xFFF5F5F5),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.15,
                        backgroundImage: NetworkImage('https://i.pravatar.cc/3${student.ic}'),
                      ),
                    ),
                  )),
              Expanded(
                  flex: 5,
                  child: ListTile(
                    enabled: true,
                    title: Text(
                      student.name,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    subtitle: Table(
                      columnWidths: const {
                        0: FixedColumnWidth(40),
                      },
                      children: [
                        TableRow(
                          children: [
                            const Text("IC"),
                            Text(
                              student.ic,
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text("Class"),
                            Text(
                              student.studentClass + " - " + student.section,
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    isThreeLine: true,
                    trailing: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.tertiaryContainer),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
                      ),
                      onPressed: () {},
                      child: Text(
                        string,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
