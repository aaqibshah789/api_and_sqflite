import 'package:apie_prectice/cats.dart';
import 'package:apie_prectice/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:apie_prectice/screen_dashboard.dart';


class ScreenDashboard extends StatefulWidget {
  const ScreenDashboard({super.key});

  @override
  State<ScreenDashboard> createState() => _ScreenDashboardState();
}

class _ScreenDashboardState extends State<ScreenDashboard> {

  Future<List<Cats>>? _future;

  @override
  void initState() {
    super.initState();
    LoadData();
  }

  void LoadData() {
    setState(() {
      _future = Services.GetAllCats();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          alignment: Alignment.center,
          child: FutureBuilder(future:_future,
              builder:(Context, AsyncSnapshot<List<Cats>> snapshot){
            if(snapshot.connectionState== ConnectionState.waiting){
              return CircularProgressIndicator();
            }else
              if(snapshot.hasError){
                return Center(
                  child: Text("${snapshot.error.toString()}")
                );
              }
              else
                if(snapshot.data!.length>0){
                 return ListView.builder(
                  itemCount:snapshot.data!.length,
                  itemBuilder: (context,index){
                   return ListTile(
                   title: Text("${snapshot.data![index].name}"
                       "${snapshot.data![index].colors}")
                   );
                  });
                }
                else
                  {
                    return Center(
                      child: Text("SOORY NO RECORD FOUND"),
                    );
                  }

        },

          )));
  }
}
//ListView.builder(
//itemCount:cats.length,
//itemBuilder: (context,index){
//return ListTile(
//title: Text("${cats[index].name}")
//);

//}
//)

