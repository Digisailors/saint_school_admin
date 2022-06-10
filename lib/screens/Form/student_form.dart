import 'package:flutter/material.dart';
import 'package:school_app/controllers/Form%20Controllers/student_form_state.dart';
import 'package:school_app/models/biodata.dart';
import 'package:school_app/models/student.dart';
import 'package:school_app/screens/student_form.dart';
import 'package:school_app/widgets/custom_drop_down.dart';

class StudentForm extends StatefulWidget {
  const StudentForm({
    Key? key,
    this.student,
  }) : super(key: key);

  final Student? student;
  static String routeName = '/student';

  @override
  State<StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  late FormMode formMode;
  @override
  void initState() {
    formMode = widget.student == null ? FormMode.update : FormMode.add;
    state = widget.student == null ? StudentFormState() : StudentFormState();
    super.initState();
  }

  late StudentFormState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Wrap(
        children: [
          CustomTextFormField(controller: state.name, label: 'Name'),
          CustomTextFormField(controller: state.name, label: 'Email'),
          CustomTextFormField(controller: state.name, label: 'IC Nmber'),
          CustomTextFormField(controller: state.name, label: 'Image Url'),
          CustomTextFormField(controller: state.name, label: 'Address'),
          CustomDropDown(
              labelText: 'Gender',
              items: const [
                DropdownMenuItem(child: Text('Male'), value: Gender.male),
                DropdownMenuItem(child: Text('Female'), value: Gender.female),
                DropdownMenuItem(child: Text('Unspecified'), value: Gender.unspecified),
              ],
              selectedValue: state.gender),
        ],
      ),
    );
  }
}
