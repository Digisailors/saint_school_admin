import 'package:school_app/models/teacher.dart';
import 'package:school_app/screens/Form/controllers/bio_form_controller.dart';

class TeacherFormController with BioFormController {
  String? className;
  String? section;
  String? uid;

  @override
  clear() {
    className = null;
    section = null;
    uid = null;
    return super.clear();
  }

  Teacher get object => Teacher(
        className: className,
        section: section,
        uid: uid,
        email: email.text,
        gender: gender,
        icNumber: icNumber.text,
        name: name.text,
        address: address.text,
        addressLine1: addressLine1.text,
        addressLine2: addressLine2.text,
        city: city.text,
        imageUrl: image,
        lastName: lastName.text,
        primaryPhone: primaryPhone.text,
        secondaryPhone: secondaryPhone.text,
        state: state.text,
      );
}
