import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:wilson_tours_app/utils/color.dart';

class CommonWdget {
  static File? imagee;

  ///Tost
  static void toastShow(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[800],
        textColor: Colors.white,
        fontSize: 16.0);
  }

////////////////////*************DialogBox */
  static confirmBox(String titlle, String texte, VoidCallback click, context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      borderSide: const BorderSide(
        color: kPrimaryColor,
        width: 2,
      ),
      width: kIsWeb ? Get.width / 3 : Get.width,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      onDismissCallback: (type) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('......'),
          ),
        );
      },
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: titlle,
      desc: texte,
      showCloseIcon: true,
      btnOkText: titlle,
      btnOkColor:kPrimaryColor,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        click();
      },
    ).show();
  }

  static logoutDialog(String titlle, String texte, VoidCallback click) {
    return Get.defaultDialog(
        backgroundColor: kPrimaryColor,
        title: titlle,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        middleText: texte, //"Are you sure you want to delete this user?",
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    // color: kPrimaryColor,
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                      Colors.amber,
                    )),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      click();
                      Get.back();
                      // AuthServices.deleteAccount(email);
                      //Get.back();
                    },
                    // color: Colors.red,
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                      Colors.red,
                    )),
                    child: Text(
                      titlle,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          )
        ]);
  }

  daialogg(context) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.info,
      body: Center(
        child: Text(
          'If the body is specified, then title and description will be ignored, this allows to 											further customize the dialogue.',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      title: 'This is Ignored',
      desc: 'This is also Ignored',
      btnOkOnPress: () {},
    )..show();
  }

  static ProgressPopup(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(child: Center(child: new CircularProgressIndicator()));
      },
    );
  }





  static appbar(title){
    return AppBar(
      backgroundColor: bgColor,
    title: Container(
      height: 80,
      width: 80,
      child: Image.asset("assets/logo.png")),
    centerTitle: true,
    );
  }
}
