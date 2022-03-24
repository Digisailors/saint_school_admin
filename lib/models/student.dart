import 'dart:convert';

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
  });

  String name;
  String id;
  List<String> carNumbers;
  String? father;
  String? mother;
  String? guardian;
  String contact;
  String studentClass;
  String section;
  String address;
  String? image;

  List<String> get searchString {
    List<String> list = [];
    List<String> splits = name.split(' ').toList();
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
    for (int i = 1; i < string.length; i++) {
      list.add(string.substring(0, i).toLowerCase());
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
      image: json["image"]);

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
