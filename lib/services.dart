import 'dart:async';
import 'dart:io';
import 'package:apie_prectice/model_prayer.dart';
import 'package:apie_prectice/restapi_utils.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:apie_prectice/services.dart';

GeneralPrintlog(String key, String value){
  print("$key=$value");
}
class Services{
   static var  client=http.Client();

  static Future<List<ModelPrayer>>  GetAllPrayers() async {
     List<ModelPrayer> modelPrayer=[];
     try {
       String stringurl = "http://api.aladhan.com/v1/calendar/2019?latitude=51.508515&longitude=-0.1254872&method=2";
       Uri Uri_url = Uri.parse(stringurl);
       Map body={};
       Map header={};
       client.get(Uri_url);
       Response response = await client.get(Uri_url);
       if (response.statusCode == 200) {
         final modelPrayer = modelPrayerFromMap(response.body);
         print("body printed succesfuly");
       }
       else{
       GeneralPrintlog("asdg", Restapi.GetResponse(response.statusCode));
       }
     }on TimeoutException{
       GeneralPrintlog("TimeoutException", "timeouterror");

     }on SocketException{
       GeneralPrintlog("TimeoutException", "internet connecrion error ");
     }catch (ex){
       GeneralPrintlog("TimeoutException", "${ex.toString()}");

     }
  return modelPrayer;
  }
}