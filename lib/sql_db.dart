import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb{
  static Database? _db;

  Future<Database?> get db async{
    if(_db==null){
      _db= await initialDb();
      return _db;
    }else{
      return _db;
    }
  }

  initialDb()async{
    String databasePath= await getDatabasesPath();
    String path= join(databasePath,'ahmedabdraboo.db');
    Database myDb= await openDatabase(path,onCreate: _onCreate,version: 5,onUpgrade: _onUpgrade);
    return myDb;
  }

  _onUpgrade(Database db,int oldVertion,int newVertion)async{
    await db.execute("ALTER TABLE notes ADD COLUMN color TEXT");
    print('Upgraded');
  }
  _onCreate(Database db,int vertion)async{
    //if i need to add more than one table use batch
    Batch batch=db.batch();
    batch.execute('''
  CREATE TABLE "notes" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
    "title" TEXT NOT NULL,
    "note" TEXT NOT NULL
  )
 ''') ;
    batch.execute('''
  CREATE TABLE "students" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
    "title" TEXT NOT NULL,
    "note" TEXT NOT NULL
  )
 ''') ;
    await batch.commit();
    print('OnCreated');
  }

  //select
  readData(String sql)async{
    Database? myDb=await db;
    List<Map> response=await myDb!.rawQuery(sql);
    return response;
  }

  //insert
  insertData(String sql)async{
    Database? myDb=await db;
    int response=await myDb!.rawInsert(sql);
    return response;
  }

  //update
  updateData(String sql)async{
    Database? myDb=await db;
    int response=await myDb!.rawUpdate(sql);
    return response;
  }

  //delete
  deleteData(String sql)async{
    Database? myDb=await db;
    int response=await myDb!.rawDelete(sql);
    return response;
  }

  //delete database
  removeDatabase()async{
    String databasePath= await getDatabasesPath();
    String path= join(databasePath,'ahmedabdraboo.db');
    await deleteDatabase(path);
  }


}