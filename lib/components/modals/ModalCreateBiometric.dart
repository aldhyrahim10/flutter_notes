import 'package:flutter/material.dart';
import 'package:flutter_notes/pages/HomeScreen.dart';
import 'package:flutter_notes/utils/Constant.dart';
import 'package:local_auth/local_auth.dart';
import 'package:nb_utils/nb_utils.dart';

class ModalCreateBiometric extends StatefulWidget {
  @override
  State<ModalCreateBiometric> createState() => _ModalCreateBiometricState();
}

class _ModalCreateBiometricState extends State<ModalCreateBiometric> {
  final LocalAuthentication auth = LocalAuthentication();
  bool isEnabledBiometric = false;

  Future<void> _authenticate() async {
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    bool isDeviceSupported = await auth.isDeviceSupported();

    if (!canCheckBiometrics || !isDeviceSupported) {
      toast('Perangkat tidak mendukung biometric.');
      return;
    }

    bool authenticated = false;

    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Scan sidik jari untuk login',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      print('Gagal otentikasi: $e');
      return;
    }

    if (!mounted) return; // Pastikan widget masih aktif sebelum update state

    setState(() {
      isEnabledBiometric = authenticated;
    });

    await setValue(BIOMETRIC_ENABLED, isEnabledBiometric);

    // Tutup modal setelah otentikasi berhasil/atau selesai
    Navigator.of(context).pop();

    if (authenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(0)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Apakah Anda ingin mengaktifkan login biometric?",
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: _authenticate,
              child: Text(
                "Iya aktifkan",
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
