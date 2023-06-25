import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_app/model/note_data.dart';
import 'package:note_app/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  //initialise hive
  await Hive.initFlutter();
  //open hive box
  await Hive.openBox('note_dataBase');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=> NoteData(), //changeNotifierProvider use for updating a perticular data in a node
      builder: (context,child) => const MaterialApp(       //of widget tree without rebuilding the whole widget tree
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
