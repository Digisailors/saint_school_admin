import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/controllers/session_controller.dart';
import 'package:school_app/screens/id.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  @override
  void initState() {
    session.listenQueue();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
          init: session,
          builder: (context) {
            if (session.queuedStudents.isEmpty) {
              return const Center(
                child: Text("Empty Queue"),
              );
            } else {
              return Row(children: session.queuedStudents.map((e) => Expanded(child: Idcard(student: e))).toList());
            }
          }),
    );
  }
}
