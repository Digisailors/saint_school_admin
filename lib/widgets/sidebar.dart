import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/controllers/auth_controller.dart';
import 'package:school_app/controllers/session_controller.dart';
import 'package:school_app/models/biodata.dart';
import 'package:school_app/screens/carousel.dart';
import 'package:school_app/screens/dashboard.dart';
import 'package:school_app/screens/list/list.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  set index(int number) => session.pageIndex = number;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: session,
        builder: (_) {
          final currentPage = session.pageIndex;
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
                DrawerListTile(
                  title: "Dashboard",
                  svgSrc: "assets/icons/menu_tran.svg",
                  selected: currentPage == 0,
                  press: () {
                    session.pageIndex = 0;
                    Get.offAllNamed(Dashboard.routeName);
                  },
                ),
                DrawerListTile(
                  title: "Student List",
                  svgSrc: "assets/icons/menu_tran.svg",
                  selected: currentPage == 1,
                  press: () {
                    session.pageIndex = 1;
                    Get.offAllNamed(EntityList.routeName, arguments: EntityType.student);
                  },
                ),
                DrawerListTile(
                  title: "Parent List",
                  svgSrc: "assets/icons/menu_tran.svg",
                  selected: currentPage == 2,
                  press: () {
                    session.pageIndex = 2;
                    Get.offAllNamed(EntityList.routeName, arguments: EntityType.parent);
                  },
                ),
                DrawerListTile(
                  title: "Teacher List",
                  svgSrc: "assets/icons/menu_tran.svg",
                  // selected: currentPage == 2,
                  press: () {
                    session.pageIndex = 3;
                    Get.offAllNamed(EntityList.routeName, arguments: EntityType.teacher);
                    // Get.offAll(() => const Carousel());
                  },
                ),
                DrawerListTile(
                  title: "Carousel",
                  svgSrc: "assets/icons/menu_tran.svg",
                  // selected: currentPage == 2,
                  press: () {
                    session.pageIndex = 9;
                    Get.to(() => const Carousel());
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
        });
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
