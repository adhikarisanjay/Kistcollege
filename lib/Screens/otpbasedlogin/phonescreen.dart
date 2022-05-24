import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:kist/Screens/otpbasedlogin/otppage.dart';
import 'package:kist/Services/firebaseservices.dart';
import 'package:kist/bloc/loginbloc/login_bloc.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

class PhoneBasedAuth extends StatefulWidget {
  const PhoneBasedAuth({Key? key}) : super(key: key);

  @override
  State<PhoneBasedAuth> createState() => _PhoneBasedAuthState();
}

class _PhoneBasedAuthState extends State<PhoneBasedAuth> {
  TextEditingController _phoneController = TextEditingController();
  var buttonstate = ButtonState.idle;
  var phonenumber;
  var verificationId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Phone auth"),
      // ),
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IntlPhoneField(
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  initialCountryCode: 'NP',
                  onChanged: (phone) {
                    setState(() {
                      phonenumber = phone;
                    });
                    print(phone.completeNumber);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ProgressButton.icon(
                    iconedButtons: {
                      ButtonState.idle: IconedButton(
                          text: "Send",
                          icon: const Icon(Icons.send, color: Colors.white),
                          color: Colors.deepPurple.shade500),
                      ButtonState.loading: IconedButton(
                          text: "Loading", color: Colors.deepPurple.shade700),
                      ButtonState.fail: IconedButton(
                          text: "Failed",
                          icon: const Icon(Icons.cancel, color: Colors.white),
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
                      setState(() {
                        buttonstate = ButtonState.loading;
                      });
                      phoneauth(phonenumber);
                      // FirbaseServices().phoneauth(phonenumber);
                    },
                    state: buttonstate)

                // TextFormField(
                //   decoration: InputDecoration(
                //       enabledBorder: const OutlineInputBorder(
                //           borderRadius: BorderRadius.all(Radius.circular(8)),
                //           borderSide:
                //               BorderSide(color: Color.fromRGBO(238, 238, 238, 1))),
                //       focusedBorder: const OutlineInputBorder(
                //           borderRadius: BorderRadius.all(Radius.circular(8)),
                //           borderSide:
                //               BorderSide(color: Color.fromRGBO(224, 224, 224, 1))),
                //       filled: true,
                //       fillColor: Colors.grey[100],
                //       hintText: "Phone Number"),
                //   controller: _phoneController,
                // ),
              ],
            ),
          );
        },
      ),
    );
  }

  phoneauth(phone) async {
    print("phonenumber$phonenumber");
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
        timeout: const Duration(seconds: 15),
        verificationCompleted: (AuthCredential authCredential) {
          print("authCredential");
        },
        verificationFailed: (FirebaseAuthException authException) {
          print(authException);
          setState(() {
            buttonstate = ButtonState.fail;
          });
        },
        codeAutoRetrievalTimeout: (String verId) {},
        phoneNumber: '${phone.countryCode}' + '${phone.number}',
        codeSent: (String verificationId, int? forceResendingToken) {
          print("otpsend");
          // setState(() {
          buttonstate = ButtonState.success;
          // });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Otpscreen(
                        phonenumber: '${phone.countryCode}' + '${phone.number}',
                        verificationid: verificationId,
                      )));

          print(verificationId);
        });
  }
}
