class Bio {
  Bio({
    required this.name,
    required this.entityType,
    required this.icNumber,
    required this.email,
    required this.gender,
    this.address,
    this.lastName,
    this.imageUrl,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.primaryPhone,
    this.secondaryPhone,
    this.state,
  });

  String name;
  String? lastName;
  EntityType entityType;
  String icNumber;
  String email;
  String? address;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? primaryPhone;
  String? secondaryPhone;
  String? imageUrl;
  Gender gender;

  Map<String, dynamic> toJson() => {
        "name": name,
        "entityType": entityType,
        "icNumber": icNumber,
        "email": email,
        "address": address,
        "imageUrl": imageUrl,
        "lastName": lastName,
      };
}

enum EntityType { student, teacher, parent, admin }

enum Gender { male, female, unspecified }
