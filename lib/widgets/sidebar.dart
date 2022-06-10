import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/constants/get_constants.dart';
import 'package:school_app/controllers/auth_controller.dart';
import 'package:school_app/controllers/session_controller.dart';
import 'package:school_app/screens/carousel.dart';
import 'package:school_app/widgets/theme.dart';

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
      elevation: 10,
      backgroundColor: getColor(context).onInverseSurface,

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
            src: 'https://cdn-icons-png.flaticon.com/512/3135/3135755.png',
            title: "Student List",
            svgSrc: "assets/icons/menu_tran.svg",
            selected: session.pageIndex == 0,
            press: () {
              setState(() {
                session.pageIndex = 0;
                session.selectedStudent = session.kids.isEmpty ? null : session.kids[0];
                session.controller.jumpToPage(0);

              });
              if(MediaQuery.of(context).size.width >= 1100!=true){

                Navigator.pop(context);
              }

            },
          ),
          DrawerListTile(
            src: 'https://cdn-icons-png.flaticon.com/512/3135/3135755.png',
            title: "Add Student",
            svgSrc: "assets/icons/menu_tran.svg",
            selected: session.pageIndex == 1,
            press: () {
              setState(() {
                session.pageIndex = 1;
                session.selectedStudent = null;
                session.controller.jumpToPage(1);
              });
              if(MediaQuery.of(context).size.width >= 1100!=true){

                Navigator.pop(context);
              }
            },
          ),
          DrawerListTile(
            src: 'https://cdn-icons-png.flaticon.com/512/3135/3135755.png',
            title: "Dashboard",
            svgSrc: "assets/icons/menu_tran.svg",
            selected: session.pageIndex == 2,
            press: () {
              setState(() {
                session.pageIndex = 2;

                session.controller.jumpToPage(2);
              });
              if(MediaQuery.of(context).size.width >= 1100!=true){

                Navigator.pop(context);
              }
            },
          ),
          DrawerListTile(
            src: 'https://cdn-icons-png.flaticon.com/512/3135/3135755.png',

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
            src: 'https://cdn-icons-png.flaticon.com/512/3135/3135755.png',
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
    this.selected = false, required this.src,
  }) : super(key: key);

  final String title, svgSrc;
  final String src ;
  final VoidCallback press;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(src)),
        onTap: press,
        selected: selected,
        selectedTileColor: Colors.blueAccent,
        hoverColor: Colors.blue.shade100,
        horizontalTitleGap: 0.0,
        title: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Text(
            title,
            style: getText(context).button,
          ),
        ),
      ),
    );
  }
}
