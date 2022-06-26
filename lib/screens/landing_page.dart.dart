import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:school_app/constants/get_constants.dart';
import 'package:school_app/controllers/session_controller.dart';
import '../widgets/sidebar.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
          init: session,
          builder: (_) {
            return Row(
              children: [
                (isDesktop(context) && session.showSideBar)
                    ? const Expanded(
                        flex: 1,
                        child: Card(elevation: 10, child: SideMenu()),
                      )
                    : Container(),
                Expanded(
                    flex: 5,
                    child: Scaffold(
                      appBar: session.pageIndex == 9
                          ? null
                          : AppBar(
                              actions: [
                                IconButton(
                                    iconSize: getWidth(context) * 0.03,
                                    onPressed: () {},
                                    icon: Image.network(
                                      'https://cdn-icons-png.flaticon.com/512/7650/7650798.png',
                                    )),
                                IconButton(
                                    iconSize: getWidth(context) * 0.03,
                                    onPressed: () {},
                                    icon: Image.network(
                                      'https://cdn-icons-png.flaticon.com/512/7650/7650798.png',
                                    )),
                                IconButton(
                                    iconSize: getWidth(context) * 0.03,
                                    onPressed: () {},
                                    icon: Image.network(
                                      'https://cdn-icons-png.flaticon.com/512/7650/7650798.png',
                                    )),
                              ],
                            ),
                      drawer: isDesktop(context) ? null : const SideMenu(),
                      body: child,
                    )),
              ],
            );
          }),
    );
  }
}
