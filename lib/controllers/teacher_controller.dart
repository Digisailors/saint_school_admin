import 'package:get/get.dart';
import 'package:school_app/controllers/crude_controller.dart';
import '../constants/constant.dart';
import '../models/response.dart';
import '../models/teacher.dart';

class TeacherController extends GetxController implements crud {
  TeacherController(this.teacher);

  final Teacher teacher;
  static RxList<Teacher> teacherList = <Teacher>[].obs;

  static String selectedIcNumber = '';
  bool get selected => selectedIcNumber == teacher.icNumber;

  static Teacher get selectedTeacher => teacherList.firstWhere((element) => element.icNumber == selectedIcNumber);

  static Stream<List<Teacher>> listenTeachers() {
    Stream<List<Teacher>> stream =
        firestore.collection('teachers').snapshots().map((event) => event.docs.map((e) => Teacher.fromJson(e.data())).toList());
    teacherList.bindStream(stream);
    return stream;
  }

  @override
  Future<Result> add() async {
    return firestore
        .collection('teachers')
        .doc(teacher.icNumber)
        .set(teacher.toJson())
        .then((value) => Result.success("Teacher added successfully"))
        .onError((error, stackTrace) => Result.error(error.toString()));
  }

  @override
  Future<Result> change() async {
    return firestore
        .collection('teachers')
        .doc(teacher.icNumber)
        .update(teacher.toJson())
        .then((value) => Result.success("Teacher Updated successfully"))
        .onError((error, stackTrace) => Result.error(error.toString()));
  }

  @override
  Future<Result> delete() async {
    return firestore
        .collection('teachers')
        .doc(teacher.icNumber)
        .delete()
        .then((value) => Result.success("Teacher Updated successfully"))
        .onError((error, stackTrace) => Result.error(error.toString()));
  }

  Stream<Teacher> get stream => firestore.collection('teachers').doc(teacher.icNumber).snapshots().map((event) => Teacher.fromJson(event.data()!));
}
