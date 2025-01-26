import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategotywicseDoctors extends StatefulWidget{
  String category;
  CategotywicseDoctors({required String this.category});
  @override
  State<CategotywicseDoctors> createState() => _CategotywicseDoctorsState();
}

class _CategotywicseDoctorsState extends State<CategotywicseDoctors> {

  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryDoctor();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      body:
      _isLoading ? const CircularProgressIndicator() :
      Text(widget.category),
    );
  }

  void categoryDoctor() async{
    print("categoryDoctor callled");
    _isLoading=true;
    Uri uri = Uri.parse("https://easydoc.clotheeo.in/apis/doctors_categorywise.php");
    var response = await http.post(uri,body: jsonEncode({
      {
        "category":"Radiologist"
      }
    }));

    print('response;');
    print("Response ${response}");
    setState(() {
      _isLoading = false;
    });
  }

}