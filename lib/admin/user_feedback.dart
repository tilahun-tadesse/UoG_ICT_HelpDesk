import 'package:flutter/material.dart';
import 'package:helpdesk/expert/user_feedback.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:helpdesk/admin/database/editexpert.dart';
import 'dart:math';
import 'package:helpdesk/user/generalfeedback.dart';
import 'package:helpdesk/admin/database/admin_database/Services.dart';
import 'package:helpdesk/admin/user_message.dart';
class user_feedback extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return user_feedbackstate();
    throw UnimplementedError();
  }

}
class user_feedbackstate extends State<user_feedback>
{

  GlobalKey<ScaffoldState> ?_scafoldkey;
  int count =0;
  String ?_titleProgress;
  String ?curentexpertid;
  Future<File> ?file;
  var firststring="";
  @override
  void initState() {
    super.initState();
    _get_user_feedback();
  }

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _get_user_feedback() {

    Services.getuserfeedback().then((employees) {
      setState(() {

      });
      print("Length: ${employees.length}");
      count=Services.userfeedback!.length;;

    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

        body:RefreshIndicator(
          onRefresh: ()
          async {
            await _get_user_feedback();
          },
          child: ListView.builder(
            itemCount: count,
            itemBuilder: (context,index)
            {
              return
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: ListTile(

                    leading: CircleAvatar(
                      backgroundColor:Colors.primaries[Random().nextInt(Colors.primaries.length)] ,

                      backgroundImage: NetworkImage(
                          "http://10.0.2.2/helpdesk/${Services.userfeedback![index]['image']}"),
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
                    title: Text(Services.userfeedback![index]['firstname'].toString()+ " "+Services.userfeedback![index]['lastname'].toString()),
                    subtitle: Text(Services.userfeedback![index]['phonenumber'].toString()),
                    onTap: ()
                    {
                      setState(() async {

                        bool values= await Navigator.push(context, MaterialPageRoute(builder: (context)=>user_message(expertid1: Services.userfeedback![index]['userid'].toString())));
                        if(values==true)
                        {
                         _get_user_feedback();
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