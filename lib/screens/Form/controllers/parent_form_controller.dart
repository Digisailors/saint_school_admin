import 'package:get/get_utils/get_utils.dart';
import 'package:flutter/material.dart';
import 'package:school_app/constants/constant.dart';

import 'package:school_app/controllers/parent_controller.dart';
import 'package:school_app/models/biodata.dart';
import 'package:school_app/models/parent.dart';
import 'package:school_app/screens/Form/controllers/bio_form_controller.dart';

import '../../../models/response.dart' as r;

enum Provide { network, memory, logo }

class ParentFormController with BioFormController {
  ParentFormController();
  List<String> children = [];
  EntityType entityType = EntityType.parent;
  String? uid;

  @override
  clear() {
    children = [];
    uid = null;
    super.clear();
  }

  Future<r.Result> createUser() async {
    var snapshot = await students.doc(icNumber.text.toUpperCase().removeAllWhitespace).get();
    if (snapshot.exists) {
      var data = snapshot.data();
      return r.Result.error("ID is taken by another student ${data!['name']}");
    }
    if (fileData != null) {
      image = await uploadImage(fileData!, icNumber.text.toUpperCase().removeAllWhitespace);
    }

    var controller = ParentController(parent: parent);

    return controller.add().then((value) {
      clear();
      return value;
    });
  }

  Future<r.Result> updateUser({bool nameCheck = false}) async {
    if (fileData != null) {
      image = await uploadImage(fileData!, icNumber.text);
    }
    if (nameCheck) {
      var snapshot = await students.doc(icNumber.text.toUpperCase().removeAllWhitespace).get();
      if (snapshot.exists) {
        var data = snapshot.data();
        return r.Result.error("ID is taken by another student ${data!['name']}");
      }
    }
    var controller = ParentController(parent: parent);
    return controller.change().then((value) {
      // session.loadStudents();
      return value;
    });
  }

  Parent get parent => Parent(
        name: name.text,
        icNumber: icNumber.text.toUpperCase().removeAllWhitespace,
        email: email.text,
        imageUrl: image,
        addressLine1: addressLine1.text,
        addressLine2: addressLine2.text,
        city: city.text,
        primaryPhone: primaryPhone.text,
        secondaryPhone: secondaryPhone.text,
        address: addressLine1.text,
        gender: gender,
        lastName: lastName.text,

        //------------------------
        children: children,
        uid: uid,
      );

  factory ParentFormController.fromParent(Parent parent) {
    ParentFormController controller = ParentFormController();
    controller.name.text = parent.name;
    controller.icNumber.text = parent.icNumber;
    controller.image = parent.imageUrl;
    controller.state.text = parent.state ?? '';
    controller.email.text = parent.email;
    controller.addressLine1.text = parent.addressLine1 ?? '';
    controller.addressLine2.text = parent.addressLine2 ?? '';
    controller.city.text = parent.city ?? '';
    controller.gender = parent.gender;
    controller.primaryPhone.text = parent.primaryPhone ?? '';
    controller.secondaryPhone.text = parent.secondaryPhone ?? '';

    controller.children = parent.children;
    controller.uid = parent.uid;

    return controller;
  }
}
