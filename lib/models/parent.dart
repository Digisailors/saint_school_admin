import 'package:school_app/controllers/parent_controller.dart';
import 'package:school_app/models/biodata.dart';

class Parent extends Bio {
  Parent({
    required this.children,
    this.uid,
    required String icNumber,
    required String email,
    required String name,
    required Gender gender,
    String? lastName,
    String? address,
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? state,
    String? primaryPhone,
    String? secondaryPhone,
    String? imageUrl,
  }) : super(
          name: name,
          lastName: lastName,
          entityType: EntityType.parent,
          icNumber: icNumber,
          email: email,
          address: address,
          addressLine1: addressLine1,
          addressLine2: addressLine2,
          city: city,
          state: state,
          primaryPhone: primaryPhone,
          secondaryPhone: secondaryPhone,
          imageUrl: imageUrl,
          gender: gender,
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
        addressLine1: json["addressLine1"],
        addressLine2: json["addressLine2"],
        city: json["city"],
        imageUrl: json["imageUrl"],
        lastName: json["lastName"],
        primaryPhone: json["primaryPhone"],
        secondaryPhone: json["secondaryPhone"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {"children": children};
    map.addAll(super.toBioJson());
    return map;
  }
}
