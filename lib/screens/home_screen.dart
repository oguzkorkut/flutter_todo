import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/screens/add_note_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Widget _buildNote (int index){
    return Padding(padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('Note Title'),
              subtitle: Text('Aug 8, 2022 High'),
              trailing: Checkbox(
                onChanged: (value){
                  print(value);
                },
                activeColor: Theme.of(context).primaryColor,
                value: true,
              ),
            ),
            Divider(height: 5.0, color: Colors.deepPurple, thickness: 2.0,),
          ],
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(context, CupertinoPageRoute(builder: (_) => AddNoteScreen(),));
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 80.0),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                child: Column (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'My Notes',
                      style: TextStyle(
                          color: Colors.deepPurple,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Text(
                      '0 - 10',
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 40.0,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                ),
            );
          }
          return _buildNote(index);
        },
      ),
    );
  }
}
