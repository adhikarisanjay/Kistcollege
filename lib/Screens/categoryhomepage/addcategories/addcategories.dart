import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:kist/Services/Apiconnectservices.dart';
import 'package:kist/Services/firebaseservices.dart';
import 'package:kist/bloc/loginbloc/login_bloc.dart';
import 'package:kist/component/buttonnavbarnotch.dart';
import 'package:kist/cubit/logincubit/logincubit_cubit.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

class CategoryAdd extends StatefulWidget {
  @override
  State<CategoryAdd> createState() => _CategoryAddState();
}

class _CategoryAddState extends State<CategoryAdd> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FirbaseServices().phoneauth();
  }

  final _title = TextEditingController();

  final _description = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  var buttonstate = ButtonState.idle;
  //Place A
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("CategoryAdd"),
        ),
        body: Container(
          padding: EdgeInsets.all(32),
          child: BlocListener<LogincubitCubit, LogincubitState>(
            listener: (context, state) {
              if (state is LogincubitButtonpressed) {
                setState(() {
                  buttonstate = ButtonState.loading;
                });
              }
              if (state is LogincubitSuccess) {
                snackbar("success");
                setState(() {
                  buttonstate = ButtonState.success;
                });
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => ButtomNavBar1()),
                    (route) => false);
              }
              if (state is LogincubitError) {
                setState(() {
                  buttonstate = ButtonState.fail;
                });
              }
              // if (state is LoginInprocess) {}
              // if (state is LoginSuccess) {
              //   print(state.logindata.firstName);
              //   snackbar("success");
              // }

              // if (state is LoginError) {}
            },
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: Image.asset("assets/images.jpeg"),
                    ),
                  ),

                  // IntlPhoneField(
                  //   decoration: InputDecoration(
                  //     labelText: 'Phone Number',
                  //     border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.all(Radius.circular(20))),
                  //   ),
                  //   initialCountryCode: 'IN',
                  //   onChanged: (phone) {
                  //     print(phone.completeNumber);
                  //   },
                  // ),
                  // const SizedBox(
                  //   height: 16,
                  // ),
                  TextFormField(
                    validator: (value) {
                      if (EmailValidator.validate(value!)) {
                        return null;
                      } else {
                        return "Please enter a valid email";
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(238, 238, 238, 1))),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(224, 224, 224, 1))),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: "Title"),
                    controller: _title,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    // obscureText: true,
                    maxLines: 5,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(238, 238, 238, 1))),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(224, 224, 224, 1))),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: "Description"),
                    controller: _description,
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  ProgressButton.icon(
                      iconedButtons: {
                        ButtonState.idle: IconedButton(
                            text: "Send",
                            icon: Icon(Icons.send, color: Colors.white),
                            color: Colors.deepPurple.shade500),
                        ButtonState.loading: IconedButton(
                            text: "Loading", color: Colors.deepPurple.shade700),
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
                          // BlocProvider.of<LoginBloc>(context).add(
                          //     LoginButtonPressed(
                          //         email: _emailcontroller.text,
                          //         password: _passController.text));
                          // BlocProvider.of<LogincubitCubit>(context)
                          //     .loginapicall(
                          //         _emailcontroller.text, _passController.text);
                        }
                        print("state");
                      },
                      state: buttonstate),
                  // Container(
                  //   width: double.infinity,
                  //   child: FlatButton(
                  //     child: Text("Login"),
                  //     textColor: Colors.white,
                  //     padding: EdgeInsets.all(16),
                  //     onPressed: () {
                  //       print("login pressed");
                  //       if (_formkey.currentState!.validate()) {
                  //         // BlocProvider.of<LoginBloc>(context).add(
                  //         //     LoginButtonPressed(
                  //         //         email: _emailcontroller.text,
                  //         //         password: _passController.text));
                  //         BlocProvider.of<LogincubitCubit>(context).loginapicall(
                  //             _emailcontroller.text, _passController.text);
                  //       }
                  //     },
                  //     color: Colors.blue,
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ));
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
