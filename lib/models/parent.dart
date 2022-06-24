import 'package:school_app/controllers/parent_controller.dart';
import 'package:school_app/models/biodata.dart';

class Parent extends Bio {
  Parent({
    required icNumber,
    required email,
    required name,
    required this.children,
    required gender,
    address,
    addressLine1,
    addressLine2,
    city,
    imageUrl,
    lastName,
    primaryPhone,
    secondaryPhone,
    this.uid,
  }) : super(
          name: name,
          email: email,
          entityType: EntityType.parent,
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
        );

  List<String> children;
  String? uid;

  Bio get bio => this;

  ParentController get controller => ParentController(parent: this);

  copyWith(Parent parent) {
    gender = parent.gender;
    address = parent.address;
    uid = parent.uid;
    icNumber = parent.icNumber;
    email = parent.email;
    name = parent.name;
    children = parent.children;
    addressLine1 = parent.addressLine1;
    addressLine2 = parent.addressLine2;
    city = parent.city;
    imageUrl = parent.imageUrl;
    lastName = parent.lastName;
    primaryPhone = parent.primaryPhone;
    secondaryPhone = parent.secondaryPhone;
  }

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
        gender: Gender.values.elementAt(json["gender"]),
        address: json["address"] ?? '',
        uid: json["uid"] ?? '',
        icNumber: json["icNumber"] ?? '',
        email: json["email"] ?? '',
        name: json["name"],
        children: List<String>.from(json["children"].map((x) => x)),
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {"children": children};
    map.addAll(super.toBioJson());
    return map;
  }
}
