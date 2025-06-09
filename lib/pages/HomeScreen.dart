import 'package:flutter/material.dart';
import 'package:flutter_notes/pages/NoteInputScreen.dart';
import 'package:flutter_notes/pages/NotesListScreen.dart';
import 'package:flutter_notes/pages/ProfileScreen.dart';

class HomeScreen extends StatefulWidget{
  int index;

  HomeScreen(this.index);
  

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  
  final GlobalKey<NotesListScreenState> _notesListKey = GlobalKey<NotesListScreenState>();

  int selectedIndex = 0;
  late List<Widget> pages;
  
  @override
  void initState(){
    super.initState();

    pages = [
      NotesListScreen(key: _notesListKey),
      ProfileScreen()
    ];

    if (widget.index != 0) {
      selectedIndex = widget.index;
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: pages[selectedIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        shape: CircleBorder(),
        onPressed: () async{
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoteInputScreen()),
          );

         
          if (result == true && selectedIndex == 0) {
            _notesListKey.currentState?.refreshData();

          }
        },
        child: Icon(Icons.edit_square, color: Colors.white,)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: BottomAppBar(
        
        shape: CircularNotchedRectangle(),
        elevation: 4,
        color: Colors.white,
        notchMargin: 8.0,
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 0; 
                  print(selectedIndex);
                });
              },
              child: Column(
                children: [
                  IconButton(
                    onPressed: (){
                      setState(() {
                        selectedIndex = 0; 
                        print(selectedIndex);
                      });
                    },
                    icon: Icon(
                      Icons.home, 
                      color: selectedIndex == 0 ? Colors.orange : Colors.grey,),),
                  Text("Beranda", 
                    style: TextStyle(
                      fontSize: 10.0, fontWeight: FontWeight.w600, 
                      color: selectedIndex == 0 ? Colors.orange : Colors.grey,),)
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: Text("Notes Baru", style: 
                TextStyle(fontSize: 11.0, fontWeight: FontWeight.w400, color: Colors.grey,),),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
              },
              child: Column(
                children: [
                  IconButton(
                    onPressed: (){
                      setState(() {
                        selectedIndex = 1; 
                      });
                    },
                    icon: Icon(Icons.account_circle, color: selectedIndex == 1 ? Colors.orange : Colors.grey,),),
                  Text("Profil", style: 
                    TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, color: selectedIndex == 1 ? Colors.orange : Colors.grey,))
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
  
}