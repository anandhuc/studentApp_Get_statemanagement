import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:studentdetails_getx/Pages/homepage.dart';
import 'package:get/get.dart';
import 'package:studentdetails_getx/controller/studentController.dart';
import 'package:studentdetails_getx/dbFunctions/student_adapter.dart';

void main()async  {
  
  await Hive.initFlutter();
  Hive.registerAdapter(RecordAdapter());
  await Hive.openBox<Record>('records');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
   build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      
      getPages: [
        GetPage(name: "/HomePage", 
        page: ()=> HomePage(), 
        binding: StudentBinding(),
        )
      ],
      initialRoute: "/HomePage",
    );
  
  }
}


