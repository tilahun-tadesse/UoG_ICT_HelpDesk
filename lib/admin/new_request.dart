import 'package:flutter/material.dart';
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
import 'package:helpdesk/admin/database/admin_database/Employee.dart';
import 'package:helpdesk/admin/detail_request.dart';
class user_request extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return user_requeststate();
    throw UnimplementedError();
  }

}
class user_requeststate extends State<user_request>
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

    _getrequest();
  }

  _getrequest() {

    Services.getuser().then((employees) {
      setState(() {

      });
      print("Length: ${employees.length}");
      count=employees.length;

    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add,color: Colors.white,),
          onPressed: () async
          {

          },
        ),
        body:RefreshIndicator(
          onRefresh: ()
          async {
            await _getrequest();
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
                          "http://10.0.2.2/helpdesk/${Services.experts![index]['image']}"),
                    ),


                    trailing:
                    Container(
                      height: 20,
                      width: 20,
                      child: CircleAvatar(

                        backgroundColor: Colors.red,
                        child: Text("1"),
                      ),
                    ),
                    title: Text(Services.experts![index]['firstname'].toString()+ " "+Services.experts![index]['lastname'].toString()),
                    subtitle: Text(Services.experts![index]['phonenumber'].toString()),
                    onTap: ()
                    {
                      setState(() async {
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>detail(userid: Services.experts![index]['userid'].toString())));
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