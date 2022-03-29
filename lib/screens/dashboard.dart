import 'package:flutter/material.dart';
import 'package:school_app/widgets/class_list.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Expanded(child: ClassList()),
          Expanded(child: Container(color: Colors.white)),
          Expanded(child: Container(color: Colors.red)),
        ],
      ),
    );
  }
}
