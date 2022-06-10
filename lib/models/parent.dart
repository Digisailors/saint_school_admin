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
  }) : super(name: name, email: email, entityType: EntityType.parent, icNumber: icNumber, address: address, gender: gender);

  List<String> children;

  Bio get bio => this;

  ParentController get controller => ParentController(parent: this);

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
        gender: Gender.values.elementAt(json["gender"]),
        icNumber: json["ic"],
        email: json["email"],
        name: json["name"],
        children: List<String>.from(json["children"].map((x) => x)),
      );

  @override
  Map<String, dynamic> toJson() {
    var map = bio.toJson();
    map.addAll({"children": children});
    return map;
  }
}
