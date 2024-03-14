import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:school_app/controllers/Attendance%20API/employee_controller.dart';
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
        firestore.collection('students').snapshots().map((event) => event.docs.map((e) => Student.fromJson(e.data(), e.id)).toList());
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
      firestore.collection('parents').where('icNumber', isEqualTo: father.icNumber).get().then((value) {
        if (value.docs.isNotEmpty) {
          for (var element in value.docs) {
            element.reference.update(father.toJson());
          }
        } else {
          var docId = firestore.collection('parents').doc().id;
          father.docId = docId;
          firestore.collection('parents').doc(docId).set(father.toJson());
        }
      });
    }
    if (mother != null && mother.icNumber.isNotEmpty) {
      if (!mother.children.contains(student.icNumber)) {
        mother.children.add(student.icNumber);
      }
      student.mother = mother;
      firestore.collection('parents').where('icNumber', isEqualTo: mother.icNumber).get().then((value) {
        if (value.docs.isNotEmpty) {
          for (var element in value.docs) {
            element.reference.update(mother.toJson());
          }
        } else {
          var docId = firestore.collection('parents').doc().id;
          mother.docId = docId;
          firestore.collection('parents').doc(docId).set(mother.toJson());
        }
      });
    }
    if (guardian != null && guardian.icNumber.isNotEmpty) {
      if (!guardian.children.contains(student.icNumber)) {
        guardian.children.add(student.icNumber);
      }
      student.guardian = guardian;
      firestore.collection('parents').where('icNumber', isEqualTo: guardian.icNumber).get().then((value) {
        if (value.docs.isNotEmpty) {
          for (var element in value.docs) {
            element.reference.update(guardian.toJson());
          }
        } else {
          var docId = firestore.collection('parents').doc().id;
          guardian.docId = docId;
          firestore.collection('parents').doc(docId).set(guardian.toJson());
        }
      });
    }

    student.docId = firestore.collection('students').doc().id;

    // try {
    //   var employee = await EmployeeController.addEmployee(student.employee);
    //   student.empId = employee.id;
    // } catch (e) {
    //   if (kDebugMode) {
    //     print(e.toString());
    //   }
    //   return Result.error("Could not sync attendance. Contact Admin");
    // }

    return firestore
        .collection('students')
        .doc(student.docId)
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

    // try {
    //   var employee = await EmployeeController.updateEmployee(student.employee);
    //   student.empId = employee.id;
    // } catch (e) {
    //   // return Result.error("Could not sync attendance. Contact Admin");
    // }

    print("DOCUMENT ID : ${student.docId}");
    return firestore
        .collection('students')
        .doc(student.docId)
        .update(student.toJson())
        .then((value) => Result.success("Student Updated successfully"))
        .onError((error, stackTrace) => Result.error(error.toString()));
  }

  @override
  Future<Result> delete() async {
    // print("Deleting");
    await firestore.collection('parents').where('parents', arrayContains: student.icNumber).get().then((value) {
      value.docs.map((e) => Parent.fromJson(e.data())).forEach((element) {
        element.children.remove(student.icNumber);
        firestore.collection('parents').doc(element.docId).update({'children': element.children});
      });
    });
    return firestore
        .collection('students')
        .doc(student.docId)
        .delete()
        .then((value) => Result.success("Student Updated successfully"))
        .onError((error, stackTrace) => Result.error(error.toString()));
  }

  Stream<Student> get stream =>
      firestore.collection('students').doc(student.icNumber).snapshots().map((event) => Student.fromJson(event.data()!, event.id));
}
