import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(child: Container(color: Colors.black)),
          Expanded(child: Container(color: Colors.white)),
          Expanded(child: Container(color: Colors.red)),
        ],
      ),
    );
  }
}
