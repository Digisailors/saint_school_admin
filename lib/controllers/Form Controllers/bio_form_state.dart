import 'package:flutter/cupertino.dart';
import 'package:school_app/models/biodata.dart';

class BioFormState {
  final name = TextEditingController();
  final icNumber = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();
  final imageUrl = TextEditingController();
  Gender gender = Gender.male;
}
