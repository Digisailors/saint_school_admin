import 'package:flutter/material.dart';
import 'package:school_app/constants/get_constants.dart';
import '../widgets/sidebar.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          isDesktop(context)
              ? Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 4.0, right: 4.0, bottom: 4.0, top: 4.0),
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        elevation: 10,
                        child: const SideMenu()),
                  ),
                )
              : Container(),
          Expanded(
              flex: 5,
              child: Scaffold(
                appBar: AppBar(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  actions: [
                    IconButton(
                      iconSize: getWidth(context)*0.03,
                        onPressed: () {},
                        icon: Image.network(
                          'https://cdn-icons-png.flaticon.com/512/7650/7650798.png',

                        )),
                    IconButton(
                        iconSize: getWidth(context)*0.03,
                        onPressed: () {},
                        icon: Image.network(
                          'https://cdn-icons-png.flaticon.com/512/7650/7650798.png',

                        )),
                    IconButton(
                        iconSize: getWidth(context)*0.03,
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
      ),
    );
  }
}
