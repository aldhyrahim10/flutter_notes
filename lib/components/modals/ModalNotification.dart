import 'package:flutter/material.dart';
import 'package:flutter_notes/components/forms/Checkbox.dart';

class ModalNotification extends StatefulWidget{
  @override
  State<ModalNotification> createState() => _ModalNotificationState(); 
}

class _ModalNotificationState extends State<ModalNotification>{

  bool sesuaiWaktu = true;
  bool satuHari = false;
  bool tigaJam = false;
  bool satuJam = false;

  final List<String> itemsDate = [
    '1', '2', '3', '4','5', '6', '7', '8', '9', '10', '11', '12', '12', '13', '14', '15',
    '16', '17', '18', '19','20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31'
  ];

  final List<String> itemsMonth = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
  ];
  final List<String> itemsYears = [
    '2025', '2026', '2027', '2028', '2029', '2030', 
    '2031', '2032', '2033', '2034', '2036', '2037'
  ];

  bool isAM = false;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650.0,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text("Nyalakan Notifikasi Untuk",
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black)
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFF8F8F8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.01),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: const Offset(0, 1),
                )
              ],
              borderRadius: BorderRadius.circular(10.0)
            ),
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Center(
              child: Text("Senin, 12 Februari - 12.00 AM",
                style: TextStyle(
                  fontSize: 14.0, 
                  fontWeight: FontWeight.w400
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 3 - 20,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    icon: Icon(Icons.keyboard_arrow_down, color: Colors.orange),
                    value: '1',
                    items: itemsDate.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
                    onChanged: (v) {},
                  ),
                )
              ),
              const SizedBox(
                width: 10.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 3 - 20,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    icon: Icon(Icons.keyboard_arrow_down, color: Colors.orange),
                    value: 'Januari',
                    items: itemsMonth.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
                    onChanged: (v) {},
                  ),
                )
              ),
              const SizedBox(
                width: 10.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 3 - 20,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    icon: Icon(Icons.keyboard_arrow_down, color: Colors.orange),
                    value: '2025',
                    items: itemsYears.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
                    onChanged: (v) {},
                  ),
                )
              ),
              
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Waktu Notifikasi", 
                style: TextStyle(
                  color: Colors.black, 
                  fontSize: 14.0
                  ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      // controller: hourController,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.orange,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      maxLength: 2,
                      decoration: InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                        hintText: "12"
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(":", 
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 30.0
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      // controller: hourController,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.orange,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      maxLength: 2,
                      decoration: InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                        hintText: "00"
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => isAM = true),
                          child: Container(
                            width: 45,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isAM ? Colors.orange : Colors.transparent,
                              borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
                            ),
                            child: Text("AM", style: TextStyle(
                              color: isAM ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w600)),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => isAM = false),
                          child: Container(
                            width: 45,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: !isAM ? Colors.orange : Colors.transparent,
                              borderRadius: BorderRadius.horizontal(right: Radius.circular(8)),
                            ),
                            child: Text("PM", style: TextStyle(
                              color: !isAM ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Divider(
            color: Colors.grey,
          ),
          SizedBox(
            height: 20)
          ,
          buildCheckbox("Sesuai waktu pengingat", sesuaiWaktu, (v) => setState(() => sesuaiWaktu = v)),
          buildCheckbox("1 hari sebelumnya", satuHari, (v) => setState(() => satuHari = v)),
          buildCheckbox("3 jam sebelumnya", tigaJam, (v) => setState(() => tigaJam = v)),
          buildCheckbox("1 jam sebelumnya", satuJam, (v) => setState(() => satuJam = v)),
          SizedBox(
            height: 20
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: (){}, 
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 14.0),
                  child: Text("Batalkan", 
                    style: TextStyle(
                      color: Colors.black, 
                      fontSize: 14.0, 
                      fontWeight: FontWeight.w400),),
                )
              ),
              SizedBox(
                width: 10.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: (){}, 
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 14.0),
                  child: Text("Simpan", 
                    style: TextStyle(
                      color: Colors.black, 
                      fontSize: 14.0, 
                      fontWeight: FontWeight.w400),),
                )
              ),
            ],
          )
        ],
      ),
    );
  }
  
}