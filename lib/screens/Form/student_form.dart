import 'package:flutter/material.dart';
import 'package:school_app/controllers/Form%20Controllers/student_form_state.dart';
import 'package:school_app/models/biodata.dart';
import 'package:school_app/models/student.dart';
import 'package:school_app/screens/student_form.dart';
import 'package:school_app/widgets/custom_drop_down.dart';

import '../../constants/get_constants.dart';
import '../../controllers/session_controller.dart';
import '../../form_controller.dart';
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

class _StudentFormState extends State<StudentForm> {
  late FormMode formMode;

  final _formKey = GlobalKey<FormState>();
  StudentFormController get controller => session.formcontroller;
  @override
  void initState() {
    formMode = widget.student == null ? FormMode.update : FormMode.add;
    state = widget.student == null ? StudentFormState() : StudentFormState();
    super.initState();
  }

  late StudentFormState state;
  String? requiredValidator(String? val) {
    var text = val ?? '';
    if (text.isEmpty) {
      return "This is a required field";
    }
    return null;
  }

  String? anyOneValidator(String? val) {
    if (controller.father.text.isNotEmpty ||
        controller.mother.text.isNotEmpty ||
        controller.guardian.text.isNotEmpty) {
      return null;
    }
    return "Either a parent or guardian is required";
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: isDesktop(context)&&isTablet(context)?EdgeInsets.only(left: getWidth(context)*0.25):EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Add Student',
                    style: getText(context)
                        .headline6!
                        .apply(color: getColor(context).primary),
                  ),
                ),

                Padding(
                  padding: isMobile(context)?EdgeInsets.symmetric(horizontal: getWidth(context)*0.25):EdgeInsets.all( getWidth(context)*0.05),
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
                              session.update();
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
                    style: getText(context)
                        .headline6!
                        .apply(color: getColor(context).primary),
                  ),
                ),
                Center(
                  child: CustomLayout(
                    mainAxisAlignment:MainAxisAlignment.start,
                    children: [

                      SizedBox(
                        width: isMobile(context)
                            ? getWidth(context) * 0.80
                            : getWidth(context) * 0.20,
                        child: CustomTextField(
                          validator: requiredValidator,
                          controller: controller.name,
                          labelText: 'Name   ',
                        ),
                      ),

      SizedBox(
        width: isMobile(context)
              ? getWidth(context) * 0.80
              : getWidth(context) * 0.20,
        child: CustomDropDown(
                        labelText: 'Gender',
                        items: const [
                          DropdownMenuItem(child: Text('Male'), value: Gender.male),
                          DropdownMenuItem(child: Text('Female'), value: Gender.female),
                          DropdownMenuItem(child: Text('Unspecified'), value: Gender.unspecified),
                        ],
                        selectedValue: state.gender),
      ),

                      SizedBox(
                        width: isMobile(context)
                            ? getWidth(context) * 0.80
                            : getWidth(context) * 0.20,
                        child: CustomDropDown<String?>(
                          labelText: 'Class',
                          items: controller.classItems,
                          selectedValue: controller.classField,
                          onChanged: (text) {
                            setState(() {
                              if (controller.classField != text) {
                                controller.classField = text ?? controller.classField;
                                controller.sectionField = null;
                              }
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: isMobile(context)
                            ? getWidth(context) * 0.80
                            : getWidth(context) * 0.20,
                        child: CustomDropDown<String?>(
                          labelText: 'Section',
                          items: controller.sectionItems,
                          selectedValue: controller.sectionField,
                          onChanged: (text) {
                            setState(() {
                              controller.sectionField =
                                  text ?? controller.sectionField;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: CustomLayout(
                    mainAxisAlignment:MainAxisAlignment.start,
                    children: [

                      SizedBox(
                        width: isMobile(context)
                            ? getWidth(context) * 0.80
                            : getWidth(context) * 0.20,
                        child: CustomTextField(
                          validator: requiredValidator,
                          controller: controller.id,
                          labelText: 'ID     ',
                        ),
                      ),
                      SizedBox(
                          width: isMobile(context)
                              ? getWidth(context) * 0.80
                              : getWidth(context) * 0.20,
                          child: CustomTextField(
                              validator: anyOneValidator,
                              controller: controller.father,
                              labelText: "Father ")),
                      SizedBox(
                          width: isMobile(context)
                              ? getWidth(context) * 0.80
                              : getWidth(context) * 0.20,
                          child: CustomTextField(
                              validator: anyOneValidator,
                              controller: controller.mother,
                              labelText: "Mother ")),
                      SizedBox(
                        width: isMobile(context)
                            ? getWidth(context) * 0.80
                            : getWidth(context) * 0.20,
                        child: CustomTextField(
                          validator: anyOneValidator,
                          controller: controller.guardian,
                          labelText: "Guardian",
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Contact Details',
                    style: getText(context)
                        .headline6!
                        .apply(color: getColor(context).primary),
                  ),
                ),
                Center(
                  child: CustomLayout(
                      mainAxisAlignment:MainAxisAlignment.start,
                      children: [
                    SizedBox(
                      width: isMobile(context)
                          ? getWidth(context) * 0.80
                          : getWidth(context) * 0.20,
                      child: CustomTextField(
                        validator: requiredValidator,
                        controller: controller.contact,
                        labelText: "Contact",
                      ),
                    ),
                    SizedBox(
                      width: isMobile(context)
                          ? getWidth(context) * 0.80
                          : getWidth(context) * 0.20,
                      child: CustomTextField(
                        validator: requiredValidator,
                        controller: controller.address,
                        labelText: "Address Line 1",
                      ),
                    ),
                    SizedBox(
                      width: isMobile(context)
                          ? getWidth(context) * 0.80
                          : getWidth(context) * 0.20,
                      child: CustomTextField(
                        validator: requiredValidator,
                        controller: controller.address,
                        labelText: "Address Line 2",
                      ),
                    ),
                    SizedBox(
                      width: isMobile(context)
                          ? getWidth(context) * 0.80
                          : getWidth(context) * 0.20,
                      child: CustomTextField(
                        validator: requiredValidator,
                        controller: controller.address,
                        labelText: "City",
                      ),
                    ),
                  ]),
                ),
                Center(
                  child: CustomLayout(

                      mainAxisAlignment:MainAxisAlignment.start,
                      children: [
                    SizedBox(
                      width: isMobile(context)
                          ? getWidth(context) * 0.80
                          : getWidth(context) * 0.20,
                      child: CustomTextField(
                        validator: requiredValidator,
                        controller: controller.contact,
                        labelText: "State",
                      ),
                    ),
                    SizedBox(
                      width: isMobile(context)
                          ? getWidth(context) * 0.80
                          : getWidth(context) * 0.20,
                      child: CustomTextField(
                        validator: requiredValidator,
                        controller: controller.address,
                        labelText: "Primary Mobile ",
                      ),
                    ),
                    SizedBox(
                      width: isMobile(context)
                          ? getWidth(context) * 0.80
                          : getWidth(context) * 0.20,
                      child: CustomTextField(
                        validator: requiredValidator,
                        controller: controller.address,
                        labelText: "Secondary Mobile",
                      ),
                    ),

                  ]),
                ),

                Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Siblings',
                    style: getText(context)
                        .headline6!
                        .apply(color: getColor(context).primary),
                  ),
                ),


                Center(
                  child: CustomLayout(
                    mainAxisAlignment:MainAxisAlignment.start,
                    children: [

                      SizedBox(
                        width: isMobile(context)
                            ? getWidth(context) * 0.80
                            : getWidth(context) * 0.20,
                        child: CustomTextField(
                          validator: requiredValidator,
                          controller: controller.name,
                          labelText: 'Name   ',
                        ),
                      ),

                      SizedBox(
                        width: isMobile(context)
                            ? getWidth(context) * 0.80
                            : getWidth(context) * 0.20,
                        child: CustomDropDown(
                            labelText: 'Gender',
                            items: const [
                              DropdownMenuItem(child: Text('Male'), value: Gender.male),
                              DropdownMenuItem(child: Text('Female'), value: Gender.female),
                              DropdownMenuItem(child: Text('Unspecified'), value: Gender.unspecified),
                            ],
                            selectedValue: state.gender),
                      ),

                      SizedBox(
                        width: isMobile(context)
                            ? getWidth(context) * 0.80
                            : getWidth(context) * 0.20,
                        child: CustomDropDown<String?>(
                          labelText: 'Class',
                          items: controller.classItems,
                          selectedValue: controller.classField,
                          onChanged: (text) {
                            setState(() {
                              if (controller.classField != text) {
                                controller.classField = text ?? controller.classField;
                                controller.sectionField = null;
                              }
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: isMobile(context)
                            ? getWidth(context) * 0.80
                            : getWidth(context) * 0.20,
                        child: CustomDropDown<String?>(
                          labelText: 'Section',
                          items: controller.sectionItems,
                          selectedValue: controller.sectionField,
                          onChanged: (text) {
                            setState(() {
                              controller.sectionField =
                                  text ?? controller.sectionField;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Vehicle Details',
                    style: getText(context)
                        .headline6!
                        .apply(color: getColor(context).primary),
                  ),
                ),
                Center(
                  child: CustomLayout(

                      mainAxisAlignment:MainAxisAlignment.start,
                      children: [
                    SizedBox(
                      width: isMobile(context)
                          ? getWidth(context) * 0.80
                          : getWidth(context) * 0.20,
                      child: const CustomTextField(

                        labelText: "Vehicle 1  ",
                      ),
                    ),
                    SizedBox(
                      width: isMobile(context)
                          ? getWidth(context) * 0.80
                          : getWidth(context) * 0.20,
                      child: const CustomTextField(

                        labelText: "Vehicle 2  ",
                      ),
                    ),
                    SizedBox(
                      width: isMobile(context)
                          ? getWidth(context) * 0.80
                          : getWidth(context) * 0.20,
                      child: const CustomTextField(

                        labelText: "Vehicle 3  ",
                      ),
                    ),

                  ]),
                ),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0,),
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!
                              .validate()) {}
                        },
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 50),
                          child: Text("Submit"),
                        )),
                  ),
                ),



              ],
            ),
          ),
        ));
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
            decoration: new InputDecoration(
              alignLabelWithHint: true,
              focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(width: 2, color: getColor(context).primary)),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
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

