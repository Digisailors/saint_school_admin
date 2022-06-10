// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:school_app/constants/constant.dart';
// import 'package:school_app/controllers/session_controller.dart';
// import 'package:school_app/screens/student_form.dart';
//
// class StudentList extends StatefulWidget {
//   StudentList({Key? key}) : super(key: key);
//
//   @override
//   State<StudentList> createState() => _StudentListState();
// }
//
// class _StudentListState extends State<StudentList> {
//   @override
//   void initState() {
//     session.loadStudents();
//
//     // session.selectedStudent = session.kids[]
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: GetBuilder(
//           init: session,
//           builder: (_) {
//             return Row(
//               children: [
//                 Expanded(
//                   flex: 2,
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Card(
//                           child: ListTile(
//                             trailing: IconButton(
//                                 onPressed: () {
//                                   session.loadStudents();
//                                 },
//                                 icon: const Icon(Icons.search)),
//                             title: TextFormField(
//                               controller: session.searchController,
//                               onChanged: (text) {
//                                 if (text.isEmpty) {
//                                   session.loadStudents();
//                                 }
//                               },
//                               decoration: const InputDecoration(border: InputBorder.none),
//                             ),
//                             leading: DropdownButtonHideUnderline(
//                               child: DropdownButton<String?>(
//                                   icon: const Icon(Icons.sort_sharp),
//                                   items: session.getOrderByItems(),
//                                   hint: const Icon(Icons.sort),
//                                   value: session.sortBy,
//                                   onChanged: (text) {
//                                     session.sortBy = text ?? session.sortBy;
//                                     session.sortLocal();
//                                   }),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: session.kids.isEmpty
//                             ? const Center(
//                                 child: Text("There are no students in the list"),
//                               )
//                             : ListView.builder(
//                                 itemCount: session.kids.length,
//                                 itemBuilder: (context, index) {
//                                   return ListTile(
//                                     horizontalTitleGap: 32,
//                                     leading: CircleAvatar(backgroundImage: NetworkImage(session.kids[index].image ?? '')),
//                                     title: Text(session.kids[index].id),
//                                     subtitle: Text(session.kids[index].name),
//                                     selected: session.selectedIndex == index,
//                                     selectedColor: Colors.white,
//                                     trailing: IconButton(
//                                         onPressed: () {
//                                           try {
//                                             var future = session.kids[index].delete();
//                                             showFutureCustomDialog(
//                                                 context: context,
//                                                 future: future,
//                                                 onTapOk: () {
//                                                   session.kids.removeAt(index);
//                                                   session.selectedIndex = 0;
//                                                   session.selectedStudent = session.kids.isNotEmpty ? session.kids.first : null;
//                                                   session.update();
//                                                   Navigator.of(context).pop();
//                                                 });
//                                           } catch (err) {
//                                             showDialog(
//                                                 context: context,
//                                                 builder: (context) {
//                                                   return AlertDialog(
//                                                     title: const Text("Error Occured", style: TextStyle(color: Colors.black)),
//                                                     content: Text(err.toString()),
//                                                   );
//                                                 });
//                                           }
//                                         },
//                                         icon: const Icon(Icons.delete)),
//                                     onTap: () {
//                                       session.selectedIndex = index;
//
//                                       session.selectedStudent = session.kids[session.selectedIndex];
//
//                                       session.update();
//                                     },
//                                     hoverColor: Colors.blue.shade100,
//                                     selectedTileColor: Colors.blueAccent,
//                                   );
//                                 }),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Expanded(
//                   flex: 5,
//                   // child: Idcard(student: session.student!),
//                   child: StudentForm(formMode: FormMode.update),
//                 ),
//               ],
//             );
//           }),
//     );
//   }
// }
//
// class StudentListTile extends StatelessWidget {
//   const StudentListTile({
//     Key? key,
//     // For selecting those three line once press "Command+D"
//     required this.title,
//     required this.svgSrc,
//     required this.press,
//     this.selected = false,
//   }) : super(key: key);
//
//   final String title, svgSrc;
//   final VoidCallback press;
//   final bool selected;
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: press,
//       selected: selected,
//       selectedTileColor: Colors.blueAccent,
//       hoverColor: Colors.blue.shade100,
//       horizontalTitleGap: 0.0,
//       title: Text(
//         title,
//         style: const TextStyle(color: Colors.black),
//       ),
//     );
//   }
// }
