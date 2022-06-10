import 'package:flutter/material.dart';
import 'package:school_app/constants/get_constants.dart';
import 'package:school_app/widgets/custom_text_field.dart';
import 'package:school_app/widgets/responsivewidget.dart';

import '../controllers/session_controller.dart';
import '../form_controller.dart';
import '../widgets/custom_drop_down.dart';
import '../widgets/theme.dart';

class StudentForm extends StatefulWidget {
  const StudentForm({Key? key}) : super(key: key);

  @override
  State<StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  StudentFormController get controller => session.formcontroller;

  final _formKey = GlobalKey<FormState>();
//
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

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
                    validator: requiredValidator,
                    controller: controller.name,
                    labelText: 'Name   ',
                  ),
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
              children: [
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
            child: CustomLayout(children: [
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
                  labelText: "Address",
                ),
              ),
            ]),
          ),
          Center(
            child: CustomLayout(children: [
              SizedBox(
                width: isMobile(context)
                    ? getWidth(context) * 0.80
                    : getWidth(context) * 0.20,
                child: CustomTextField(
                  controller: controller.carNumbers[0],
                  labelText: "Vehicle 1  ",
                ),
              ),
              SizedBox(
                width: isMobile(context)
                    ? getWidth(context) * 0.80
                    : getWidth(context) * 0.20,
                child: CustomTextField(
                  controller: controller.carNumbers[1],
                  labelText: "Vehicle 2  ",
                ),
              ),
              SizedBox(
                width: isMobile(context)
                    ? getWidth(context) * 0.80
                    : getWidth(context) * 0.20,
                child: CustomTextField(
                  controller: controller.carNumbers[2],
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
