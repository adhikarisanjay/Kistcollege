import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:kist/Services/Apiconnectservices.dart';
import 'package:kist/Services/firebaseservices.dart';
import 'package:kist/bloc/bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FirbaseServices().phoneauth();
  }

  final _emailcontroller = TextEditingController();

  final _passController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  //Place A
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(32),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginInprocess) {}
          if (state is LoginSuccess) {
            print(state.logindata.firstName);
            snackbar("success");
          }

          if (state is LoginError) {}
        },
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Login",
                style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 36,
                    fontWeight: FontWeight.w500),
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
                    hintText: "Email Number"),
                controller: _emailcontroller,
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                obscureText: true,
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
                    hintText: "Password"),
                controller: _passController,
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                child: FlatButton(
                  child: Text("Login"),
                  textColor: Colors.white,
                  padding: EdgeInsets.all(16),
                  onPressed: () {
                    print("login pressed");
                    if (_formkey.currentState!.validate()) {
                      BlocProvider.of<LoginBloc>(context).add(
                          LoginButtonPressed(
                              email: _emailcontroller.text,
                              password: _passController.text));
                    }
                  },
                  color: Colors.blue,
                ),
              )
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
