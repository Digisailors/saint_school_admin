import 'package:get/get.dart';
import 'package:school_app/controllers/crud_controller.dart';
import 'package:school_app/models/parent.dart';
import 'package:school_app/models/student.dart';

import '../constants/constant.dart';
import '../models/response.dart';

class StudentController extends GetxController implements CRUD {
  StudentController(this.student);

  final Student student;
  static RxList<Student> studentList = <Student>[].obs;

  static String? selectedIcNumber;
  bool get selected => selectedIcNumber == student.icNumber;

  Parent? father;
  Parent? mother;
  Parent? guardian;

  static Student? get selectedStudent => selectedIcNumber == null ? null : studentList.firstWhere((element) => element.icNumber == selectedIcNumber);

  static listenStudents() {
    Stream<List<Student>> stream =
        firestore.collection('students').snapshots().map((event) => event.docs.map((e) => Student.fromJson(e.data())).toList());
    studentList.bindStream(stream);
    return stream;
  }

  @override
  Future<Result> add({Parent? father, Parent? mother, Parent? guardian}) async {
    if (father == null && mother == null && guardian == null) {
      return Result(code: 'Error', message: 'Either Parent or Guardian is Required');
    }
    if (father != null && father.icNumber.isNotEmpty) {
      if (!father.children.contains(student.icNumber)) {
        father.children.add(student.icNumber);
      }
      student.father = father;
      firestore.collection('parents').doc(father.icNumber).set(father.toJson());
    }
    if (mother != null && mother.icNumber.isNotEmpty) {
      if (!mother.children.contains(student.icNumber)) {
        mother.children.add(student.icNumber);
      }
      student.mother = mother;
      firestore.collection('parents').doc(mother.icNumber).set(mother.toJson());
    }
    if (guardian != null && guardian.icNumber.isNotEmpty) {
      if (!guardian.children.contains(student.icNumber)) {
        guardian.children.add(student.icNumber);
      }
      student.guardian = guardian;
      firestore.collection('parents').doc(guardian.icNumber).set(guardian.toJson());
    }

    return firestore
        .collection('students')
        .doc(student.icNumber)
        .set(student.toJson())
        .then((value) => Result.success("Student added successfully"))
        .onError((error, stackTrace) => Result.error(error.toString()));
  }

  @override
  Future<Result> change({Parent? father, Parent? mother, Parent? guardian, bool uploadPic = false}) async {
    if (father == null && mother == null && guardian == null) {
      return Result(code: 'Error', message: 'Either Parent or Guardian is Required');
    }
    if (father != null && father.icNumber.isNotEmpty) {
      if (!father.children.contains(student.icNumber)) {
        father.children.add(student.icNumber);
      }
      student.father = father;
      firestore.collection('parents').doc(father.icNumber).set(father.toJson());
    }
    if (mother != null && mother.icNumber.isNotEmpty) {
      if (!mother.children.contains(student.icNumber)) {
        mother.children.add(student.icNumber);
      }
      student.mother = mother;
      firestore.collection('parents').doc(mother.icNumber).set(mother.toJson());
    }
    if (guardian != null && guardian.icNumber.isNotEmpty) {
      if (!guardian.children.contains(student.icNumber)) {
        guardian.children.add(student.icNumber);
      }
      student.guardian = guardian;
      firestore.collection('parents').doc(guardian.icNumber).set(guardian.toJson());
    }

    return firestore
        .collection('students')
        .doc(student.icNumber)
        .update(student.toJson())
        .then((value) => Result.success("Student Updated successfully"))
        .onError((error, stackTrace) => Result.error(error.toString()));
  }

  @override
  Future<Result> delete() async {
    await firestore.collection('parents').where('parents', arrayContains: student.icNumber).get().then((value) {
      value.docs.map((e) => Parent.fromJson(e.data())).forEach((element) {
        element.children.remove(student.icNumber);
        firestore.collection('parents').doc(element.icNumber).update({'children': element.children});
      });
    });
    return firestore
        .collection('students')
        .doc(student.icNumber)
        .delete()
        .then((value) => Result.success("Student Updated successfully"))
        .onError((error, stackTrace) => Result.error(error.toString()));
  }

  Stream<Student> get stream => firestore.collection('students').doc(student.icNumber).snapshots().map((event) => Student.fromJson(event.data()!));
}
