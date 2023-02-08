import 'package:flutter/material.dart';

import 'package:hamro_app/database/db_services.dart';

class FormScreen extends StatefulWidget {
  final String authId;
  const FormScreen({
    Key? key,
    required this.authId,
  }) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();
  DatabaseHelper _databaseHelper = DatabaseHelper();

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
                  "Create Your Task ",
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
                    mycontroller: _title,
                    validating: (val) {
                      return val!.isEmpty ? "Can't be empty" : null;
                    }),
                SizedBox(
                  height: 20,
                ),
                _customTextForm(
                    isStatus: true,
                    hintText: "Description",
                    mycontroller: _description,
                    validating: (val) {
                      return val!.isEmpty ? "Can't be empty" : null;
                    }),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton.icon(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          _databaseHelper.createUserData(
                              widget.authId, _title.text, _description.text);

                          Navigator.pop(context);
                        }
                      },
                      icon: Icon(
                        Icons.done,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Create",
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
