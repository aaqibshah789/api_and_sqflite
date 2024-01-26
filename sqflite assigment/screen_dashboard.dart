import 'package:flutter/material.dart';
import 'package:precticeee/model_student.dart';


import 'database.dart';

class ScreenDashboard extends StatefulWidget {
  const ScreenDashboard({super.key});

  @override
  State<ScreenDashboard> createState() => _ScreenDashboardState();
}

class _ScreenDashboardState extends State<ScreenDashboard> {
   String id="";
   String name="";
   String rollnumber="";
  DatabaseStudent databaseStudent=DatabaseStudent();

  @override

  void initState(){
    super.initState();
    setState(() {
      databaseStudent.initializeDatabase();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add record"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              onChanged: (String value){
                setState(() {
                  id=value;
                  print("$id");
                });
              },
            ),
            SizedBox(height:20),
            TextFormField(
              onChanged: (String value){
                setState(() {
                  name=value;
                  print("$name");

                });
              },
            ),
            SizedBox(height: 20),
            Row(
              children: [
                TextButton(
                    onPressed: () async {
                     if(id.isNotEmpty) {
                       ModelStudent modelStudent = ModelStudent(
                           id: int.parse(id),
                           name: name,);
                       databaseStudent.updateStudent(modelStudent).then((
                           value) {
                         if (value) {
                           print("Record updated succcesfully");
                         } else {
                           print("RECORD updaton failed");
                         }
                       });
                     }else{
                       print("please provide id");
                     }
                     },
                child: Text("update record")),
                TextButton(
                    onPressed: () async{
                      ModelStudent modelStudent=ModelStudent(id: int.parse(id), name: name,);
                      databaseStudent.addStudent(modelStudent).then((bool isadded){
                        if(isadded){
                          print("Record added succcesfully");
                        }else{
                          print("RECORD add failed");
                        }
                      });
                    },
                    child: Text("Add record")),

              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                TextButton(
                    onPressed: ()async{
                      if(id.isNotEmpty) {

                        databaseStudent.deleteStudentById(id).then((
                            value) {
                          if (value) {
                            print("Record DEleted succcesfully");
                          } else {
                            print("RECORD deleteion  failed");
                          }
                        });
                      }else{
                        print("please provide id");
                      }
                    },
                    child: Text("DELETE SINGLE RECORD")),
                TextButton(
                    onPressed: () async{

                      databaseStudent.deleteAllStudents().then((bool isadded){
                        if(isadded){
                          print("DELETE ALL RECORDS succcesfully");
                        }else{
                          print("RECORD DELETIEION  failed");
                        }
                      });
                    },
                    child: Text("Delete all records")),

              ],
            ),
            SizedBox(height: 20),
          Row(
            children: [
              TextButton(
                  onPressed: ()async{
                    if(id.isNotEmpty) {

                      databaseStudent.getCountStudents().then((value) {
                          print(" total records = $value");
                      });
                    }else{
                      print("please provide id");
                    }
                  },
                  child: Text("Count  record")),
              TextButton(
                  onPressed: () async{
                       databaseStudent.getAllStudents().then((List<ModelStudent> list) {
                       list.forEach((element) {
                         print("id:${element.id},name:${name}");
                        });
                      });
                  },
                  child: Text("Display records")),

            ],

          ),
          ],
        ),

      ),
    );
  }
}
