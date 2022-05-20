import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kist/component/buttonnavbar.dart';
import 'package:kist/component/buttonnavbarnotch.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

class Otpscreen extends StatefulWidget {
  final dynamic verificationid;
  final dynamic phonenumber;
  const Otpscreen({Key? key, this.phonenumber, this.verificationid})
      : super(key: key);

  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
  var textEditingController = TextEditingController();
  var buttonstate = ButtonState.idle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("Enter Your Otp"),
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: PinCodeTextField(
            length: 6,
            obscureText: false,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              inactiveFillColor: Colors.grey,
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              // errorBorderColor: Colors.green,
              fieldHeight: 50,
              fieldWidth: 40,
              inactiveColor: Colors.grey,
              activeFillColor: Colors.white,
            ),
            animationDuration: Duration(milliseconds: 300),
            // backgroundColor: Colors.grey,
            enableActiveFill: true,
            // errorAnimationController: errorController,
            controller: textEditingController,
            onCompleted: (v) {
              print("Completed");
            },
            onChanged: (value) {
              print(value);
              setState(() {
                // currentText = value;
              });
            },
            beforeTextPaste: (text) {
              print("Allowing to paste $text");
              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
              //but you can show anything you want here, like your pop up saying wrong paste format or etc
              return true;
            },
            appContext: context,
          ),
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
              signIn();
              // FirbaseServices().phoneauth(phonenumber);
            },
            state: buttonstate)
      ]),
    );
  }

  Future<void> signIn() async {
    print(textEditingController.text);
    await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
          verificationId: widget.verificationid,
          smsCode: textEditingController.text,
        ))
        .then((value) => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ButtomNavBar1()))
            });
  }
}
