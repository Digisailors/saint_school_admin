import 'package:flutter/foundation.dart';
import 'package:school_app/controllers/student_controller.dart';
import 'package:school_app/models/biodata.dart';

import '../constants/constant.dart';

class Student extends Bio {
  Student({
    required String icNumber,
    required this.studentClass,
    required this.section,
    required String name,
    required String email,
    required this.siblings,
    required Gender gender,
    required this.father,
    required this.guardian,
    required this.mother,
    String? address,
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? imageUrl,
    String? lastName,
    String? primaryPhone,
    String? secondaryPhone,
    String? state,
  }) : super(
          name: name,
          email: email,
          entityType: EntityType.student,
          icNumber: icNumber,
          address: address,
          gender: gender,
          addressLine1: addressLine1,
          addressLine2: addressLine2,
          city: city,
          imageUrl: imageUrl,
          lastName: lastName,
          primaryPhone: primaryPhone,
          secondaryPhone: secondaryPhone,
          state: state,
        );

  String studentClass;
  String section;
  String? father;
  String? mother;
  String? guardian;
  List<String> get parent {
    List<String> result = [];
    if (father != null) {
      result.add(father!);
    }
    if (mother != null) {
      result.add(mother!);
    }
    if (guardian != null) {
      result.add(guardian!);
    }
    return result;
  }

  List<String> siblings;

  Bio get bio => this;
  StudentController get controller => StudentController(this);
  factory Student.fromJson(Map<String, dynamic> json) => Student(
        icNumber: json["ic"],
        studentClass: json["class"],
        section: json["section"],
        name: json["name"],
        email: json["email"] ?? '',
        gender: json["gender"] == null ? Gender.male : Gender.values.elementAt(json["gender"]),
        siblings: json["siblings"] == null ? [] : List<String>.from(json["siblings"].map((x) => x)),
        father: json["father"],
        guardian: json["guardian"],
        mother: json["mother"],
        address: json["address"],
        addressLine1: json["addressLine1"],
        addressLine2: json["addressLine2"],
        city: json["city"],
        imageUrl: json["imageUrl"],
        lastName: json["lastName"],
        primaryPhone: json["primaryPhone"],
        secondaryPhone: json["secondaryPhone"],
        state: json["state"],
      );

  List<String> get search {
    List<String> results = [];
    name.split(' ').map((e) => makeSearchstring(e)).forEach((element) {
      results.addAll(element);
    });
    results.addAll(makeSearchstring(icNumber));
    try {
      results.addAll(makeSearchstring(email.split('@').first));
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return results;
  }

  Map<String, dynamic> toJson() => {
        "ic": icNumber,
        "class": studentClass,
        "section": section,
        "name": name,
        "email": email,
        "parent": parent,
        "siblings": siblings,
        "father": father,
        "mother": mother,
        "entityType": entityType.index,
        "guardian": guardian,
        "address": address,
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "city": city,
        "imageUrl": imageUrl,
        "lastName": lastName,
        "primaryPhone": primaryPhone,
        'secondaryPhone': secondaryPhone,
        "state": state,
        "search": search,
      };
}
