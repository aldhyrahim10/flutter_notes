import 'package:flutter/material.dart';
import 'package:flutter_notes/pages/auth/ConfirmationPinScreen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class NewPinScreen extends StatefulWidget {
  String entryPin;

  NewPinScreen(this.entryPin);

  @override
  State<NewPinScreen> createState() => _NewPinScreenState();
}

class _NewPinScreenState extends State<NewPinScreen> {
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
            "Masukkan PIN Baru Anda",
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
            onCompleted: (value) {
              pinValue = value;

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmationPinScreen(pinValue, true),
                  ));
            },
          ),
        )
      ],
    )));
  }
}
