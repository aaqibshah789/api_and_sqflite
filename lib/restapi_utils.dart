import 'package:flutter/material.dart';
import 'package:apie_prectice/services.dart';
import 'package:lottie/lottie.dart';

class Restapi {
  //api production links
  static String type = "pro";
  static String ios_version_no = "1.0${type}"; // for update
  static String version_android = "1.0.0 ${type}"; //for update


//response statsus and messages
  static String error_400 = "oop there be some iisue in  plesase try again";
  static String error_401 = "un authorized";

  static String error_402 = "oops there seems to missing some values";
  static String error_404 = "oops there is some issue please try later";
  static String error_405 = "method not allowed";
  static String error_408 = " time out erroer plese try again later";
  static String error_500 = "internal erroer";
  static String error_501 = " you are not connected to internet ";
  static String error_default = "oop there be some iisue in  plesase try again";

  static String GetResponse(int status) {
    switch (status) {
      case 400:
        return error_400;
      case 401:
        return error_401;
      case 402:
        return error_402;
      case 404:
        return error_404;
      case 405:
        return error_405;
      case 408:
        return error_408;
      case 500:
        return error_500;
      case 501:
        return error_501;
      default:
        return error_default;
    }
  }

  static void GetHeaderBody(url, header, body) {
    GeneralPrintlog("BodyResponse", "url${url}");
    GeneralPrintlog("BodyResponse", "header${header}");
    GeneralPrintlog("BodyResponse", "body${body}");
  }
  static void GetResponseStatusBody(response){
    if(response!=null){
      GeneralPrintlog("BodyResponse", "response ${response.statusCode}: ${response.body}");
    }else{
      GeneralPrintlog("Body response", "response ${response}");

    }

    }
    static ShowLoadingView(BuildContext context,{String text="loading data"}){
    return Center(
      child: Container(
        width: 110,
        height: 110,
        decoration: BoxDecoration(
          color:Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              child: Lottie.asset("assets/jason/loading.json",width: 100),
            ),
            Text("$text",
              textAlign:TextAlign.center ,
            style: Theme.of(context).textTheme.subtitle2,
            )
          ],
        ),
      ),
    );
    }
  }
