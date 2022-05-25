import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:kist/Services/Apiconnectservices.dart';
import 'package:kist/Services/firebaseservices.dart';
import 'package:kist/bloc/loginbloc/login_bloc.dart';
import 'package:kist/component/buttonnavbarnotch.dart';
import 'package:kist/cubit/category/category_cubit.dart';
import 'package:kist/cubit/logincubit/logincubit_cubit.dart';
import 'package:kist/cubit/storedata/storecategories_cubit.dart';
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
  final ImagePicker _picker = ImagePicker();

  final _formkey = GlobalKey<FormState>();
  var buttonstate = ButtonState.idle;
  var image;
  //Place A
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("CategoryAdd"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(32),
            child: BlocListener<StorecategoriesCubit, StorecategoriesState>(
              listener: (context, state) {
                if (state is StorecategoriesButtonPressed) {
                  setState(() {
                    buttonstate = ButtonState.loading;
                  });
                }
                if (state is StorecategoriesStored) {
                  snackbar("success");
                  setState(() {
                    buttonstate = ButtonState.success;
                    BlocProvider.of<CategoryCubit>(context).fetchcategorydata();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => ButtomNavBar1()),
                        (route) => false);
                  });
                }
                if (state is StorecategoriesError) {
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
              child: BlocListener<StorecategoriesCubit, StorecategoriesState>(
                listener: (context, state) {
                  // TODO: implement listener
                  if (state is StorecategoriesButtonPressed) {
                    setState(() {
                      buttonstate = ButtonState.loading;
                    });
                  }
                  if (state is StorecategoriesStored) {
                    setState(() {
                      buttonstate = ButtonState.success;
                    });
                  }
                },
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          buttonactionsheet();
                        },
                        child: image == null
                            ? Container(
                                child: Image.asset("assets/images.jpeg"),
                              )
                            : Container(
                                child: Image.file(
                                File(image),
                                height: 100,
                              )),
                      ),
                      SizedBox(
                        height: 20,
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
                          if (value == null) {
                            return "This field is required";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(238, 238, 238, 1))),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(238, 238, 238, 1))),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
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
                              if (_formkey.currentState!.validate()) {
                                BlocProvider.of<StorecategoriesCubit>(context)
                                    .storedata(
                                        _title.text, _description.text, image);
                              }
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
            ),
          ),
        ));
  }

  buttonactionsheet() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Choose Options'),
        message: const Text('Your options are '),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              imagepicker(ImageSource.camera);
              Navigator.pop(context, 'One');
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Gallery'),
            onPressed: () {
              imagepicker(ImageSource.gallery);
              Navigator.pop(context, 'Two');
            },
          )
        ],
      ),
    );
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

  imagepicker(type) async {
    var imagechoose = await _picker.pickImage(source: type);
    setState(() {
      imagechoose != null ? image = imagechoose.path : image;
    });
  }
}
