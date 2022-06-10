class Bio {
  Bio({required this.name, required this.entityType, required this.icNumber, required this.email, this.address, this.imageUrl, required this.gender});

  String name;
  EntityType entityType;
  String icNumber;
  String email;
  String? address;
  String? imageUrl;
  Gender gender;

  Map<String, dynamic> toJson() =>
      {"name": name, "entityType": entityType, "icNumber": icNumber, "email": email, "address": address, "imageUrl": imageUrl};
}

enum EntityType { student, teacher, parent, admin }

enum Gender { male, female, unspecified }