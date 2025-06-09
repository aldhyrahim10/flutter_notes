import 'package:flutter/material.dart';
import 'package:flutter_notes/components/modals/ModalCreateBiometric.dart';
import 'package:flutter_notes/utils/Constant.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ConfirmationPinScreen extends StatefulWidget{

  String entryPin;

  ConfirmationPinScreen(this.entryPin);

  @override
  State<ConfirmationPinScreen> createState() => _ConfirmationPinScreenState();
}

class _ConfirmationPinScreenState extends State<ConfirmationPinScreen>{

  String pinConfirmation = "";

  @override
  void initState(){
    super.initState();
  }

  void prosesCreatePIN(String pinNumber) async{
    await setValue(PIN, pinNumber);

    showModalBiometric();
  }


  showModalBiometric(){
    return showModalBottomSheet(
      context: context, 
      isDismissible: false,
      enableDrag: false,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets, // untuk keyboard
          child: ModalCreateBiometric(),
        );
      },
    );
  }
  

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
              child: Text("Verifikasi PIN", style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w700), textAlign: TextAlign.center,),
            ),
            Image.asset('assets/img/lock.png'),
            Container(
              margin: const EdgeInsets.only(top: 50.0, bottom: 50.0),
              width: MediaQuery.of(context).size.width,
              child: Text("Konfirmasi PIN Anda", style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
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
                  pinConfirmation = value;

                  if (pinConfirmation == widget.entryPin) {
                    prosesCreatePIN(pinConfirmation);
                  } else{
                    Fluttertoast.showToast(msg: "PIN tidak sesuai, silahkan input kembali");
                  }
                  
                },
              ),
            )
          ],
        )
      ) 
    );
  }
  
}