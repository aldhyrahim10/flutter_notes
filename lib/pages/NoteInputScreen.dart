import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_notes/components/modals/ModalGetFile.dart';
import 'package:flutter_notes/database/NotesDao.dart';
import 'package:flutter_notes/models/Notes.dart';

class NoteInputScreen extends StatefulWidget{
  @override
  State<NoteInputScreen> createState() => _NoteInputScreenState();
}

class _NoteInputScreenState extends State<NoteInputScreen>{

  File? _selectedImage;

  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  void initState(){
    super.initState();
    _description.addListener(() {
      setState(() {}); 
    });
  }

  @override
void dispose() {
  _title.dispose();
  _description.dispose();
  super.dispose();
}

  void showModalGetFile() async {
    final result = await showModalBottomSheet<File>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: ModalGetFile(),
        );
      },
    );

    if (result != null) {
      setState(() {
        _selectedImage = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            _description.text.trim().isNotEmpty ?
              TextButton(
                onPressed: () async{
                  final note = Note(
                    title: _title.text.trim(),
                    description: _description.text.trim(),
                    image: _selectedImage?.path,
                    createdDate: DateTime.now().toIso8601String(),
                    updatedDate: DateTime.now().toIso8601String(),
                  );
                  
                  await NoteDao().insertNote(note);

                   Navigator.pop(context, true); 
                }, 
                child: Text("Simpan", style: TextStyle(color: Colors.orange),)) : 
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 30.0,
                    height: 30.0,
                    margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      border: BoxBorder.all(color: Colors.orange)
                    ),
                    child: Icon(Icons.close, color: Colors.orange,),
                  ),
                )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _title,
                  cursorColor: Colors.orange,
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Color(0xFF232323),
                    fontWeight: FontWeight.w600
                  ),
                  decoration: InputDecoration(
                    hintText: "Masukkan Judul",
                    border: InputBorder.none
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: TextFormField(
                    controller: _description,
                    maxLines: null,
                    expands: true,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFF232323),
                      fontWeight: FontWeight.w400
                    ),
                    decoration: InputDecoration(
                      hintText: "Tuliskan Catatan",
                      hintStyle: TextStyle(
                      color: Colors.grey.shade300,
                        fontSize: 16,
                      ),
                      border: InputBorder.none,
                      isCollapsed: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ) 
                ),
                SizedBox(
                  height: 20.0,
                ),

                _selectedImage != null ?
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Image.file(_selectedImage!, height: 150),
                  ) : Container()
              ],
            )
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          shape: CircleBorder(),
          onPressed: (){
            showModalGetFile();
          },
          child: Icon(Icons.attach_file, color: Colors.white,)
        ),
      )
    );
  }
  
}