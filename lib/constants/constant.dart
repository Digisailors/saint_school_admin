import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../models/response.dart';

final FirebaseStorage storage = FirebaseStorage.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference<Map<String, dynamic>> students =
    firestore.collection('Students');

Future<String> uploadImage(Uint8List file, String name) async {
  var ref = storage
      .ref(name)
      .child(name + DateTime.now().microsecondsSinceEpoch.toString());
  var url = ref.putData(file).then((p0) => p0.ref.getDownloadURL());
  return url;
}

showFutureCustomDialog(
    {required BuildContext context,
    required Future<dynamic> future,
    required void Function()? onTapOk}) {
  showDialog(
      context: context,
      builder: (context) {
        return FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.done) {
                var response = snapshot.data as Response;
                if (response.code == "success") {
                  Navigator.of(context).pop();
                }
                return AlertDialog(
                  title: Text(response.code),
                  content: Text(response.message),
                  actions: [
                    ElevatedButton(
                        onPressed: response.code == "Error"
                            ? () {
                                Navigator.of(context).pop();
                              }
                            : onTapOk,
                        child: const Text("Okay"))
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            });
      });
}
