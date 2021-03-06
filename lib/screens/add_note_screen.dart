import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/screens/home_screen.dart';
import 'package:intl/intl.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _dateController = TextEditingController();

  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');

  String _title = '';
  String _priority = 'Low';
  DateTime _date = DateTime.now();

  String btnText = 'Add Note';
  String titleText = 'Add Note';
  final List<String> _priorities = ['Low', 'Medium', 'High'];

  _handleDatePicker() async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dateController.text = _dateFormatter.format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: GestureDetector(
        // unfocus yapıyor açılan pencereyi
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomeScreen(),
                      )),
                  child: Icon(
                    Icons.arrow_back,
                    size: 30.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  titleText,
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: TextFormField(
                          style: TextStyle(fontSize: 18.0),
                          decoration: InputDecoration(
                              labelText: 'Title',
                              labelStyle: TextStyle(fontSize: 18.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))
                          ),
                          validator: (input) =>
                              input!.trim().isEmpty ? 'Please enter a note title' : null,
                          onSaved: (input) => _title = input!,
                          initialValue: _title,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: TextFormField(
                          readOnly: true,
                          controller: _dateController,
                          style: TextStyle(fontSize: 18.0),
                          onTap: _handleDatePicker,
                          decoration: InputDecoration(
                              labelText: 'Date',
                              labelStyle: TextStyle(fontSize: 18.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: DropdownButtonFormField(
                          items: _priorities.map((String priority) {
                            return DropdownMenuItem(
                              value: priority,
                              child: Text(
                                priority,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              ),
                            );
                          }).toList(),
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                          decoration: InputDecoration(
                              labelText: 'Priovity',
                              labelStyle: TextStyle(fontSize: 18.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                              )
                          ),
                          onChanged: (value) {
                            setState(() {
                              _priority = value.toString();
                            });
                          },
                          value: _priority,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        height: 60.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: ElevatedButton(
                          child: Text(
                            btnText,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0
                            ),
                          ),
                          onPressed: () {

                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
