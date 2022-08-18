import 'package:ahmed_sqflite_project/edit_notes.dart';
import 'package:ahmed_sqflite_project/sql_db.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDb sqlDb=SqlDb();
  List notes=[];
  bool isLoading=true;

  Future<void> readData()async{
    List<Map> response=await sqlDb.readData("SELECT * FROM 'notes'");
    notes.addAll(response);
    isLoading=false;
    if(this.mounted){
      setState(() {
      });
    }
  }
  @override
  void initState() {
    readData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed('addnotes');
        },
        child: Icon(Icons.add),
      ),
      body: isLoading==true ? const Center(child:Text('Loading......'))
      :Center(
        child: ListView(
          children: [
              ListView.builder(
                    itemCount: notes.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      return  Card(
                        child: ListTile(
                          title: Text('${notes[index]['title']}'),
                          subtitle: Text('${notes[index]['note']}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.delete,color: Colors.red,),
                                onPressed:()async{
                                  int response=await sqlDb.deleteData("DELETE FROM 'notes' WHERE id=${notes[index]['id']}");
                                  if(response>0){
                                    notes.removeWhere((element) => element['id']==notes[index]['id']);
                                    setState(() {});
                                  }
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.edit,color: Colors.blue,),
                                onPressed:(){
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context)=>EditNotes(
                                      note: notes[index]['note'],
                                      title: notes[index]['title'],
                                      color: notes[index]['color'],
                                      id: notes[index]['id'],
                                    )),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    )
          ]
        )
      )
    );

  }
}




//other method by futureBuilder but list view is best
/*
class _HomeState extends State<Home> {
  SqlDb sqlDb=SqlDb();

  Future<List<Map>> readData()async{
    List<Map> response=await sqlDb.readData("SELECT * FROM 'notes'");
    return response;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed('addnotes');
        },
        child: Icon(Icons.add),
      ),
      body: Center(
        child: ListView(
          children: [
            FutureBuilder(
              future: readData(),
              builder: (BuildContext context,AsyncSnapshot<List<Map>> snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      return  Card(
                        child: ListTile(
                          title: Text('${snapshot.data![index]['title']}'),
                          subtitle: Text('${snapshot.data![index]['note']}'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete,color: Colors.red,),
                            onPressed:()async{
                              int response=await sqlDb.deleteData("DELETE FROM 'notes' WHERE id=${snapshot.data![index]['id']}");
                              if(response>0){
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Home()));
                              }
                            },
                          ),
                        ),
                      );
                    });
                }
                return const Center(child:CircularProgressIndicator() ,);
                },
            ),
          ],
        ),
      ),
    );
  }
}
 */