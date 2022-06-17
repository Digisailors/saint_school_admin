import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:school_app/controllers/crud_controller.dart';
import 'package:school_app/models/student.dart';

import '../constants/constant.dart';
import '../models/response.dart';

class StudentController extends GetxController implements CRUD {
  StudentController(this.student);

  final Student student;
  static RxList<Student> studentList = <Student>[].obs;

  static String? selectedIcNumber;
  bool get selected => selectedIcNumber == student.icNumber;

  static Student? get selectedStudent => selectedIcNumber == null ? null : studentList.firstWhere((element) => element.icNumber == selectedIcNumber);

  static listenStudents() {
    Stream<List<Student>> stream =
        firestore.collection('students').snapshots().map((event) => event.docs.map((e) => Student.fromJson(e.data())).toList());
    studentList.bindStream(stream);
    return stream;
  }

  @override
  Future<Result> add() async {
    QuerySnapshot querySnapshot = await firestore.collection('students').get();
    if(querySnapshot.docs.isNotEmpty) {
      return firestore
        .collection('students')
        .doc(student.icNumber)
        .set(student.toJson())
        .then((value) => Result.success("Student added successfully"))
        .onError((error, stackTrace) => Result.error(error.toString()));
    } else {
      return Result.error("Another IC Number found");
    }
  }

  @override
  Future<Result> change() async {
    return firestore
        .collection('students')
        .doc(student.icNumber)
        .update(student.toJson())
        .then((value) => Result.success("Student Updated successfully"))
        .onError((error, stackTrace) => Result.error(error.toString()));
  }

  @override
  Future<Result> delete() async {
    return firestore
        .collection('students')
        .doc(student.icNumber)
        .delete()
        .then((value) => Result.success("Student Updated successfully"))
        .onError((error, stackTrace) => Result.error(error.toString()));
  }

  Stream<Student> get stream => firestore.collection('students').doc(student.icNumber).snapshots().map((event) => Student.fromJson(event.data()!));
}
