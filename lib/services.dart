import 'package:apie_prectice/cats.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:apie_prectice/services.dart';


class Services{
   static var  client=http.Client();

  static Future<List<Cats>>  GetAllCats() async {
     List<Cats> list=[];
  String stringurl="https://freetestapi.com/api/v1/cats";
  Uri Uri_url=Uri.parse(stringurl);
  client.get(Uri_url);
  Response response= await client.get(Uri_url);
  if(response.statusCode==200){

     list = catsFromMap(response.body);
  }
  return list;
}
}