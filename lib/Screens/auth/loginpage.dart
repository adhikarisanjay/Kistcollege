import 'package:flutter/material.dart';
import 'package:kist/Screens/auth/signuppage.dart';
import 'package:kist/Services/firebaseservices.dart';
import 'package:kist/component/buttonnavbarnotch.dart';
import 'package:kist/component/colors.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
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
      appBar: AppBar(title: Text("Login page")),
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
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
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
                      controller: password,
                      obscureText: obscureTextstatus,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintStyle: TextStyle(fontSize: 10),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[300]!)),
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
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        const Text("Don't have an Account?  "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()));
                          },
                          child: Text(
                            "SignUp",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: primary),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ProgressButton.icon(
                        iconedButtons: {
                          ButtonState.idle: IconedButton(
                              text: "Send",
                              icon: const Icon(Icons.send, color: Colors.white),
                              color: Colors.deepPurple.shade500),
                          ButtonState.loading: IconedButton(
                              text: "Loading",
                              color: Colors.deepPurple.shade700),
                          ButtonState.fail: IconedButton(
                              text: "Failed",
                              icon:
                                  const Icon(Icons.cancel, color: Colors.white),
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
                                .Login(email.text, password.text)
                                .then((value) => {
                                      print("loginresponse$value"),
                                      if (value == true)
                                        {
                                          setState(() {
                                            buttonstate = ButtonState.success;
                                          }),
                                          setloginstatus(),
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ButtomNavBar1()),
                                                  (route) => false),
                                        }
                                      else
                                        {
                                          snackbar("Loginfailed"),
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

  setloginstatus() async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool("loginstatus", true);
  }

  snackbar(message) {
    final snackBar = SnackBar(
      content: Text('$message'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
