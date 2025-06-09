import 'package:flutter/material.dart';
import 'package:flutter_notes/pages/auth/ConfirmationPinScreen.dart';
import 'package:flutter_notes/utils/Constant.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ToggleBiometricPinScreen extends StatefulWidget {
  bool isEnable;

  ToggleBiometricPinScreen(this.isEnable);

  @override
  State<ToggleBiometricPinScreen> createState() =>
      _ToggleBiometricPinScreenState();
}

class _ToggleBiometricPinScreenState extends State<ToggleBiometricPinScreen> {
  String pinValue = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 50.0, bottom: 100.0),
          width: MediaQuery.of(context).size.width,
          child: Text(
            "Verifikasi PIN",
            style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        ),
        Image.asset('assets/img/lock.png'),
        Container(
          margin: const EdgeInsets.only(top: 50.0, bottom: 50.0),
          width: MediaQuery.of(context).size.width,
          child: Text(
            "Masukkan PIN Anda",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 80.0),
          child: PinCodeTextField(
            appContext: context,
            length: 6,
            obscureText: true,
            obscuringCharacter: '●',
            keyboardType: TextInputType.number,
            animationType: AnimationType.fade,
            textStyle: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.circle,
              fieldHeight: 30,
              fieldWidth: 30,
              activeFillColor: Colors.orange,
              selectedFillColor: Colors.orange,
              inactiveFillColor: Colors.orange,
              inactiveColor: Colors.orange,
              selectedColor: Colors.orange,
              activeColor: Colors.orange,
            ),
            animationDuration: Duration(milliseconds: 300),
            onChanged: (value) {},
            onCompleted: (value) async {
              if (getStringAsync(PIN) != value) {
                Fluttertoast.showToast(msg: "PIN Anda salah");
              } else {
                if (!widget.isEnable) {
                  await setValue(BIOMETRIC_ENABLED, false);

                  Fluttertoast.showToast(msg: "Biometric dimatikan");
                  Navigator.of(context).pop();
                } else {
                  await setValue(BIOMETRIC_ENABLED, true);

                  Fluttertoast.showToast(msg: "Biometric dinyalakan");
                  Navigator.of(context).pop();
                }
              }
            },
          ),
        )
      ],
    )));
  }
}
