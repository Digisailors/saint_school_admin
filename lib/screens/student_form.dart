import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/constants/constant.dart';
import 'package:school_app/constants/get_constants.dart';
import 'package:school_app/controllers/session_controller.dart';
import 'package:school_app/form_controller.dart';
import 'package:school_app/widgets/custom_text_field';

enum FormMode { add, update, view }

class StudentForm extends StatefulWidget {
  const StudentForm({Key? key, required this.formMode}) : super(key: key);
  final FormMode formMode;

  @override
  State<StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  StudentFormController get controller => session.formcontroller;
  FormMode get formMode => widget.formMode;

  @override
  void initState() {
    if (formMode == FormMode.update) {
      controller.show =
          controller.image != null ? Provide.network : Provide.logo;
    }
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

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
    return GetBuilder(
        init: session,
        builder: (_) {
          return Scaffold(
              appBar: formMode == FormMode.update
                  ? null
                  : AppBar(
                      title: const Text('Student Form'),
                    ),
              body: Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            flex: 8,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Table(
                                    children: [
                                      TableRow(
                                        children: [
                                          CustomTextField(
                                              validator: requiredValidator,
                                              controller: controller.id,
                                              labelText: 'ID     '),
                                          CustomTextField(
                                              validator: requiredValidator,
                                              controller: controller.name,
                                              labelText: 'Name   '),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Table(
                                    children: [
                                      TableRow(
                                        children: [
                                          CustomTextField(
                                              validator: requiredValidator,
                                              controller:
                                                  controller.studentClass,
                                              labelText: "Class  "),
                                          CustomTextField(
                                              validator: requiredValidator,
                                              controller: controller.section,
                                              labelText: "Section"),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Table(
                                    children: [
                                      TableRow(
                                        children: [
                                          CustomTextField(
                                              validator: anyOneValidator,
                                              controller: controller.father,
                                              labelText: "Father "),
                                          CustomTextField(
                                              validator: anyOneValidator,
                                              controller: controller.mother,
                                              labelText: "Mother "),
                                          CustomTextField(
                                            validator: anyOneValidator,
                                            controller: controller.guardian,
                                            labelText: "Guardian",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  CustomTextField(
                                    validator: requiredValidator,
                                    controller: controller.contact,
                                    labelText: "Contact",
                                  ),
                                  CustomTextField(
                                    validator: requiredValidator,
                                    controller: controller.address,
                                    labelText: "Address",
                                  ),
                                  Table(
                                    children: [
                                      TableRow(
                                        children: [
                                          CustomTextField(
                                            controller:
                                                controller.carNumbers[0],
                                            labelText: "Car 1  ",
                                          ),
                                          CustomTextField(
                                            controller:
                                                controller.carNumbers[1],
                                            labelText: "Car 2  ",
                                          ),
                                          CustomTextField(
                                            controller:
                                                controller.carNumbers[2],
                                            labelText: "Car 3  ",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: formMode == FormMode.update
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.center,
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
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            width: double.maxFinite,
                            height: 40,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    var future = (formMode == FormMode.add)
                                        ? controller.createUser()
                                        : controller.updateUser();
                                    showFutureCustomDialog(
                                        context: context,
                                        future: future,
                                        onTapOk: () {
                                          Navigator.of(context).pop();
                                        });
                                  }
                                },
                                child: const Text("Submit"))),
                      )
                    ],
                  ),
                ),
              ));
        });
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.controller,
    this.size,
    required this.label,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final double? size;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getWidth(context) / (size ?? 4),
      child: ListTile(
        leading: Text(label),
        title: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: TextFormField(
            controller: controller,
            validator: validator,
          ),
        ),
      ),
    );
  }
}
