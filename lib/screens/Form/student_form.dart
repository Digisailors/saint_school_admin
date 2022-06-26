import 'package:flutter/material.dart';
import 'package:school_app/constants/constant.dart';
import 'package:school_app/models/biodata.dart';
import 'package:school_app/models/response.dart';
import 'package:school_app/models/student.dart';
// import 'package:school_app/screens/student_form.dart';
import 'package:school_app/widgets/custom_drop_down.dart';

import '../../constants/get_constants.dart';
import 'controllers/student_form_controller.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/theme.dart';

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

enum FormMode { add, update, view }

class _StudentFormState extends State<StudentForm> {
  late FormMode formMode;
  late StudentFormController controller;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    formMode = widget.student == null ? FormMode.add : FormMode.update;
    controller = widget.student == null ? StudentFormController() : StudentFormController.fromStudent(widget.student!);
    super.initState();
  }

  String? requiredValidator(String? val) {
    var text = val ?? '';
    if (text.isEmpty) {
      return "This is a required field";
    }
    return null;
  }

  String? anyOneValidator(String? val) {
    if (controller.father.text.isNotEmpty || controller.mother.text.isNotEmpty || controller.guardian.text.isNotEmpty) {
      return null;
    }
    return "Either a parent or guardian is required";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: isDesktop(context) && isTablet(context) ? EdgeInsets.only(left: getWidth(context) * 0.25) : const EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back)),
                title: Text(
                  'Student Form',
                  style: getText(context).headline6!.apply(color: getColor(context).primary),
                ),
              ),
              Padding(
                padding: isMobile(context) ? EdgeInsets.symmetric(horizontal: getWidth(context) * 0.25) : EdgeInsets.all(getWidth(context) * 0.05),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 80,
                        foregroundImage: controller.getAvatar(),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          controller.imagePicker().then((value) {
                            setState(() {});
                          });
                        },
                        child: const Text(
                          "Upload Picture",
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Personal Details',
                  style: getText(context).headline6!.apply(color: getColor(context).primary),
                ),
              ),
              Center(
                child: CustomLayout(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: isMobile(context) ? getWidth(context) * 0.80 : getWidth(context) * 0.20,
                      child: CustomTextField(
                        hintText: 'Student Name',
                        validator: requiredValidator,
                        controller: controller.name,
                        labelText: 'Name   ',
                      ),
                    ),
                    SizedBox(
                      width: isMobile(context) ? getWidth(context) * 0.80 : getWidth(context) * 0.20,
                      child: CustomDropDown(
                          onChanged: (Gender? text) {
                            setState(() {
                              controller.gender = text!;
                            });
                          },
                          labelText: 'Gender',
                          items: const [
                            DropdownMenuItem(child: Text('Male'), value: Gender.male),
                            DropdownMenuItem(child: Text('Female'), value: Gender.female),
                            DropdownMenuItem(child: Text('Unspecified'), value: Gender.unspecified),
                          ],
                          selectedValue: controller.gender),
                    ),
                    SizedBox(
                      width: isMobile(context) ? getWidth(context) * 0.80 : getWidth(context) * 0.20,
                      child: CustomDropDown<String?>(
                        labelText: 'Class',
                        items: controller.classItems,
                        selectedValue: controller.classField,
                        onChanged: (text) {
                          setState(() {
                            controller.classField = text;
                            controller.sectionField = null;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: isMobile(context) ? getWidth(context) * 0.80 : getWidth(context) * 0.20,
                      child: CustomDropDown<String?>(
                        labelText: 'Section',
                        items: controller.sectionItems,
                        selectedValue: controller.sectionField,
                        onChanged: (text) {
                          setState(() {
                            controller.sectionField = text;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: CustomLayout(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: isMobile(context) ? getWidth(context) * 0.80 : getWidth(context) * 0.20,
                      child: CustomTextField(
                        validator: requiredValidator,
                        controller: controller.icNumber,
                        labelText: 'IC Number',
                        hintText: 'Enter IC Number',
                      ),
                    ),
                    SizedBox(
                        width: isMobile(context) ? getWidth(context) * 0.80 : getWidth(context) * 0.20,
                        child: CustomTextField(
                          hintText: 'Enter IC Number',
                          validator: anyOneValidator,
                          controller: controller.father,
                          labelText: "Father",
                        )),
                    SizedBox(
                      width: isMobile(context) ? getWidth(context) * 0.80 : getWidth(context) * 0.20,
                      child: CustomTextField(
                        hintText: 'Enter IC Number',
                        validator: anyOneValidator,
                        controller: controller.mother,
                        labelText: "Mother ",
                      ),
                    ),
                    SizedBox(
                      width: isMobile(context) ? getWidth(context) * 0.80 : getWidth(context) * 0.20,
                      child: CustomTextField(
                        hintText: 'Enter IC Number',
                        validator: anyOneValidator,
                        controller: controller.guardian,
                        labelText: "Guardian",
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Contact Details',
                  style: getText(context).headline6!.apply(color: getColor(context).primary),
                ),
              ),
              Center(
                child: CustomLayout(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SizedBox(
                    width: isMobile(context) ? getWidth(context) * 0.80 : getWidth(context) * 0.20,
                    child: CustomTextField(
                      validator: requiredValidator,
                      controller: controller.email,
                      labelText: "Email",
                    ),
                  ),
                  SizedBox(
                    width: isMobile(context) ? getWidth(context) * 0.80 : getWidth(context) * 0.20,
                    child: CustomTextField(
                      validator: requiredValidator,
                      controller: controller.addressLine1,
                      labelText: "Address Line 1",
                    ),
                  ),
                  SizedBox(
                    width: isMobile(context) ? getWidth(context) * 0.80 : getWidth(context) * 0.20,
                    child: CustomTextField(
                      validator: requiredValidator,
                      controller: controller.addressLine2,
                      labelText: "Address Line 2",
                    ),
                  ),
                  SizedBox(
                    width: isMobile(context) ? getWidth(context) * 0.80 : getWidth(context) * 0.20,
                    child: CustomTextField(
                      validator: requiredValidator,
                      controller: controller.city,
                      labelText: "City",
                    ),
                  ),
                ]),
              ),
              Center(
                child: CustomLayout(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SizedBox(
                    width: isMobile(context) ? getWidth(context) * 0.80 : getWidth(context) * 0.20,
                    child: CustomTextField(
                      validator: requiredValidator,
                      controller: controller.state,
                      labelText: "State",
                    ),
                  ),
                  SizedBox(
                    width: isMobile(context) ? getWidth(context) * 0.80 : getWidth(context) * 0.20,
                    child: CustomTextField(
                      validator: requiredValidator,
                      controller: controller.primaryPhone,
                      labelText: "Primary Mobile ",
                    ),
                  ),
                  SizedBox(
                    width: isMobile(context) ? getWidth(context) * 0.80 : getWidth(context) * 0.20,
                    child: CustomTextField(
                      validator: requiredValidator,
                      controller: controller.secondaryPhone,
                      labelText: "Secondary Mobile",
                    ),
                  ),
                ]),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Siblings',
                  style: getText(context).headline6!.apply(color: getColor(context).primary),
                ),
              ),
              Center(
                child: CustomLayout(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: getSiblingsField(context),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          var student = controller.student;

                          Future<Result> future;
                          if (formMode == FormMode.add) {
                            future = controller.createUser();
                          } else {
                            future = controller.updateUser();
                          }
                          showFutureCustomDialog(
                              context: context,
                              future: future,
                              onTapOk: () {
                                Navigator.of(context).pop();
                                formMode = FormMode.update;
                              });
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 50),
                        child: Text("Submit"),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  List<Widget> getSiblingsField(BuildContext context) {
    List<Widget> list = controller.siblings
        .map(
          (e) => SizedBox(
            width: isMobile(context) ? getWidth(context) * 0.80 : getWidth(context) * 0.20,
            child: CustomTextField(
              validator: requiredValidator,
              controller: e,
              labelText: 'IC Number',
            ),
          ),
        )
        .toList();
    list.add(SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: TextButton(
            onPressed: () {
              setState(() {
                controller.siblings.add(TextEditingController());
              });
            },
            child: const Text("Add")),
      ),
    ));
    return list;
  }
}

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getHeight(context) * 0.10,
      width: getWidth(context) * 0.10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text('Name'),
          ),
          TextField(
            decoration: InputDecoration(
              alignLabelWithHint: true,
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: getColor(context).primary)),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: "Ex.Andrew Simons",
            ),
          ),
        ],
      ),
    );
  }
}

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(),
  //     body: Wrap(
  //       children: [
  //         CustomTextFormField(controller: state.name, label: 'Name'),
  //         CustomTextFormField(controller: state.name, label: 'Email'),
  //         CustomTextFormField(controller: state.name, label: 'IC Nmber'),
  //         CustomTextFormField(controller: state.name, label: 'Image Url'),
  //         CustomTextFormField(controller: state.name, label: 'Address'),
  //         CustomDropDown(
  //             labelText: 'Gender',
  //             items: const [
  //               DropdownMenuItem(child: Text('Male'), value: Gender.male),
  //               DropdownMenuItem(child: Text('Female'), value: Gender.female),
  //               DropdownMenuItem(child: Text('Unspecified'), value: Gender.unspecified),
  //             ],
  //             selectedValue: state.gender),
  //       ],
  //     ),
  //   );
  // }

