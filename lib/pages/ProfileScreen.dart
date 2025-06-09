import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget{
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>{
  bool isReminderOn = false;
  bool isBiometricOn = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Profil", 
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.notifications_none, 
                        color: Colors.black,
                        size: 30.0,  
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text("Reminder", 
                        style: TextStyle(
                          color: Colors.black, 
                          fontSize: 16.0, 
                          fontWeight: FontWeight.w400
                        ),
                      )
                    ],
                  ),
                  Switch(
                    value: isReminderOn, 
                    onChanged: (value) {
                      setState(() {
                        isReminderOn = value;
                      });
                    },
                    activeColor: Colors.orange, // knob color
                    activeTrackColor: Colors.orange.shade100, // background track when ON
                    inactiveThumbColor: Colors.grey.shade300, // knob when OFF
                    inactiveTrackColor: Colors.grey.shade200,

                  )
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.fingerprint, 
                        color: Colors.black,
                        size: 30.0,  
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text("Biometric", 
                        style: TextStyle(
                          color: Colors.black, 
                          fontSize: 16.0, 
                          fontWeight: FontWeight.w400
                        ),
                      )
                    ],
                  ),
                  Switch(
                    value: isBiometricOn, 
                    onChanged: (value) {
                      setState(() {
                        isBiometricOn = value;
                      });
                    },
                    activeColor: Colors.orange, // knob color
                    activeTrackColor: Colors.orange.shade100, // background track when ON
                    inactiveThumbColor: Colors.grey.shade300, // knob when OFF
                    inactiveTrackColor: Colors.grey.shade200,
                    
                  )
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: (){},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lock_outline, 
                          color: Colors.black,
                          size: 30.0,  
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text("PIN", 
                          style: TextStyle(
                            color: Colors.black, 
                            fontSize: 16.0, 
                            fontWeight: FontWeight.w400
                          ),
                        )
                      ],
                    ),
                    IconButton(
                      onPressed: (){}, 
                      icon: Icon(Icons.arrow_forward_ios)
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: (){},
                child: Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.logout_outlined, 
                          color: Colors.black,
                          size: 30.0,  
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text("Keluar", 
                          style: TextStyle(
                            color: Colors.black, 
                            fontSize: 16.0, 
                            fontWeight: FontWeight.w400
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      )
    );
  }
  
}