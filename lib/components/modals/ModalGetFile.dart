import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_notes/components/forms/Checkbox.dart';
import 'package:image_picker/image_picker.dart';

class ModalGetFile extends StatefulWidget{
  @override
  State<ModalGetFile> createState() => _ModalGetFileState(); 
}

class _ModalGetFileState extends State<ModalGetFile>{
  File? _image;

  @override
  void initState(){
    super.initState();
  }

  Future<void> _pickImage() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      Navigator.pop(context, File(pickedFile.path)); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20.0,
          ),
         
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: (){
              _pickImage();
            }, 
            child: Container(
              width: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0)
              ),
              padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 14.0),
              child: Center(
                child: Text("Upload dari Galeri", 
                style: TextStyle(
                  color: Colors.black, 
                  fontSize: 14.0, 
                  fontWeight: FontWeight.w400),),
              )
            )
          ),
          SizedBox(
            height: 20.0,
          ),
          TextButton(onPressed: (){}, 
            child: Text("Batalkan", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),)
          )
        ],
      ),
    );
  }
  
}