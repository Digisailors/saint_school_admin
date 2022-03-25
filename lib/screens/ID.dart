import 'package:flutter/material.dart';
import 'package:school_app/models/student.dart';

class Idcard extends StatelessWidget {
  const Idcard({Key? key, required this.student}) : super(key: key);

  final Student student;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.width,
            color: Colors.grey.shade200,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                    radius: 100.0,
                    backgroundImage: NetworkImage(student.image ?? ''),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    student.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "ID No: ",
                        // textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                      Text(
                        student.id,
                        // textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Class : ",
                            // textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            student.studentClass,
                            // textAlign: TextAlign.center,
                            style:
                                const TextStyle(fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Section : ",
                            // textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            student.section,
                            // textAlign: TextAlign.center,
                            style:
                                const TextStyle(fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ],
                  ),
                  DataTable(dividerThickness: 0.001, columns: const [
                    DataColumn(label: Text('')),
                    DataColumn(label: Text(''))
                  ], rows: [
                    DataRow(cells: [
                      const DataCell(Text('Name')),
                      DataCell(Text(student.name)),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Father Name')),
                      DataCell(Text(student.father ?? '')),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Mother Name')),
                      DataCell(Text(student.mother ?? '')),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Guardian Name')),
                      DataCell(Text(student.guardian ?? '')),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Car No')),
                      DataCell(Text(student.carNumbers[0])),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Car No 2')),
                      DataCell(Text(student.carNumbers[1])),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Phone No')),
                      DataCell(Text(student.contact)),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Address')),
                      DataCell(Text(student.address)),
                    ])
                  ])
                ],
              ),
            )),
      ),
    ));
  }
}
