import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategotywicseDoctors extends StatefulWidget{
  String category;
  CategotywicseDoctors({required String this.category});
  @override
  State<CategotywicseDoctors> createState() => _CategotywicseDoctorsState();
}

class _CategotywicseDoctorsState extends State<CategotywicseDoctors> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      body: Text(widget.category),
    );
  }
  //
  // void categoryDo
  //
}