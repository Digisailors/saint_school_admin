import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/controllers/queue_controller.dart';
import 'package:school_app/controllers/session_controller.dart';
import 'package:school_app/widgets/student_tile.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  @override
  void dispose() {
    queueController.queuedStudentsList.clear();
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
      appBar: AppBar(
        toolbarHeight: 30,
        automaticallyImplyLeading: false,
        leading: Center(
          child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                session.pageIndex = 0;
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 10,
              )),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,

      body: GetBuilder(
        init: queueController,
        builder: (_) {
          return GridView.count(
            crossAxisCount: 4,
            childAspectRatio: 3,
            children: queueController.queuedStudentsList
                .map((e) => StudentTile(student: e.student, string: queueController.countDown[e.icNumber] ?? ''))
                .toList(),
          );
          // return Wrap(
          //     children: queueController.queuedStudentsList
          //         .map((e) => Expanded(child: StudentTile(student: e, string: queueController.countDown[e.ic] ?? '')))
          //         .toList());
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
