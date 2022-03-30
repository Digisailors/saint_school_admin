import 'package:flutter/material.dart';

class QueueList extends StatelessWidget {
  const QueueList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Queue"),
          centerTitle: true,
        ),
        body: const Center(
          child: Text("Under Development"),
        ),
      ),
    );
  }
}
