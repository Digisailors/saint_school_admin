// ignore_for_file: file_names

import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_app/constants/get_constants.dart';
import 'package:school_app/models/student.dart';

class Idcard extends StatelessWidget {
  const Idcard({Key? key, required this.student}) : super(key: key);

  final Student student;

  getCarTiles() {
    List<Widget> tiles = [];
    for (var element in student.carNumbers) {
      if (element.isNotEmpty) {
        tiles.add(ListTile(
          leading: const Icon(CupertinoIcons.car_detailed, color: Colors.black),
          title: Text(element, style: const TextStyle(fontSize: 25)),
        ));
      }
    }
    return tiles;
  }

  getParentTiles() {
    List<TableRow> tiles = [];
    if ((student.father ?? '').isNotEmpty) {
      tiles.add(TableRow(children: [
        const TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text("Father", style: TextStyle(fontSize: 25))),
        Text(student.mother!, style: const TextStyle(fontSize: 40)),
      ]));
    }
    if ((student.mother ?? '').isNotEmpty) {
      tiles.add(TableRow(children: [
        const TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text("Mother", style: TextStyle(fontSize: 25))),
        Text(student.mother!, style: const TextStyle(fontSize: 40)),
      ]));
    }
    if ((student.guardian ?? '').isNotEmpty) {
      tiles.add(TableRow(children: [
        const TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text("Guardian", style: TextStyle(fontSize: 25))),
        Text(student.guardian!, style: const TextStyle(fontSize: 40)),
      ]));
    }
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.width,
            color: Colors.grey.shade200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: getWidth(context) / 8,
                    backgroundImage: NetworkImage(student.image ?? ''),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Text(
                  student.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 50),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Class : ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      student.studentClass,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 20),
                    ),
                    Text(
                      student.section ?? '',
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 20),
                    ),
                  ],
                ),
                const Divider(),
                Table(children: [TableRow(children: getCarTiles())]),
                const Divider(),
                Table(
                  textBaseline: TextBaseline.alphabetic,
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(5)
                  },
                  children: getParentTiles(),
                )
              ],
            )),
      ),
    ));
  }
}
