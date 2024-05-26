import 'package:flutter/material.dart';
import 'package:helpdesk/expert/expert_home.dart';
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
import 'package:helpdesk/expert/user_messages.dart';
class user_feedback extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return user_feedbackstate();
    throw UnimplementedError();
  }

}
class user_feedbackstate  extends  State<user_feedback>
{
  GlobalKey<ScaffoldState> ?_scafoldkey;
  int count =0;
  String ?_titleProgress;
  String ?curentexpertid;
  var phonenumber;
  Future<File> ?file;
  var firststring="";
  var message=0;
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

    services.get_user_feedback(phonenumber.toString()).then((employees) {
      if(mounted) {
        setState(() {

        });
        print("Length: ${employees.length}");
        count = services.feedback!.length;
      }
    });
  }
  number_newmessage(String from_number){
    phonenumber='0949311213';
    print('${phonenumber}');
    services.number_newmessage(from_number.toString(),phonenumber).then((employees) {
      if(mounted) {
        setState(() {

        });
        print("Length: ${employees.length}");
        message = services.newmessage!.length;
      }

    });
return services.newmessage!.length.toString();
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
             // List<String> phonenumber =[];
             // if(!phonenumber.asMap().containsValue());

              return
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: ListTile(

                    leading: CircleAvatar(
                      backgroundColor:Colors.primaries[Random().nextInt(Colors.primaries.length)] ,
                      backgroundImage: NetworkImage(
                          "http://10.0.2.2/helpdesk/${services.feedback![index]['image']}"),
                    ),

                    trailing:

                    Container(child: CircleAvatar(backgroundColor:Colors.red,radius:10,child: Text( number_newmessage(services.feedback![index]['phonenumber'].toString()),style: TextStyle(color: Colors.white),),),),

                    title: Text(services.feedback![index]['firstname'].toString()+ " "+services.feedback![index]['lastname'].toString()),
                    subtitle: Text(services.feedback![index]['phonenumber'].toString()),
                    onTap: ()
                    {
                      setState(() async {
                        bool values= await Navigator.push(context, MaterialPageRoute(builder: (context)=>userfeedback(expertid1: services.feedback![index]['userid'].toString())));
                        values=true;
                        if(values==true)
                        {

                            _getfeedback();
                             experthomestate ob=new experthomestate();
                             ob.alluserfeedback;

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