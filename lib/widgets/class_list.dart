import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:school_app/constants/constant.dart';
import 'package:school_app/widgets/custom_drop_down.dart';

import '../controllers/class_controller.dart';

class ClassList extends StatelessWidget {
  ClassList({Key? key}) : super(key: key);

  final TextEditingValue classname = const TextEditingValue();
  final TextEditingValue sectionName = const TextEditingValue();

  String? classField;

  List<DropdownMenuItem<String>> getClassItems() {
    return classController.classes.keys
        .map((e) => DropdownMenuItem(
              child: Text(e),
              value: e.toString(),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: classController,
        builder: (_) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                          title: const Text("Name"),
                          subtitle: TextFormField(
                            controller: classController.name,
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              var future = classController.addClass();
                              showFutureCustomDialog(
                                  context: context,
                                  future: future,
                                  onTapOk: () {
                                    classController.name.clear();
                                    Navigator.of(context).pop();
                                  });
                            },
                            child: const Text("Add")),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                          title: const Text("Name"),
                          subtitle: DropdownButtonFormField<String?>(
                            items: getClassItems(),
                            value: classField,
                            onChanged: (text) {
                              classField = text;
                            },
                          )),
                      ListTile(
                          title: const Text("Section"),
                          subtitle: TextFormField(
                            controller: classController.section,
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              var future = classController.addSection(classField!, classController.section.text.removeAllWhitespace);
                              showFutureCustomDialog(
                                  context: context,
                                  future: future,
                                  onTapOk: () {
                                    Navigator.of(context).pop();
                                  });
                            },
                            child: const Text("Add")),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}


  // LayoutBuilder(builder: (context, constraints) {
                      //   return ListTile(
                      //       title: const Text("Name"),
                      //       subtitle: Autocomplete(
                      //         initialValue: classname,
                      //         optionsViewBuilder: (context, onSelected,
                      //                 Iterable<String> options) =>
                      //             Align(
                      //           alignment: Alignment.topLeft,
                      //           child: Material(
                      //             shape: const RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.vertical(
                      //                   bottom: Radius.circular(4.0)),
                      //             ),
                      //             child: SizedBox(
                      //               height: 52.0 * options.length,
                      //               width: constraints.biggest.width -
                      //                   30, // <-- Right here !
                      //               child: ListView.builder(
                      //                 padding: EdgeInsets.zero,
                      //                 itemCount: options.length,
                      //                 shrinkWrap: false,
                      //                 itemBuilder:
                      //                     (BuildContext context, int index) {
                      //                   final String option =
                      //                       options.elementAt(index);
                      //                   return ListTile(
                      //                     onTap: () => onSelected,
                      //                     title: Text(option),
                      //                   );
                      //                 },
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //         optionsBuilder: (value) {
                      //           return classController.classes.keys;
                      //         },
                      //       ));
                      // }),