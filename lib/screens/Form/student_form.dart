import 'package:flutter/material.dart';
import 'package:school_app/controllers/Form%20Controllers/student_form_state.dart';
import 'package:school_app/controllers/student_controller.dart';
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
  late StudentFormState state;

  final _formKey = GlobalKey<FormState>();
  StudentFormController get controller => session.formcontroller;
  @override
  void initState() {
    formMode = widget.student == null ? FormMode.update : FormMode.add;
    state = widget.student == null ? StudentFormState() : StudentFormState();
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
    if (controller.father.text.isNotEmpty ||
        controller.mother.text.isNotEmpty ||
        controller.guardian.text.isNotEmpty) {
      return null;
    }
    return "Either a parent or guardian is required";
  }
  final TextEditingController ContactName=TextEditingController();
  final TextEditingController AddressLine1=TextEditingController();
  final TextEditingController AddressLine2=TextEditingController();
  final TextEditingController City=TextEditingController();
  final TextEditingController stateController=TextEditingController();
  final TextEditingController PrimaryMobile=TextEditingController();
  final TextEditingController SecondaryMobile=TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: isDesktop(context)&&isTablet(context)?EdgeInsets.only(left: getWidth(context)*0.25):EdgeInsets.all(8),
            child: Form(
              key: _formKey,
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
                            hintText: 'Student Name',
                            validator: requiredValidator,
                            controller: state.name,
                            labelText: 'Name   ',
                          ),
                        ),

      SizedBox(
        width: isMobile(context)
                ? getWidth(context) * 0.80
                : getWidth(context) * 0.20,
        child: CustomDropDown(
              onChanged: (Gender? text) {
                setState(() {
                  state.gender = text! ;
                });
              },
                          labelText: 'Gender',
                          items: const [
                            DropdownMenuItem(child: Text('Male'), value: Gender.male),
                            DropdownMenuItem(child: Text('Female'), value: Gender.female),
                            DropdownMenuItem(child: Text('Unspecified'), value: Gender.unspecified),
                          ],
                          selectedValue: state.gender



        ),
      ),

                        SizedBox(
                          width: isMobile(context)
                              ? getWidth(context) * 0.80
                              : getWidth(context) * 0.20,
                          child: CustomDropDown<String?>(
                            labelText: 'Class',
                            items: controller.classItems,
                            selectedValue: state.studentClass,
                            onChanged: (text) {
                              setState(() {
                               state.studentClass = text ;
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
                            items:<String>['A', 'B', 'C', 'D']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            selectedValue: state.section,
                            onChanged: (text) {
                              setState(() {
                               state.section = text;
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
                            labelText: 'ICNO    ',
                          ),
                        ),
                        SizedBox(
                            width: isMobile(context)
                                ? getWidth(context) * 0.80
                                : getWidth(context) * 0.20,
                            child: CustomTextField(
                              hintText: 'Andrew Simons',
                                validator: anyOneValidator,
                                controller: controller.father,
                                labelText: "Father ")),
                        SizedBox(
                            width: isMobile(context)
                                ? getWidth(context) * 0.80
                                : getWidth(context) * 0.20,
                            child: CustomTextField(
                              hintText: 'Eliza',
                                validator: anyOneValidator,
                                controller: controller.mother,
                                labelText: "Mother ")),
                        SizedBox(
                          width: isMobile(context)
                              ? getWidth(context) * 0.80
                              : getWidth(context) * 0.20,
                          child: CustomTextField(
                            hintText: 'Name of the person',
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
                          controller: ContactName,
                          labelText: "Contact",
                        ),
                      ),
                      SizedBox(
                        width: isMobile(context)
                            ? getWidth(context) * 0.80
                            : getWidth(context) * 0.20,
                        child: CustomTextField(
                          validator: requiredValidator,
                          controller:AddressLine1,
                          labelText: "Address Line 1",
                        ),
                      ),
                      SizedBox(
                        width: isMobile(context)
                            ? getWidth(context) * 0.80
                            : getWidth(context) * 0.20,
                        child: CustomTextField(
                          validator: requiredValidator,
                          controller: AddressLine2,
                          labelText: "Address Line 2",
                        ),
                      ),
                      SizedBox(
                        width: isMobile(context)
                            ? getWidth(context) * 0.80
                            : getWidth(context) * 0.20,
                        child: CustomTextField(
                          validator: requiredValidator,
                          controller:City,
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
                          controller: stateController,
                          labelText: "State",
                        ),
                      ),
                      SizedBox(
                        width: isMobile(context)
                            ? getWidth(context) * 0.80
                            : getWidth(context) * 0.20,
                        child: CustomTextField(
                          validator: requiredValidator,
                          controller: PrimaryMobile,
                          labelText: "Primary Mobile ",
                        ),
                      ),
                      SizedBox(
                        width: isMobile(context)
                            ? getWidth(context) * 0.80
                            : getWidth(context) * 0.20,
                        child: CustomTextField(
                          validator: requiredValidator,
                          controller: SecondaryMobile,
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
                            labelText: 'ICNO 1 ',
                          ),
                        ),
                        SizedBox(
                          width: isMobile(context)
                              ? getWidth(context) * 0.80
                              : getWidth(context) * 0.20,
                          child: CustomTextField(
                            validator: requiredValidator,
                            controller: controller.name,
                            labelText: 'ICNO 2',
                          ),
                        ),
                        SizedBox(
                          width: isMobile(context)
                              ? getWidth(context) * 0.80
                              : getWidth(context) * 0.20,
                          child: CustomTextField(
                            validator: requiredValidator,
                            controller: controller.name,
                            labelText: 'ICNO 3',
                          ),
                        ),
                        SizedBox(
                          width: isMobile(context)
                              ? getWidth(context) * 0.80
                              : getWidth(context) * 0.20,
                          child: CustomTextField(
                            validator: requiredValidator,
                            controller: controller.name,
                            labelText: 'ICNO ',
                          ),
                        ),


                      ],
                    ),
                  ),


                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0,),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!
                                .validate()) {
                               var student = state.object;
                               StudentController(student).add();

                            }
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
            decoration:  InputDecoration(
              alignLabelWithHint: true,
              focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(width: 2, color: getColor(context).primary)),
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

