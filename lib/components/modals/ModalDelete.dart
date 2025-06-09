import 'package:flutter/material.dart';
import 'package:flutter_notes/components/forms/Checkbox.dart';
import 'package:flutter_notes/database/NotesDao.dart';

class ModalDelete extends StatefulWidget{
  
  final int? id;
  
  ModalDelete(this.id);

  @override
  State<ModalDelete> createState() => _ModalDeleteState(); 
}

class _ModalDeleteState extends State<ModalDelete>{

  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Center(
            child: Image.asset('assets/img/lock.png'),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text("Apakah Anda yakin akan menghapus note?",
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400
            ),
          ),
          const SizedBox(
            height: 20.0,
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
                onPressed: (){
                  Navigator.pop(context);
                }, 
                child: Container(width: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 14.0),
                  child: Center(
                    child: Text("Batalkan", 
                    style: TextStyle(
                      color: Colors.black, 
                      fontSize: 14.0, 
                      fontWeight: FontWeight.w400),),
                  )
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
                onPressed: () async{
                  final dao = NoteDao();
                  
                  print(widget.id);


                  await dao.deleteNote(widget.id!);

                  Navigator.pop(context, true);
                },  
                child: Container(
                  width: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 14.0),
                  child: Center(
                    child: Text("Iya", 
                        style: TextStyle(
                          color: Colors.white, 
                          fontSize: 14.0, 
                          fontWeight: FontWeight.w400),),
                    ),
                  )
              ),
            ],
          )
        ],
      ),
    );
  }
  
}