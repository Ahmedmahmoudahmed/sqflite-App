import 'package:ahmed_sqflite_project/home.dart';
import 'package:ahmed_sqflite_project/sql_db.dart';
import 'package:flutter/material.dart';

class EditNotes extends StatefulWidget {
  final note;
  final title;
  final id;
  final color;
  const EditNotes({Key? key, this.note, this.title, this.id, this.color}) : super(key: key);

  @override
  _EditNotesState createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  SqlDb sqlDb=SqlDb();
  GlobalKey<FormState> formState=GlobalKey();
  TextEditingController note =TextEditingController();
  TextEditingController title =TextEditingController();
  TextEditingController color =TextEditingController();

  @override
  void initState() {
    note.text=widget.note;
    title.text=widget.title;
    color.text=widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Notes'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
              key: formState,
              child: Column(
                children: [
                  TextFormField(
                    controller: note,
                    decoration:  InputDecoration(hintText: 'note',),
                  ),
                  TextFormField(
                    controller: title,
                    decoration: InputDecoration(hintText: 'title',),
                  ),
                  TextFormField(
                    controller: color,
                    decoration: InputDecoration(hintText: 'color',),
                  ),
                  Container(height: 20,),
                  MaterialButton(
                    onPressed: ()async{
                      int response=await sqlDb.updateData(
                          '''
                            UPDATE 'notes' SET
                             note="${note.text}",
                             title="${title.text}",
                             color="${color.text}"
                             WHERE id=${widget.id}
                          '''
                      );
                      if(response>0){
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home()), (route) => false);
                      }
                    },
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text('Edit Note'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
