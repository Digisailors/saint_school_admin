import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_app/controllers/Attendance%20API/department_controller.dart';
import 'package:school_app/controllers/Attendance%20API/trnasaction_controller.dart';
import 'package:school_app/controllers/attendance_controller.dart';
import 'package:school_app/models/Attendance/department.dart';
import 'package:school_app/models/Attendance/transaction.dart';
import 'package:school_app/models/biodata.dart';
import 'package:school_app/models/student.dart';
import 'package:school_app/screens/Form/student_form.dart';
import 'package:school_app/screens/list/source/bio_source.dart';
import 'package:school_app/screens/list/source/student_source.dart';
import 'package:school_app/service/excel_service.dart';
import 'package:universal_html/html.dart' show AnchorElement;
import '../../constants/constant.dart';
import '../../constants/get_constants.dart';
import '../../controllers/session_controller.dart';
import '../Form/controllers/student_form_controller.dart';

enum CheckInStatus { late, onTime }

enum CheckOutStatus { early, onTime }

class StudentTransaction {
  final Student student;

  final List<TransactionLog> logs;

  static List<TransactionLog> getMyTransactionLog({required Student student, required List<TransactionLog> logs}) {
    List<TransactionLog> mylogs = logs.where((element) => element.empCode == student.icNumber && element.areaAlias != 'CAFETERIA').toList();
    mylogs.sort(((a, b) => b.punchTime.compareTo(a.punchTime)));
    print(' count  :  ${mylogs.where((element) => element.checkOutStatus != null).length}');
    return mylogs;
  }

  StudentTransaction(this.student, this.logs);
  CheckInStatus? get checkInStatus => logs.firstWhereOrNull((element) => element.punchState == "0")?.checkInStatus;
  DateTime? get checkInTime => logs.firstWhereOrNull((element) => element.punchState == "0")?.punchTime;
  DateTime? get checkOutTime {
    var list = logs.where((element) => element.punchState == "1");
    return list.isEmpty ? null : list.last.punchTime;
  }

  CheckOutStatus? get checkOutStatus {
    var list = logs.where((element) => element.punchState == '1');
    return list.isEmpty ? null : list.last.checkOutStatus;
  }
}

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

  CheckInStatus? checkInStatus;
  CheckOutStatus? checkOutstatus;
  DateTime date = DateTime.now();
  final TextEditingController _dateTextController = TextEditingController();

  var format = DateFormat.yMMMd();

  @override
  void initState() {
    super.initState();
    _dateTextController.text = format.format(date);
  }

  Stream<List<Student>> getStream() {
    Query<Map<String, dynamic>> query = firestore.collection('students').orderBy('name');
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

  Future<List<TransactionLog>> getTransactionLogs() async {
    List<TransactionLog> logs = [];
    var today = date;
    var endTime = date.add(const Duration(days: 1));
    logs = await TransactionController.loadTransactions(startTime: DateTime(today.year, today.month, today.day), endTime: endTime);
    return logs.where((element) => element.department != 'Teacher').toList();
  }

  int statusFilter = 0;

  Future<List<StudentTransaction>> getStudentTransactions() async {
    List<StudentTransaction> studentTransactions = [];
    List<Student> _studentslist = [];
    List<TransactionLog> _logslist = [];

    Query<Map<String, dynamic>> query = firestore.collection('students').orderBy('name');
    if (search != null) {
      query = query.where('search', arrayContains: search);
    }
    if (classFilter != null) {
      query = query.where('class', isEqualTo: classFilter?.id);
    }
    if (sectionFilter != null) {
      query = query.where('section', isEqualTo: sectionFilter?.id);
    }

    Future<List<Student>> future1 =
        query.get().then((value) => value.docs.map((e) => Student.fromJson(e.data())).toList()).then((value) => _studentslist = value);
    Future<List<TransactionLog>> future2 = getTransactionLogs().then((value) => _logslist = value);
    await Future.wait([future1, future2]);

    for (var student in _studentslist) {
      studentTransactions.add(StudentTransaction(student, _logslist.where((element) => element.empCode == student.icNumber).toList()));
    }
    return studentTransactions;
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
                  width: isMobile(context) ? getWidth(context) * 2 : getWidth(context) * 0.80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SizedBox(
                            height: getHeight(context) * 0.08,
                            width: isMobile(context) ? getWidth(context) * 0.40 : getWidth(context) * 0.20,
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
                            width: isMobile(context) ? getWidth(context) * 0.40 : getWidth(context) * 0.20,
                            child: DropdownButtonFormField<Department?>(
                              value: classFilter,
                              decoration: const InputDecoration(
                                labelText: 'Class',
                                border: OutlineInputBorder(),
                              ),
                              items: departmentListController.getClassItems(),
                              onChanged: (text) {
                                // print(text?.toJson());
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
                            width: isMobile(context) ? getWidth(context) * 0.40 : getWidth(context) * 0.20,
                            child: DropdownButtonFormField<Department>(
                              value: sectionFilter,
                              decoration: const InputDecoration(
                                labelText: 'Section',
                                border: OutlineInputBorder(),
                              ),
                              items: departmentListController.getSectionsItems(classFilter?.id),
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
                              Get.toNamed(StudentForm.routeName, arguments: null);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text("Add"),
                            )),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {});
                          },
                          icon: const Icon(Icons.refresh))
                    ],
                  ),
                ),
              ),
              FutureBuilder<List<TransactionLog>>(
                  future: getTransactionLogs(),
                  builder: (context, AsyncSnapshot<List<TransactionLog>> snapshot) {
                    List<TransactionLog> logs = [];
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if ((snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done) &&
                        snapshot.hasData) {
                      logs = snapshot.data ?? [];
                    }
                    return StreamBuilder<List<Student>>(
                        stream: getStream(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.active && snapshot.hasData) {
                            var list = snapshot.data ?? [];

                            List<StudentTransaction> sourceList = [];

                            for (var student in list) {
                              sourceList.add(StudentTransaction(student, logs.where((element) => element.empCode == student.icNumber).toList()));
                            }

                            if (checkInStatus != null) {
                              sourceList = sourceList.where((element) => element.checkInStatus == checkInStatus).toList();
                            }

                            if (checkOutstatus != null) {
                              sourceList = sourceList.where((element) => element.checkOutStatus == checkOutstatus).toList();
                            }

                            var source = StudentSource(sourceList, context);
                            return ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: getWidth(context) * 0.90,
                                maxWidth: 1980,
                              ),
                              child: PaginatedDataTable(
                                header: const Text("STUDENT LIST"),
                                actions: [
                                  isMobile(context)
                                      ? ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text("Filters"),
                                                    content: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: getFilterChildren(),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: const Text("OKAY"))
                                                    ],
                                                  );
                                                });
                                          },
                                          child: const Text("Show Filters"))
                                      : Row(children: getFilterChildren()),
                                  ElevatedButton(
                                      onPressed: () async {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return FutureBuilder<List<int>>(
                                                  future: compute(ExcelService.createExcel, sourceList),
                                                  builder: (context, AsyncSnapshot<List<int>> snapshot) {
                                                    if ((snapshot.connectionState == ConnectionState.active ||
                                                            snapshot.connectionState == ConnectionState.done) &&
                                                        snapshot.hasData) {
                                                      return AlertDialog(
                                                        title: const Text("Your download is ready"),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                if (kIsWeb) {
                                                                  AnchorElement(
                                                                      href:
                                                                          'data:application/octet-stream;charset=utf-16le;base64, ${base64.encode(snapshot.data!)}')
                                                                    ..setAttribute('download', 'export.xlsx')
                                                                    ..click();
                                                                }
                                                              },
                                                              child: const Text('DOWNLOAD'))
                                                        ],
                                                      );
                                                    }
                                                    if (snapshot.hasError) {
                                                      return AlertDialog(
                                                        title: const Text("Error Occured. Contact Admin"),
                                                        content: Text(snapshot.error.toString()),
                                                      );
                                                    }
                                                    return const AlertDialog(
                                                      content: Center(
                                                        child: CircularProgressIndicator(),
                                                      ),
                                                    );
                                                  });
                                            });
                                      },
                                      child: const Text("EXPORT"))
                                ],
                                dragStartBehavior: DragStartBehavior.start,
                                columns: StudentSource.getCoumns(EntityType.student),
                                source: source,
                                rowsPerPage: (getHeight(context) ~/ kMinInteractiveDimension) - 5,
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
                        });
                  }),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getFilterChildren() {
    return [
      SizedBox(
        width: 300,
        child: ListTile(
          title: const Text("Attendance Date"),
          trailing: IconButton(
              onPressed: () async {
                date = await showDatePicker(context: context, initialDate: date, firstDate: DateTime(2000), lastDate: DateTime.now()) ?? date;
                _dateTextController.text = format.format(date);
                getTransactionLogs().then((value) {
                  setState(() {});
                });
              },
              icon: const Icon(Icons.calendar_month)),
          subtitle: TextFormField(
            controller: _dateTextController,
          ),
        ),
      ),
      SizedBox(
        width: 300,
        child: ListTile(
          title: const Text("Check-in status"),
          subtitle: DropdownButtonFormField<CheckInStatus>(
              value: checkInStatus,
              items: const [
                DropdownMenuItem(child: Text("ON TIME"), value: CheckInStatus.onTime),
                DropdownMenuItem(child: Text("LATE"), value: CheckInStatus.late),
                DropdownMenuItem(child: Text("ALL")),
              ],
              onChanged: (val) {
                setState(() {
                  checkInStatus = val;
                });
              }),
        ),
      ),
      SizedBox(
        width: 300,
        child: ListTile(
          title: const Text("Check Out Status"),
          subtitle: DropdownButtonFormField<CheckOutStatus>(
              value: checkOutstatus,
              items: const [
                DropdownMenuItem(child: Text("ON TIME"), value: CheckOutStatus.onTime),
                DropdownMenuItem(child: Text("EARLY"), value: CheckOutStatus.early),
                DropdownMenuItem(child: Text("ALL")),
              ],
              onChanged: (val) {
                setState(() {
                  checkOutstatus = val;
                });
              }),
        ),
      ),
    ];
  }
}
