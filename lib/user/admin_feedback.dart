import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:helpdesk/admin/database/newexpert1.dart';
import 'package:helpdesk/admin/database/Services.dart';
import 'package:helpdesk/admin/database/Employee.dart';
import 'package:helpdesk/admin/database/editexpert.dart';
import 'dart:math';
import 'package:helpdesk/user/adim_message.dart';

class admin_feedback extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return admin_feedbackstate();
    throw UnimplementedError();
  }

}
class admin_feedbackstate extends State<admin_feedback>
{
  List<Employee> ?_employees=[];
  GlobalKey<ScaffoldState> ?_scafoldkey;
  int count =0;
  String ?_titleProgress;
  String ?curentexpertid;
  Future<File> ?file;
  var firststring="";
  @override
  void initState() {
    super.initState();
    _employees = [];

  }

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body:RefreshIndicator(
          onRefresh: ()
          async {

          },
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context,index)
            {
              return
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: ListTile(

                    leading: CircleAvatar(
                      backgroundColor:Colors.primaries[Random().nextInt(Colors.primaries.length)] ,

                    ),


                    trailing:
                    Container(
                      height: 20,
                      width: 20,
                      child: CircleAvatar(

                        backgroundColor: Colors.red,
                        child: Text("2"),
                      ),
                    ),
                    title: Text("ADMIN"),
                    subtitle: Text(""),
                    onTap: ()
                    {
                      setState(() async {

                        bool values= await Navigator.push(context, MaterialPageRoute(builder: (context)=>admin_message()));
                        if(values==true)
                        {

                        }
                      });
                    },

                  ),
                );
            },
          ) ,
        )
    );
    throw UnimplementedError();
  }

}