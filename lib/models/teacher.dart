import 'package:flutter/foundation.dart';
import 'package:school_app/controllers/teacher_controller.dart';

import '../constants/constant.dart';
import 'biodata.dart';

class Teacher extends Bio {
  Teacher({
    required this.className,
    required this.section,
    required email,
    required icNumber,
    required name,
    required gender,
    address,
    addressLine1,
    addressLine2,
    city,
    imageUrl,
    lastName,
    primaryPhone,
    secondaryPhone,
    state,
    this.uid,
  }) : super(
          email: email,
          entityType: EntityType.teacher,
          icNumber: icNumber,
          name: name,
          gender: gender,
          address: address,
          addressLine1: addressLine1,
          addressLine2: addressLine2,
          city: city,
          imageUrl: imageUrl,
          lastName: lastName,
          primaryPhone: primaryPhone,
          secondaryPhone: secondaryPhone,
          state: state,
        );

  String? className;
  String? section;
  String? uid;

  TeacherController get controller => TeacherController(this);

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

  factory Teacher.fromJson(json) => Teacher(
        gender: json["gender"],
        className: json["className"],
        section: json["section"],
        email: json["email"],
        icNumber: json["icNumber"],
        name: json["name"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {"className": className, "section": section, "uid": uid};
    map.addAll(super.toBioJson());
    return map;
  }
}
