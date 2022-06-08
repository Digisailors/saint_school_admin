import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/controllers/queue_controller.dart';
import 'package:school_app/screens/id.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  @override
  void dispose() {
    queueController.queuedStudents.clear();
    super.dispose();
  }

  @override
  void initState() {
    Get.put((QueueController()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Back"),
          ),
        ),
      ),
      body: GetBuilder(
        init: queueController,
        builder: (_) {
          return Row(
              children: queueController.queuedStudents
                  .map((e) => Expanded(
                          child: Idcard(
                        student: e,
                        string: queueController.countDown[e.id] ?? '',
                      )))
                  .toList());
        },
      ),
      // body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      //   stream: queue.orderBy("queuedTime").limit(3).snapshots(),
      //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
      //     if (snapshot.connectionState == ConnectionState.active || snapshot.hasData) {
      //       List<Student> studentList = snapshot.data?.docs.map((e) => Student.fromJson(e.data())).toList() ?? [];
      //       return Row(children: studentList.map((e) => Expanded(child: Idcard(student: e))).toList());
      //     }
      //     if (snapshot.hasError) {
      //       return Center(child: Text(snapshot.error.toString()));
      //     }
      //     return const Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // ),
    );
  }
}
