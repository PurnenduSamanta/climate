import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

    class NetworkHelper
    {
      String url;
      NetworkHelper(String url)
      {
        this.url=url;
      }
     Future getData() async
      {
        http.Response response = await http.get(Uri.parse(url));
        if(response.statusCode==200)
          {
             String data=response.body;
             var decodeData=jsonDecode(data);
             return decodeData;
          }
        else{
          Fluttertoast.showToast(
              msg: 'Status code ${response.statusCode.toString()}',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);

        }
      }
    }