import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/class_controller.dart';

class ClassList extends StatelessWidget {
  const ClassList({Key? key}) : super(key: key);

  final TextEditingValue classname = const TextEditingValue();
  final TextEditingValue sectionName = const TextEditingValue();

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
                      ListTile(
                          title: const Text("Section"),
                          subtitle: TextFormField(
                            controller: classController.section,
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              classController.add();
                            },
                            child: const Text("Add")),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  child: ListView.builder(
                    itemCount: classController.sections.length,
                    itemBuilder: (context, index) {
                      var section = classController.sections[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: Text(section["name"]),
                          title: Text(section["section"]),
                        ),
                      );
                    },
                  ),
                ),
              )
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