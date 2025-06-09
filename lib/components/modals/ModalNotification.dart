import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_notes/components/forms/Checkbox.dart';
import 'package:flutter_notes/database/NotesDao.dart';
import 'package:flutter_notes/database/RemindersDao.dart';
import 'package:flutter_notes/main.dart';
import 'package:flutter_notes/models/Reminder.dart';
import 'package:flutter_notes/utils/Permission.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:timezone/timezone.dart' as tz;

class ModalNotification extends StatefulWidget {
  int id;
  ModalNotification(this.id);

  @override
  State<ModalNotification> createState() => _ModalNotificationState();
}

class _ModalNotificationState extends State<ModalNotification> {
  bool sesuaiWaktu = true;
  bool satuHari = false;
  bool tigaJam = false;
  bool satuJam = false;

  String getMonthName(int month) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return months[month - 1];
  }

  int getMonthNumber(String monthName) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return months.indexOf(monthName) + 1;
  }

  String getDayName(int day, int month, int year) {
    DateTime date = DateTime(year, month, day);
    return DateFormat('EEEE', 'id_ID').format(date);
  }

  late String selectedDate;
  late String selectedMonth;
  late int selectedMonthInNumber;
  late String selectedYear;
  late String selectedDay;

  final hourController = TextEditingController();
  final minuteController = TextEditingController();

  final List<String> itemsDate = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
  final List<String> itemsMonth = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];
  final List<String> itemsYears = [
    '2025',
    '2026',
    '2027',
    '2028',
    '2029',
    '2030',
    '2031',
    '2032',
    '2033',
    '2034',
    '2036',
    '2037'
  ];

  bool isAM = false;

  @override
  void initState() {
    super.initState();

    DateTime now = DateTime.now();
    selectedDate = now.day.toString();
    selectedMonth = getMonthName(now.month);
    selectedMonthInNumber = now.month;
    selectedYear = now.year.toString();
    selectedDay = getDayName(now.day, now.month, now.year);

    loadReminder();
  }

  void loadReminder() async {
    ReminderDao dao = ReminderDao();
    List<Reminder> reminders = await dao.getAllReminders();

    // Ambil reminder untuk noteID tertentu
    reminders = reminders.where((r) => r.noteID == widget.id).toList();

    if (reminders.isEmpty) return;

    // Ambil reminder utama (yang sesuai waktu pengingat)
    reminders.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    Reminder mainReminder = reminders.first;

    DateTime dt = mainReminder.dateTime;
    int hour = dt.hour;
    int minute = dt.minute;

    setState(() {
      selectedDate = dt.day.toString();
      selectedMonth = getMonthName(dt.month);
      selectedMonthInNumber = dt.month;
      selectedYear = dt.year.toString();
      selectedDay = getDayName(dt.day, dt.month, dt.year);

      hourController.text =
          (hour % 12 == 0 ? 12 : hour % 12).toString().padLeft(2, '0');
      minuteController.text = minute.toString().padLeft(2, '0');
      isAM = hour < 12;

      sesuaiWaktu = false;
      satuHari = false;
      tigaJam = false;
      satuJam = false;

      for (var reminder in reminders) {
        int offset =
            mainReminder.dateTime.difference(reminder.dateTime).inMinutes;
        if (offset == 0) sesuaiWaktu = true;
        if (offset == 60) satuJam = true;
        if (offset == 180) tigaJam = true;
        if (offset == 1440) satuHari = true;
      }
    });

    print("ada data");
  }

  void processReminder() async {
    // Validasi input jam dan menit
    if (hourController.text.trim().isEmpty ||
        minuteController.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: "Jam dan menit tidak boleh kosong");
      return;
    }

    int? hour = int.tryParse(hourController.text);
    int? minute = int.tryParse(minuteController.text);

    if (hour == null ||
        minute == null ||
        hour < 1 ||
        hour > 12 ||
        minute < 0 ||
        minute > 59) {
      Fluttertoast.showToast(
          msg: "Masukkan jam (1-12) dan menit (0-59) yang valid");
      return;
    }

    if (!isAM && hour != 12) {
      hour += 12;
    } else if (isAM && hour == 12) {
      hour = 0;
    }

    if (selectedDate.isEmpty || selectedMonth.isEmpty || selectedYear.isEmpty) {
      Fluttertoast.showToast(msg: "Tanggal tidak boleh kosong");
      return;
    }

    int? day = int.tryParse(selectedDate);
    int? year = int.tryParse(selectedYear);
    int month = selectedMonthInNumber;

    if (day == null || year == null) {
      Fluttertoast.showToast(msg: "Tanggal tidak valid");
      return;
    }

    DateTime notificationDateTime = DateTime(year, month, day, hour, minute);

    if (notificationDateTime.isBefore(DateTime.now())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Waktu notifikasi tidak boleh di masa lalu")),
      );
      return;
    }

    List<DateTime> reminderTimes = [];
    if (sesuaiWaktu) reminderTimes.add(notificationDateTime);
    if (satuHari)
      reminderTimes.add(notificationDateTime.subtract(Duration(days: 1)));
    if (tigaJam)
      reminderTimes.add(notificationDateTime.subtract(Duration(hours: 3)));
    if (satuJam)
      reminderTimes.add(notificationDateTime.subtract(Duration(hours: 1)));

    reminderTimes =
        reminderTimes.where((dt) => dt.isAfter(DateTime.now())).toList();

    if (reminderTimes.isEmpty) {
      Fluttertoast.showToast(msg: "Semua waktu notifikasi sudah lewat");
      return;
    }

    ReminderDao dao = ReminderDao();
    Reminder? existing = await dao.getReminderByNoteId(widget.id);

    List<int> offsets = reminderTimes
        .map((reminderTime) =>
            notificationDateTime.difference(reminderTime).inMinutes)
        .toList();

    int reminderId;

    try {
      if (existing != null) {
        Reminder updatedReminder = Reminder(
          id: existing.id,
          noteID: widget.id,
          dateTime: notificationDateTime,
          notificationTimeReminder: offsets,
        );
        await dao.updateReminder(updatedReminder);
        reminderId = existing.id!;
        Fluttertoast.showToast(msg: "Reminder berhasil diubah");
      } else {
        Reminder newReminder = Reminder(
          noteID: widget.id,
          dateTime: notificationDateTime,
          notificationTimeReminder: offsets,
        );
        reminderId = await dao.insertReminder(newReminder);
        Fluttertoast.showToast(msg: "Reminder berhasil disimpan");
      }

      // Ambil detail note untuk isi notifikasi
      final noteDao = NoteDao();
      final note = await noteDao.getNoteById(widget.id);

      String noteTitle = note?.title ?? "Pengingat Catatan";
      String noteContent = note?.description ?? "Jangan lupa cek catatanmu!";

      await checkExactAlarmPermission();
      // Jadwalkan notifikasi untuk setiap waktu pengingat
      for (int i = 0; i < reminderTimes.length; i++) {
        int notificationId = reminderId * 10 + i;

        await flutterLocalNotificationsPlugin.zonedSchedule(
          notificationId,
          noteTitle,
          noteContent.length > 50
              ? noteContent.substring(0, 50) + '...'
              : noteContent,
          tz.TZDateTime.from(reminderTimes[i], tz.local),
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'reminder_channel',
              'Reminder Notifications',
              channelDescription:
                  'Channel untuk notifikasi pengingat dari catatan',
              importance: Importance.max,
              priority: Priority.high,
            ),
          ),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          payload: widget.id.toString(),
        );
        print(
            'Scheduled notification at: ${reminderTimes[i]} with ID: $notificationId');
      }
      Fluttertoast.showToast(msg: "Berhasil menyimpan reminder");
      Navigator.of(context).pop();
    } catch (e) {
      Fluttertoast.showToast(msg: "Gagal menyimpan reminder");
      print(e);
    }
  }

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
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
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
                borderRadius: BorderRadius.circular(10.0)),
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Center(
              child: isAM
                  ? Text(
                      "$selectedDay, $selectedDate $selectedMonth $selectedYear - ${hourController.text}.${minuteController.text} AM",
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.w400),
                    )
                  : Text(
                      "$selectedDay, $selectedDate $selectedMonth $selectedYear - ${hourController.text}.${minuteController.text} PM",
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.w400),
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
                      icon:
                          Icon(Icons.keyboard_arrow_down, color: Colors.orange),
                      value: selectedDate,
                      items: itemsDate
                          .map(
                              (v) => DropdownMenuItem(value: v, child: Text(v)))
                          .toList(),
                      onChanged: (v) {
                        setState(() {
                          selectedDate = v!;
                          selectedDay = getDayName(
                              selectedDate.toInt(),
                              getMonthNumber(selectedMonth),
                              selectedYear.toInt());
                        });
                      },
                    ),
                  )),
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
                      icon:
                          Icon(Icons.keyboard_arrow_down, color: Colors.orange),
                      value: selectedMonth,
                      items: itemsMonth
                          .map(
                              (v) => DropdownMenuItem(value: v, child: Text(v)))
                          .toList(),
                      onChanged: (v) {
                        setState(() {
                          selectedMonthInNumber = getMonthNumber(v!);
                          selectedMonth = v!;
                          selectedDay = getDayName(selectedDate.toInt(),
                              selectedMonthInNumber, selectedYear.toInt());
                        });
                      },
                    ),
                  )),
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
                      icon:
                          Icon(Icons.keyboard_arrow_down, color: Colors.orange),
                      value: selectedYear,
                      items: itemsYears
                          .map(
                              (v) => DropdownMenuItem(value: v, child: Text(v)))
                          .toList(),
                      onChanged: (v) {
                        setState(() {
                          selectedYear = v!;
                          selectedDay = getDayName(selectedDate.toInt(),
                              selectedMonthInNumber, selectedYear.toInt());
                        });
                      },
                    ),
                  )),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Waktu Notifikasi",
                style: TextStyle(color: Colors.black, fontSize: 14.0),
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
                      controller: hourController,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.orange,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      maxLength: 2,
                      decoration: InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          hintText: "12"),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    ":",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 30.0),
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
                      controller: minuteController,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.orange,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      maxLength: 2,
                      decoration: InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          hintText: "00"),
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
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(8)),
                            ),
                            child: Text("AM",
                                style: TextStyle(
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
                              borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(8)),
                            ),
                            child: Text("PM",
                                style: TextStyle(
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
          SizedBox(height: 20),
          buildCheckbox("Sesuai waktu pengingat", sesuaiWaktu,
              (v) => setState(() => sesuaiWaktu = v)),
          buildCheckbox("1 hari sebelumnya", satuHari,
              (v) => setState(() => satuHari = v)),
          buildCheckbox(
              "3 jam sebelumnya", tigaJam, (v) => setState(() => tigaJam = v)),
          buildCheckbox(
              "1 jam sebelumnya", satuJam, (v) => setState(() => satuJam = v)),
          SizedBox(height: 20),
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
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 14.0),
                    child: Text(
                      "Batalkan",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                    ),
                  )),
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
                  onPressed: () {
                    processReminder();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 14.0),
                    child: Text(
                      "Simpan",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
