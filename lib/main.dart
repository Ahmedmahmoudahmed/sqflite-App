import 'package:ahmed_sqflite_project/add_note.dart';
import 'package:ahmed_sqflite_project/sql_db.dart';
import 'package:flutter/material.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:const Home(),
      routes: {"addnotes":(context)=>AddNotes()},
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  SqlDb sqlDb=SqlDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SqlFLite App'),
        backgroundColor: Colors.lightBlue,
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Center(
              child: MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                onPressed: ()async{
                  int response= await sqlDb.insertData("INSERT INTO 'notes' ('note','title') VALUES ('note two','ahmed')");
                  print(response);
                },
                child: const Text('Insert Data'),
              ),
            ),
            Center(
              child: MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                onPressed: ()async{
                  List<Map> response= await sqlDb.readData("SELECT * FROM 'notes'");
                  print("$response");
                },
                child: Text('Read Data'),
              ),
            ),
            Center(
              child: MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                onPressed: ()async{
                  int response= await sqlDb.deleteData("DELETE FROM 'notes' WHERE id=3");
                  print("$response");
                },
                child: Text('Delete Data'),
              ),
            ),
            Center(
              child: MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                onPressed: ()async{
                  int response= await sqlDb.updateData("UPDATE 'notes' SET 'note'='note two' WHERE id=2");
                  print("$response");
                },
                child: Text('Update Data'),
              ),
            ),
            Center(
              child: MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                onPressed: ()async{
                   await sqlDb.removeDatabase();
                   },
                child: Text('Delete Database'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
