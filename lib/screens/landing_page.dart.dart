import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:school_app/constants/get_constants.dart';
import 'package:school_app/controllers/auth_controller.dart';
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
            if (auth.currentUser?.email != 'rampowiz@gmail.com' && auth.currentUser?.email != 'admin@saintschool.com') {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("The credentials you have entered does not hold admin priviliges."),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          auth.signOut();
                        },
                        child: const Text("Logout"),
                      ),
                    ),
                  ],
                ),
              );
            }
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
                      appBar: AppBar(
                        title: const Text("SAINT SCHOOL"),
                        centerTitle: true,
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
