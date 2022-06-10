import 'package:flutter/cupertino.dart';
import 'package:school_app/controllers/Form%20Controllers/bio_form_state.dart';

class StudentFormState with BioFormState {
  List<TextEditingController> parents = [];
  List<TextEditingController> siblings = [];
  StudentFormState();
}
