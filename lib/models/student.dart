import 'package:school_app/controllers/student_controller.dart';
import 'package:school_app/models/Attendance/department.dart';
import 'package:school_app/models/Attendance/employee.dart';
import 'package:school_app/models/biodata.dart';
import 'parent.dart';

class Student extends Bio {
  Student({
    required String icNumber,
    required this.classDepartment,
    required this.sectionDepartment,
    required String name,
    required String email,
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
    this.empId,
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

  Department classDepartment;
  Department sectionDepartment;

  Parent? father;
  Parent? mother;
  Parent? guardian;
  int? empId;

  static Map<Gender, String> genderCode = {Gender.male: 'M', Gender.female: 'F', Gender.unspecified: 'S'};

  Employee get employee => Employee(empCode: icNumber, department: sectionDepartment.id!, gender: genderCode[gender]!, firstName: name);

  List<String> get parents {
    List<String> result = [];
    if (father != null) {
      result.add(father!.icNumber);
    }
    if (mother != null) {
      result.add(mother!.icNumber);
    }
    if (guardian != null) {
      result.add(guardian!.icNumber);
    }
    return result;
  }

  Bio get bio => this;
  StudentController get controller => StudentController(this);
  factory Student.fromJson(Map<String, dynamic> json) => Student(
        icNumber: json["ic"],
        name: json["name"],
        email: json["email"] ?? '',
        gender: json["gender"] == null ? Gender.male : Gender.values.elementAt(json["gender"]),
        address: json["address"],
        addressLine1: json["addressLine1"],
        addressLine2: json["addressLine2"],
        city: json["city"],
        imageUrl: json["imageUrl"],
        lastName: json["lastName"],
        primaryPhone: json["primaryPhone"],
        secondaryPhone: json["secondaryPhone"],
        state: json["state"],
        empId: json['empId'],
        //-------------------------------------------
        father: json["father"] != null ? Parent.fromJson(json['father']) : null,
        guardian: json["guardian"] != null ? Parent.fromJson(json['guardian']) : null,
        mother: json["mother"] != null ? Parent.fromJson(json['mother']) : null,
        //-------------------------------------------
        classDepartment: Department.fromJson(json["classDepartment"]),
        sectionDepartment: Department.fromJson(json["sectionDepartment"]),
      );

  Map<String, dynamic> toJson() => {
        "ic": icNumber,
        "name": name,
        "email": email,
        "gender": gender.index,
        "entityType": entityType.index,
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
        "empId": empId,
        //------------
        "father": father?.toJson(),
        "mother": mother?.toJson(),
        "guardian": guardian?.toJson(),
        //------------
        "class": classDepartment.id,
        "section": sectionDepartment.id,
        "classDepartment": classDepartment.toJson(),
        "sectionDepartment": sectionDepartment.toJson(),
        //------------
        "parents": parents,
      };
}
