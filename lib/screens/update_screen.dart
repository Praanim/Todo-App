import 'package:flutter/material.dart';

import 'package:hamro_app/database/db_services.dart';
import 'package:hamro_app/model/todo_model.dart';

class UpdateScreen extends StatefulWidget {
  final String authId;
  final ToDo todo;
  const UpdateScreen({
    Key? key,
    required this.authId,
    required this.todo,
  }) : super(key: key);

  @override
  State<UpdateScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<UpdateScreen> {
  late TextEditingController _titlecontroller;
  late TextEditingController _descriptioncontroller;
  DatabaseHelper _databaseHelper = DatabaseHelper();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titlecontroller = TextEditingController(text: widget.todo.title);
    _descriptioncontroller =
        TextEditingController(text: widget.todo.description);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titlecontroller.dispose();
    _descriptioncontroller.dispose();
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple.shade400,
        body: Form(
          key: formKey,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Update Your Task ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                SizedBox(
                  height: 20,
                ),
                _customTextForm(
                    isStatus: true,
                    hintText: "ToDo Title",
                    mycontroller: _titlecontroller,
                    validating: (val) {
                      return val!.isEmpty ? "Can't be empty" : null;
                    }),
                SizedBox(
                  height: 20,
                ),
                _customTextForm(
                    isStatus: true,
                    hintText: "Description",
                    mycontroller: _descriptioncontroller,
                    validating: (val) {
                      return val!.isEmpty ? "Can't be empty" : null;
                    }),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton.icon(
                      onPressed: () {
                        _databaseHelper.updateUserData(widget.authId,
                            _titlecontroller.text, _descriptioncontroller.text);
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.done,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Update",
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        ));
  }

  _customTextForm(
      {TextEditingController? mycontroller,
      String? hintText,
      bool? isStatus,
      String? Function(String?)? validating}) {
    return TextFormField(
      cursorColor: Colors.pink,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.white,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.pink,
            )),
      ),
      controller: mycontroller,
      validator: validating,
    );
  }
}
