import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_app/controllers/Attendance%20API/trnasaction_controller.dart';
import 'package:school_app/controllers/classlist_controller.dart';
import 'package:school_app/models/Attendance/department.dart';
import 'package:school_app/models/Attendance/transaction.dart';
import 'package:school_app/screens/Form/teacher_form.dart';
import 'package:school_app/screens/list/source/teacher_source.dart';
import 'package:school_app/service/excel_service.dart';
import 'package:universal_html/html.dart' show AnchorElement;
import '../../constants/constant.dart';
import '../../constants/get_constants.dart';
import '../../models/teacher.dart';
import 'student_list.dart';

class TeacherTransaction {
  final Teacher teacher;

  final List<TransactionLog> logs;

  static List<TransactionLog> getMyTransactionLog({required Teacher student, required List<TransactionLog> logs}) {
    List<TransactionLog> mylogs = logs.where((element) => element.empCode == student.icNumber && element.areaAlias != 'CAFETERIA').toList();
    mylogs.sort(((a, b) => b.punchTime.compareTo(a.punchTime)));
    print(' count  :  ${mylogs.where((element) => element.checkOutStatus != null).length}');
    return mylogs;
  }

  TeacherTransaction(this.teacher, this.logs);

  factory TeacherTransaction.create(Teacher teacher, List<TransactionLog> logs) {
    var teacherTransaction = TeacherTransaction(teacher, logs);
    teacherTransaction.checkInStatus = logs.firstWhereOrNull((element) => element.punchState == "0")?.checkInStatus;
    teacherTransaction.checkInTime = logs.firstWhereOrNull((element) => element.punchState == "0")?.punchTime;
    var list = logs.where((element) => element.punchState == "1");
    teacherTransaction.checkOutTime = list.isEmpty ? null : list.last.punchTime;
    teacherTransaction.checkOutStatus = list.isEmpty ? null : list.last.checkOutStatus;
    return teacherTransaction;
  }

  CheckInStatus? checkInStatus;
  DateTime? checkInTime;
  DateTime? checkOutTime;
  CheckOutStatus? checkOutStatus;
}

class TeachersList extends StatefulWidget {
  const TeachersList({Key? key}) : super(key: key);

  static const routeName = '/TeacherList';
  @override
  State<TeachersList> createState() => _TeachersListState();
}

class _TeachersListState extends State<TeachersList> {
  // TeacherFormController get controller => session.formcontroller;
  String? classFilter;
  String? sectionFilter;
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

  List<DropdownMenuItem<String>> get classItems {
    List<DropdownMenuItem<String>> items = classController.classes.keys
        .map((e) => DropdownMenuItem<String>(
              child: Text(e.toUpperCase()),
              value: e,
            ))
        .toList();
    items.add(const DropdownMenuItem(child: Text("None")));
    return items;
  }

  List<DropdownMenuItem<String>> getsectionItems() {
    List<DropdownMenuItem<String>> items = [];
    if (classFilter != null) {
      items = (classController.classes[classFilter] ?? [])
          .map((e) => DropdownMenuItem<String>(
                child: Text(e),
                value: e,
              ))
          .toList();
    }
    items.add(const DropdownMenuItem(child: Text("None")));
    return items;
  }

  static Future<List<TransactionLog>> getTransactionLogs(DateTime date) async {
    List<TransactionLog> logs = [];
    var today = date;
    var endTime = date.add(const Duration(days: 1));
    logs = await TransactionController.loadTransactions(startTime: DateTime(today.year, today.month, today.day), endTime: endTime, entity: 1);
    return logs;
  }

  int statusFilter = 0;

  static Future<List<TeacherTransaction>> getTeacherTransactions(Map<String, dynamic> map) async {
    String? search = map['search'];
    String? classFilter = map['classFilter'];
    String? sectionFilter = map['sectionFilter'];
    DateTime date = map['date'];

    List<TeacherTransaction> teacherTransactions = [];
    List<Teacher> _teacherslist = [];
    List<TransactionLog> _logslist = [];

    Query<Map<String, dynamic>> query = firestore.collection('teachers').orderBy('name');
    if (search != null) {
      query = query.where('search', arrayContains: search);
    }
    if (classFilter != null) {
      query = query.where('class', isEqualTo: classFilter);
    }
    if (sectionFilter != null) {
      query = query.where('section', isEqualTo: sectionFilter);
    }

    Future<List<Teacher>> future1 =
        query.get().then((value) => value.docs.map((e) => Teacher.fromJson(e.data())).toList()).then((value) => _teacherslist = value);
    Future<List<TransactionLog>> future2 = getTransactionLogs(date).then((value) => _logslist = value);
    await Future.wait([future1, future2]);

    for (var teacher in _teacherslist) {
      teacherTransactions.add(TeacherTransaction.create(teacher, _logslist.where((element) => element.empCode == teacher.icNumber).toList()));
    }
    return teacherTransactions;
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
                            child: DropdownButtonFormField<String?>(
                              value: classFilter,
                              decoration: const InputDecoration(
                                labelText: 'Class',
                                border: OutlineInputBorder(),
                              ),
                              items: classItems,
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
                            child: DropdownButtonFormField<String>(
                              value: sectionFilter,
                              decoration: const InputDecoration(
                                labelText: 'Section',
                                border: OutlineInputBorder(),
                              ),
                              items: getsectionItems(),
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
                              Get.to(const TeacherForm());
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
              FutureBuilder<List<TeacherTransaction>>(
                  future:
                      compute(getTeacherTransactions, {'search': search, 'classFilter': classFilter, 'sectionFilter': sectionFilter, 'date': date}),
                  builder: (context, AsyncSnapshot<List<TeacherTransaction>> snapshot) {
                    List<TeacherTransaction> sourceList = [];
                    if (snapshot.hasError) {
                      return Center(
                        child: SelectableText(snapshot.error.toString()),
                      );
                    }
                    if ((snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done) &&
                        snapshot.hasData) {
                      sourceList = snapshot.data ?? [];
                      if (checkInStatus != null) {
                        sourceList = sourceList.where((element) => element.checkInStatus == checkInStatus).toList();
                      }

                      if (checkOutstatus != null) {
                        sourceList = sourceList.where((element) => element.checkOutStatus == checkOutstatus).toList();
                      }

                      return ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: getWidth(context) * 0.90,
                          maxWidth: 1980,
                        ),
                        child: StatefulBuilder(builder: (context, setstate) {
                          var source = TeacherSource(sourceList, context, setstate);
                          return PaginatedDataTable(
                            header: const Text("TEACHER LIST"),
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
                                              future: compute(ExcelService.createTeacherReport, sourceList),
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
                                                    content: SelectableText(snapshot.error.toString()),
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
                            columns: TeacherSource.getCoumns(),
                            source: source,
                            rowsPerPage: (getHeight(context) ~/ kMinInteractiveDimension) - 5,
                          );
                        }),
                      );
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
                setState(() {});
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