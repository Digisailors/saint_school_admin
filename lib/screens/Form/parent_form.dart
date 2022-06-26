import 'package:flutter/material.dart';
import 'package:school_app/controllers/parent_controller.dart';
import 'package:school_app/models/parent.dart';
import 'package:school_app/screens/Form/controllers/parent_form_controller.dart';
import 'package:school_app/widgets/theme.dart';

import '../../constants/constant.dart';
import '../../constants/get_constants.dart';
import '../../models/biodata.dart';
import '../../models/response.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_text_field.dart';

class ParentForm extends StatefulWidget {
  const ParentForm({
    Key? key,
    this.parent,
  }) : super(key: key);

  final Parent? parent;
  static String routeName = '/parent';

  @override
  State<ParentForm> createState() => _ParentFormState();
}

enum FormMode { add, update, view }

class _ParentFormState extends State<ParentForm> {
  late FormMode formMode;
  late ParentFormController controller;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    formMode = widget.parent == null ? FormMode.add : FormMode.update;
    controller = widget.parent == null ? ParentFormController() : ParentFormController.fromParent(widget.parent!);
    super.initState();
  }

  String? requiredValidator(String? val) {
    var text = val ?? '';
    if (text.isEmpty) {
      return "This is a required field";
    }
    return null;
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
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back),
                ),
                title: Text(
                  'Parent Form',
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
                      child: CustomTextField(
                        validator: requiredValidator,
                        controller: controller.icNumber,
                        labelText: 'IC Number',
                        hintText: 'Enter IC Number',
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
                  'Children',
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
                          var parent = controller.parent;
                          var parentController = ParentController(parent: parent);
                          Future<Result> future;
                          if (formMode == FormMode.add) {
                            future = parentController.add();
                          } else {
                            future = parentController.change();
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
    List<Widget> list = controller.children
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
                controller.children.add(TextEditingController());
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

