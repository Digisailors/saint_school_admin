import 'package:get/get.dart';
import 'package:school_app/constants/constant.dart';
import 'package:school_app/controllers/crud_controller.dart';
import 'package:school_app/models/response.dart';
import 'package:school_app/models/student.dart';

import '../models/parent.dart';

class ParentController extends GetxController implements CRUD {
  ParentController({required this.parent});

  final Parent parent;

  static RxList<Parent> parentsList = <Parent>[].obs;

  static Stream<List<Parent>> listenParents() {
    Stream<List<Parent>> stream =
        firestore.collection('parents').snapshots().map((event) => event.docs.map((e) => Parent.fromJson(e.data())).toList());
    parentsList.bindStream(stream);
    return stream;
  }

  @override
  Future<Result> add() async {
    return firestore
        .collection('parents')
        .doc(parent.icNumber)
        .set(parent.toJson())
        .then((value) => Result.success("Parent added successfully"))
        .onError((error, stackTrace) => Result.error(error.toString()));
  }

  @override
  Future<Result> change() async {
    List<Future> futures = [];
    for (var element in parent.children) {
      futures.add(firestore.collection('students').doc(element).get().then((value) {
        var student = Student.fromJson(value.data()!);
        if (student.father?.icNumber == parent.icNumber) {
          student.father = parent;
        }
        if (student.mother?.icNumber == parent.icNumber) {
          student.mother = parent;
        }
        if (student.guardian?.icNumber == parent.icNumber) {
          student.guardian = parent;
        }
        return firestore.collection('students').doc(student.icNumber).set(student.toJson());
      }));
    }

    return Future.wait(futures)
        .then((value) => firestore
            .collection('parents')
            .doc(parent.icNumber)
            .update(parent.toJson())
            .then((value) => Result.success("Parent Updated successfully"))
            .onError((error, stackTrace) => Result.error(error.toString())))
        .onError((error, stackTrace) => Result.error(error.toString()));
  }

  @override
  Future<Result> delete() async {
    return firestore
        .collection('parents')
        .doc(parent.icNumber)
        .delete()
        .then((value) => Result.success("Parent Updated successfully"))
        .onError((error, stackTrace) => Result.error(error.toString()));
  }

  Stream<Parent> get stream => firestore.collection('parents').doc(parent.icNumber).snapshots().map((event) => Parent.fromJson(event.data()!));
}
