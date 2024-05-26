import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:helpdesk/user/generalfeedback.dart';
import 'package:helpdesk/expert/database/Services.dart';
import 'package:helpdesk/expert/database/Employee.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:helpdesk/expert/detail_request.dart';
class admin_feedback extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return admin_feedbackstate();
    throw UnimplementedError();
  }

}
class admin_feedbackstate  extends  State<admin_feedback>
{
  GlobalKey<ScaffoldState> ?_scafoldkey;
  int count =0;
  String ?_titleProgress;
  String ?curentexpertid;
  var phonenumber;
  Future<File> ?file;
  var firststring="";
  @override
  void initState() {
    super.initState();
    _getfeedback();
  }

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _getfeedback() async {
    final prefs = await SharedPreferences.getInstance();
    phonenumber= prefs.getString("phonenumber");
    print('${phonenumber}');
    services.getrequest(phonenumber.toString()).then((employees) {
      setState(() {

      });
      print("Length: ${employees.length}");
      count=services.experts!.length;

    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

        body:RefreshIndicator(
          onRefresh: ()
          async {
            await _getfeedback();
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
                          "http://10.0.2.2/helpdesk/${services.experts![index]['image']}"),
                    ),


                    trailing:

                    Container(child: CircleAvatar(backgroundColor:Colors.red,radius:10,child: Text("1",style: TextStyle(color: Colors.white),),),),

                    title: Text(services.experts![index]['firstname'].toString()+ " "+services.experts![index]['lastname'].toString()),
                    subtitle: Text(services.experts![index]['phonenumber'].toString()),
                    onTap: ()
                    {
                      setState(() async {

                        bool values= await Navigator.push(context, MaterialPageRoute(builder: (context)=>detail(problem_id: services.experts![index]['phonenumber'].toString())));
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