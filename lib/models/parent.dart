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
    this.uid,
  }) : super(name: name, email: email, entityType: EntityType.parent, icNumber: icNumber, address: address, gender: gender);

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

  @override
  Map<String, dynamic> toJson() => {
    "gender" : gender,
    "address" : address,
    "uid" : uid,
    "icNumber" : icNumber,
    "email" : email,
    "name" : name,
    "children" : children
  };
}