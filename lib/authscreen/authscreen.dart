import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kist/Screens/phoneauth.dart';
import 'package:kist/bloc/authbloc/bloc/checklogin_bloc.dart';
import 'package:kist/component/buttonnavbarnotch.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CheckloginBloc, CheckloginState>(
        listener: (context, state) {
          if (state is CheckloginStatusTrue) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => ButtomNavBar1()),
                (route) => false);
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false);
          }
        },
        child: Container(),
      ),
    );
  }
}
