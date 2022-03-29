import 'package:get/get.dart';
import 'package:school_app/constants/constant.dart';
import 'package:school_app/form_controller.dart';
import 'response.dart' as res;

class Student extends GetxController {
  Student({
    required this.name,
    required this.id,
    required this.carNumbers,
    this.father,
    this.mother,
    required this.contact,
    required this.studentClass,
    required this.section,
    required this.address,
    this.image,
    this.guardian,
    this.inQueue = false,
  });

  String name;
  String id;
  List<String> carNumbers;
  String? father;
  String? mother;
  String? guardian;
  String contact;
  String studentClass;
  String? section;
  String address;
  String? image;
  bool inQueue;

  List<String> get searchString {
    List<String> list = [];
    List<String> splits = [];
    splits.addAll(name.split(' ').toList());
    splits.add(id);
    for (var element in carNumbers) {
      splits.addAll(element.split(' ').toList());
    }
    for (var element in splits) {
      list.addAll(makeSearchstring(element));
    }
    return list;
  }

  List<String> makeSearchstring(String string) {
    List<String> list = [];
    for (int i = 0; i <= string.length; i++) {
      for (int j = i; j <= string.length; j++) {
        var temp = string.substring(i, j);
        if (temp.length > 2) {
          list.add(temp.toLowerCase());
        }
      }
    }
    list.add(string.toLowerCase());
    return list;
  }

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        name: json["name"],
        id: json["id"],
        carNumbers: List<String>.from(json["carNumbers"].map((x) => x)),
        father: json["father"],
        mother: json["mother"],
        contact: json["contact"],
        studentClass: json["class"],
        section: json["section"],
        address: json["address"],
        guardian: json["guardian"],
        image: json["image"],
        inQueue: json["inQueue"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "carNumbers": List<dynamic>.from(carNumbers.map((x) => x)),
        "father": father,
        "mother": mother,
        "contact": contact,
        "class": studentClass,
        "section": section,
        "search": searchString,
        "guardian": guardian,
        "image": image,
        "address": address,
        "inQueue": inQueue,
      };

  StudentFormController get formController =>
      StudentFormController.fromStudent(this);

  Future<res.Response> createUser() async {
    return students
        .doc(id)
        .set(toJson())
        .then((value) => res.Response.success("Student Addeed Succesfully"))
        .onError((error, stackTrace) => res.Response.error(error.toString()));
  }

  Future<res.Response> updateUser() {
    return students
        .doc(id)
        .update(toJson())
        .then((value) => res.Response.success("Student Updated Succesfully"));
  }
}
