import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:studentdetails_getx/controller/studentController.dart';
import 'package:studentdetails_getx/dbFunctions/box_instance.dart';
import 'package:studentdetails_getx/dbFunctions/student_adapter.dart';


class UpdateRecord extends StatelessWidget {
  UpdateRecord({Key? key, required this.student}) : super(key: key);

  Record student;
  Box<Record> box = Boxes.getInstance();
  final formkey = GlobalKey<FormState>();
  final studentController = Get.find<StudentController>();
  @override
  Widget build(BuildContext context) {
    Record? record = box.get(student.key);
    return AlertDialog(
      title: Text(
        "Edit Student Detials",
        style: GoogleFonts.rubik(
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
      ),
      content: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 8),
              buildName(record!),
              const SizedBox(height: 8),
              buildAge(record),
              const SizedBox(height: 8),
              buildPlace(record),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        cancelButton(),
        submitButton(record),
      ],
    );
  }

  Widget buildAge(Record record) => TextFormField(
        initialValue: student.age.toString(),
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Student Age',
        ),
        validator: (value) {
          if (value == "") {
            return "Student Age required";
          }
        },
        onChanged: (value) {
          if (value.isNotEmpty) {
            record.age = int.parse(value);
          }
        },
      );

  Widget buildName(Record record) => TextFormField(
        initialValue: student.title,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Student Name',
        ),
        validator: (value) {
          if (value == "") {
            return "Student Name required";
          }
        },
        onChanged: (value) {
          record.title = value;
        },
      );

  Widget buildPlace(Record record) => TextFormField(
        initialValue: student.place,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Student Place',
        ),
        validator: (value) {
          if (value == "") {
            return "Student Place required";
          }
        },
        onChanged: (value) {
          record.place = value;
        },
      );

  Widget cancelButton() => TextButton(
        child: const Text(
          'Cancel',
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () => Get.back(),
      );
  Widget submitButton(Record record) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[200],
        ),
        onPressed: () {
          if (formkey.currentState!.validate()) {
            record.save();
            studentController.update();
            Get.back();
          }
        },
        child: const Text(
          'Save',
          style: TextStyle(color: Colors.black),
        ),
      );
}
