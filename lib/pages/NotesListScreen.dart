import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_notes/components/modals/ModalDelete.dart';
import 'package:flutter_notes/components/modals/ModalNotification.dart';
import 'package:flutter_notes/database/NotesDao.dart';
import 'package:flutter_notes/models/Notes.dart';
import 'package:flutter_notes/pages/NoteUpdateScreen.dart';
import 'package:nb_utils/nb_utils.dart';

class NotesListScreen extends StatefulWidget{

  const NotesListScreen({Key? key}) : super(key: key);
 

  @override
  State<NotesListScreen> createState() => NotesListScreenState();

}

class NotesListScreenState extends State<NotesListScreen>{

  late Future<List<Note>> lstNotes;


  @override
  void initState(){
    super.initState();

    getAllData();
  }

  void getAllData(){
    lstNotes = NoteDao().getAllNotes();
  }

  void refreshData(){
    setState(() {
      getAllData();
    });
  }

  void showModalSettingReminder(){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets, // untuk keyboard
        child: ModalNotification(),
      ),
    );

    
  }

  void showModalDelete(int? id) async{
    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: ModalDelete(id),
      ),
    );

    if (result == true) {
      refreshData(); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: (){}, 
              icon: Icon(Icons.notifications_none_outlined, color: Colors.orange, size: 30.0,))
          ],
        ),
        body: FutureBuilder(
          future: lstNotes, 
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/img/empty.png', scale: 10.0,),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(child: Text("Belum terdapat notes baru",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500
                    ),
                   ))
                ],
              );
            } else {
              final notes = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("List Catatan", 
                      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.grey),),
                    Container(
                      margin: const EdgeInsets.only(top: 20.0),  
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 330.0,
                      child: ListView.builder(
                        itemCount: notes.length,
                        itemBuilder: (context, index) {
                          var item = notes[index];
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFF9F9F9),
                              borderRadius: BorderRadius.circular(
                                10.0
                              ),
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
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(item.title, 
                                      style: TextStyle(
                                          fontSize: 16.0, 
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            NoteUpdateScreen(item).launch(context).then((value) => refreshData(),);
                                          },
                                          child:  Icon(Icons.edit, size: 20.0,),
                                        ),
                                        SizedBox(width: 8),
                                        GestureDetector(
                                          onTap: (){
                                            showModalSettingReminder();
                                          },
                                          child: Icon(Icons.notifications_none_outlined, size: 20.0,),
                                        ),
                                        SizedBox(width: 8),
                                        GestureDetector(
                                          onTap: (){
                                            showModalDelete(item.id);
                                          },
                                          child: Icon(Icons.delete_outline_outlined, size: 20.0, color: Colors.red,),
                                        )
                                      ],
                                    )
                                    
                                  ],
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                item.description != "" ? 
                                  Text(item.description, 
                                    style: TextStyle(
                                      fontSize: 12.0, 
                                      fontWeight: FontWeight.w400, color: Color(0xFF454545)),) : 
                                  Container(),
                                SizedBox(
                                  height: 10.0,
                                ),
                                item.image != null && item.image!.isNotEmpty
                                  ? Image.file(File(item.image!), height: 150)
                                  : Container()
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            }
          },
        )
      )
    );
  } 
}


