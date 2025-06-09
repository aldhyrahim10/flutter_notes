import 'package:flutter/material.dart';
import 'package:flutter_notes/pages/HomeScreen.dart';

class ModalCreateBiometric extends StatefulWidget{
  @override
  State<ModalCreateBiometric> createState() => _ModalCreateBiometricState(); 
}

class _ModalCreateBiometricState extends State<ModalCreateBiometric>{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Apakah Anda ingin mengaktifkan login biometric?", 
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: (){
                print("fitur biometric aktif");
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(0),),);
              },
              child: Text("Iya aktifkan", 
                style: TextStyle(color: Colors.orange, fontSize: 12.0, fontWeight: FontWeight.w500), 
                textAlign: TextAlign.center,),
            )
          ],
        ),
      ),
    );
  }

}