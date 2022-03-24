import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:school_app/constants/get_constants.dart';
import 'package:school_app/controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: Image.asset(
                'assets/background.png',
                fit: BoxFit.cover,
              )),
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints.expand(),
                child: Center(
                  child: SizedBox(
                    width: getWidth(context) / 4,
                    height: getHeight(context) / 2,
                    child: Card(
                      color: Colors.white,
                      elevation: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 50),
                                child: Icon(
                                  Icons.person_rounded,
                                  size: 50,
                                ),
                              ),
                              ListTile(
                                  title: const Text("Email"),
                                  subtitle: TextFormField(
                                      controller: emailController)),
                              ListTile(
                                title: const Text("Password"),
                                subtitle: TextFormField(
                                  controller: passwordController,
                                  obscureText: !showPassword,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          onPressed: () {},
                                          icon: showPassword
                                              ? const Icon(Icons.visibility)
                                              : const Icon(
                                                  Icons.visibility_off))),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: SizedBox(
                                  height: 50,
                                  width: double.maxFinite,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      auth.signInWithEmailAndPassword(
                                          emailController
                                              .text.removeAllWhitespace,
                                          passwordController.text);
                                    },
                                    child: const Text("LOG IN"),
                                  ),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: const Text("Forgot password ?"))
                            ]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
