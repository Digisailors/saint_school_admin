import 'package:flutter/material.dart';
import 'package:school_app/widgets/dashboard/class_list.dart';
import 'package:school_app/widgets/dashboard/preview.dart';
import 'package:school_app/widgets/dashboard/queued_student.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(child: ClassList()),
          const Expanded(child: QueueList()),
          const Expanded(child: Preview()),
        ],
      ),
    );
  }
}
