import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/constants/get_constants.dart';
import 'package:school_app/controllers/auth_controller.dart';
import 'package:school_app/controllers/session_controller.dart';
import 'package:school_app/models/biodata.dart';
import 'package:school_app/screens/carousel.dart';
import 'package:school_app/screens/dashboard.dart';
import 'package:school_app/screens/list/appointmentlist.dart';
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
            // backgroundColor: Colors.blue.shade50,
            child: ListView(
              children: [
                DrawerHeader(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.asset(
                      'assets/logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                DrawerListTile(
                  leading: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/3408/3408591.png',
                    height: getHeight(context) * 0.03,
                  ),
                  title: "Dashboard",
                  svgSrc: "assets/icons/menu_tran.svg",
                  selected: currentPage == 0,
                  press: () {
                    session.pageIndex = 0;
                    Get.offAllNamed(Dashboard.routeName);
                  },
                ),
                DrawerListTile(
                  leading: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/3829/3829933.png',
                    height: getHeight(context) * 0.03,
                  ),
                  title: "Student List",
                  svgSrc: "assets/icons/menu_tran.svg",
                  selected: currentPage == 1,
                  press: () {
                    session.pageIndex = 1;
                    Get.offAllNamed(EntityList.routeName, arguments: EntityType.student);
                  },
                ),
                DrawerListTile(
                  leading: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/780/780270.png',
                    height: getHeight(context) * 0.03,
                  ),
                  title: "Parent List",
                  svgSrc: "assets/icons/menu_tran.svg",
                  selected: currentPage == 2,
                  press: () {
                    session.pageIndex = 2;
                    Get.offAllNamed(EntityList.routeName, arguments: EntityType.parent);
                  },
                ),
                DrawerListTile(
                  leading: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/4696/4696727.png',
                    height: getHeight(context) * 0.03,
                  ),
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
                  leading: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/942/942759.png',
                    height: getHeight(context) * 0.03,
                  ),
                  title: "Appointments",
                  svgSrc: "assets/icons/menu_tran.svg",
                  selected: currentPage == 3,
                  press: () {
                    session.pageIndex = 3;
                    Get.offAll(const AppoinmentList());
                    // Get.offAll(() => const Carousel());
                  },
                ),
                DrawerListTile(
                  leading: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/1907/1907440.png',
                    height: getHeight(context) * 0.03,
                  ),
                  title: "Carousel",
                  svgSrc: "assets/icons/menu_tran.svg",
                  // selected: currentPage == 2,
                  press: () {
                    session.pageIndex = 9;
                    Get.to(() => const Carousel());
                  },
                ),
                DrawerListTile(
                  leading: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/1300/1300674.png',
                    height: getHeight(context) * 0.03,
                  ),
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
    this.leading,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;
  final bool selected;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selectedColor: Colors.yellowAccent.shade100,
      leading: SizedBox(width: getWidth(context) * 0.02, height: getHeight(context) * 0.03, child: leading),
      onTap: press,
      selected: selected,
      selectedTileColor: Colors.blueAccent.shade100,
      hoverColor: Colors.blue.shade100,
      horizontalTitleGap: 0.0,
      title: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
