import 'package:school_app/models/biodata.dart';

class Admin extends Bio {
  Admin({
    email,
    gender,
    icNumber,
    name,
    address,
    imageUrl,
    required this.docId,
  }) : super(
          email: email,
          entityType: EntityType.admin,
          gender: gender,
          icNumber: icNumber,
          name: name,
          address: address,
          imageUrl: imageUrl,
        );
  String docId;
  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        docId: json['docId'],
        gender: Gender.values.elementAt(json["gender"]),
        icNumber: json["ic"],
        email: json["email"],
        name: json["name"],
        address: json["address"],
        imageUrl: json["imageUrl"],
      );
}
