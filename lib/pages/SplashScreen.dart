import 'package:flutter/material.dart';
import 'package:flutter_notes/pages/auth/InputPinScreen.dart';
import 'package:flutter_notes/pages/auth/LoginWithPinScreen.dart';
import 'package:flutter_notes/utils/Constant.dart';
import 'package:nb_utils/nb_utils.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{

  String pinApps = getStringAsync(PIN);

  @override
  void initState(){
    super.initState();

    init();
  }

  init() async{
    await Future.delayed(Duration(milliseconds: 5000));

    if(pinApps != ""){
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => LoginWithPinScreen(),)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 400,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(120.0), 
                      bottomRight: Radius.circular(120.0)
                    )
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150.0,
                ),
                Center(
                  child: Image.asset("assets/img/logo.png"),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text("Your number one note taking tool!", 
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 14.0
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Image.asset("assets/img/splash-img.png"),
                ),
                pinApps == "" ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => InputPinScreen(),),);
                    }, 
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 14.0),
                      child: Text("Buat PIN", 
                        style: TextStyle(
                          color: Colors.white, 
                          fontSize: 14.0, 
                          fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        )
                    )
                  ),
                  
                ) : Container()
              ],
            )
          ],
        ),
      )
    );
  }
  
}