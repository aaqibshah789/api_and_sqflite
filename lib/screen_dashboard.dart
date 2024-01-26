import 'dart:html';
import 'package:apie_prectice/model_prayer.dart';
import 'package:apie_prectice/restapi_utils.dart';
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

  Future<List<ModelPrayer>>? _future;
  void initState() {
    super.initState();
    LoadData();

  }

  @override


  void LoadData() {

    setState(() {
      _future = Services.GetAllPrayers();
    });
    ModelPrayer modelPrayer=ModelPrayer(code: 200, status:"OK",data:[]);
    modelPrayer.data[DateTime.december].timings.fajr;
  }


  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(title: Text("${Restapi.ios_version_no}"
        "${Restapi.version_android}"),
        ),
        body: Container(
          alignment: Alignment.center,
          child: FutureBuilder(future:_future,
              builder:(Context, AsyncSnapshot<List<ModelPrayer>> snapshot){
            if(snapshot.connectionState== ConnectionState.waiting){
              return Restapi.ShowLoadingView(context);
            }else
              if(snapshot.hasError){
                return Center(
                  child: Text("${snapshot.error}")
                );
              }
              else
                if(snapshot.data!.length>0){
                 return ListView.builder(
                  itemCount:snapshot.data!.length,
                  itemBuilder: (context,index){
                   return ListTile(
                   title: Text(snapshot.data![index].data[DateTime.december].timings.fajr)
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



