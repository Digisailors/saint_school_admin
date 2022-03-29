import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/controllers/auth_controller.dart';
import 'package:school_app/controllers/session_controller.dart';
import 'package:school_app/screens/carousel.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  set index(int number) => session.pageIndex = number;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue.shade50,
      child: ListView(
        children: [
          DrawerHeader(
            child: CircleAvatar(
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // DrawerListTile(
          //   title: "Dashboard",
          //   svgSrc: "assets/icons/menu_dashbord.svg",
          //   selected: session.pageIndex == 0,
          //   press: () {
          //     setState(() {
          //       session.pageIndex = 0;
          //       session.controller.jumpToPage(0);
          //     });
          //   },
          //   // selected: index==0,
          // ),
          DrawerListTile(
            title: "Student List",
            svgSrc: "assets/icons/menu_tran.svg",
            selected: session.pageIndex == 0,
            press: () {
              setState(() {
                session.pageIndex = 0;
                session.selectedStudent = session.kids[0];
                session.controller.jumpToPage(0);
              });
            },
          ),
          DrawerListTile(
            title: "Add Student",
            svgSrc: "assets/icons/menu_tran.svg",
            selected: session.pageIndex == 1,
            press: () {
              setState(() {
                session.pageIndex = 1;
                session.selectedStudent = null;
                session.controller.jumpToPage(1);
              });
            },
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_tran.svg",
            selected: session.pageIndex == 2,
            press: () {
              setState(() {
                session.pageIndex = 2;

                session.controller.jumpToPage(2);
              });
            },
          ),
          DrawerListTile(
            title: "Carousel",
            svgSrc: "assets/icons/menu_tran.svg",
            // selected: session.pageIndex == 2,
            press: () {
              Get.to(() => const Carousel());
              // setState(() {
              //   session.pageIndex = 2;
              //   session.selectedStudent = null;
              //   session.controller.jumpToPage(2);
              // });
            },
          ),
          DrawerListTile(
            title: "Log out",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              auth.signOut();
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
    this.selected = false,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      selected: selected,
      selectedTileColor: Colors.blueAccent,
      hoverColor: Colors.blue.shade100,
      horizontalTitleGap: 0.0,
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
