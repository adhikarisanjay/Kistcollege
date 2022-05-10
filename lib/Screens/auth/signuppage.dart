import 'package:flutter/material.dart';
import 'package:kist/Services/firebaseservices.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formkey = GlobalKey<FormState>();
  var name = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  var address = TextEditingController();

  bool obscureTextstatus = true;
  var buttonstate = ButtonState.idle;

  @override
  void initState() {
    // TODO: implement initState
    FirbaseServices().update();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register page")),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                          hintText: "Enter Your Email",
                          prefixIcon: Icon(Icons.email)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This field is required";
                        }
                      },

                      // The validator receives the text that the user has entered.
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: name,
                      decoration: InputDecoration(
                          hintText: "Enter Your Password",
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  obscureTextstatus == false
                                      ? obscureTextstatus = true
                                      : obscureTextstatus = false;
                                });
                              },
                              child: obscureTextstatus == true
                                  ? Icon(Icons.lock)
                                  : Icon(Icons.lock_open))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This field is required";
                        }
                      },

                      // The validator receives the text that the user has entered.
                    ),
                    TextFormField(
                      controller: name,
                      decoration: InputDecoration(
                          hintText: "Enter Your Password",
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  obscureTextstatus == false
                                      ? obscureTextstatus = true
                                      : obscureTextstatus = false;
                                });
                              },
                              child: obscureTextstatus == true
                                  ? Icon(Icons.lock)
                                  : Icon(Icons.lock_open))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This field is required";
                        }
                      },

                      // The validator receives the text that the user has entered.
                    ),
                    TextFormField(
                      controller: name,
                      decoration: InputDecoration(
                          hintText: "Enter Your Password",
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  obscureTextstatus == false
                                      ? obscureTextstatus = true
                                      : obscureTextstatus = false;
                                });
                              },
                              child: obscureTextstatus == true
                                  ? Icon(Icons.lock)
                                  : Icon(Icons.lock_open))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This field is required";
                        }
                      },

                      // The validator receives the text that the user has entered.
                    ),
                    TextFormField(
                      controller: name,
                      decoration: InputDecoration(
                          hintText: "Enter Your Password",
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  obscureTextstatus == false
                                      ? obscureTextstatus = true
                                      : obscureTextstatus = false;
                                });
                              },
                              child: obscureTextstatus == true
                                  ? Icon(Icons.lock)
                                  : Icon(Icons.lock_open))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This field is required";
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ProgressButton.icon(
                        iconedButtons: {
                          ButtonState.idle: IconedButton(
                              text: "Send",
                              icon: Icon(Icons.send, color: Colors.white),
                              color: Colors.deepPurple.shade500),
                          ButtonState.loading: IconedButton(
                              text: "Loading",
                              color: Colors.deepPurple.shade700),
                          ButtonState.fail: IconedButton(
                              text: "Failed",
                              icon: Icon(Icons.cancel, color: Colors.white),
                              color: Colors.red.shade300),
                          ButtonState.success: IconedButton(
                              text: "Success",
                              icon: const Icon(
                                Icons.check_circle,
                                color: Colors.white,
                              ),
                              color: Colors.green.shade400)
                        },
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              buttonstate = ButtonState.loading;
                            });
                            FirbaseServices()
                                .signUp(email.text, name.text)
                                .then((value) => {
                                      if (value == true)
                                        {
                                          setState(() {
                                            buttonstate = ButtonState.success;
                                          })
                                        }
                                      else
                                        {
                                          setState(() {
                                            buttonstate = ButtonState.fail;
                                          })
                                        }
                                    });
                          }
                          print("state");
                        },
                        state: buttonstate)
                  ],
                ))
          ],
        ),
      ),
    );
  }
}