import 'package:get/get.dart';
import 'package:school_app/constants/constant.dart';
import 'package:school_app/controllers/crude_controller.dart';
import 'package:school_app/models/response.dart';

import '../models/parent.dart';

class ParentController extends GetxController implements crud {
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
    return firestore
        .collection('parents')
        .doc(parent.icNumber)
        .update(parent.toJson())
        .then((value) => Result.success("Parent Updated successfully"))
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
