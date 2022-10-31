
import 'package:hive/hive.dart';
import 'package:studentdetails_getx/dbFunctions/student_adapter.dart';



class Boxes {
  static Box<Record>? _box;

  static Box<Record> getInstance() {
    return _box ??= Hive.box('records');
  }
}
