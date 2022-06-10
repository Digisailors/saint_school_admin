import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key, required this.child}) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Expanded(flex: 1, child: SideMenu()),
          Expanded(flex: 5, child: child),
        ],
      ),
    );
  }
}
