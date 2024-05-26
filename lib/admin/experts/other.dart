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
class other extends StatefulWidget
{
  String ?expertin;
  other({required this.expertin});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return othersate();
    throw UnimplementedError();
  }

}
class othersate extends State<other>
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


    _getEmployees();
  }

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _getEmployees() {

    Services.getEmployees(widget.expertin.toString()).then((employees) {
      setState(() {
        _employees = employees;
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
            bool values=await Navigator.push(context, MaterialPageRoute(builder: (context)=>DataTableDemo(expertin: widget.expertin)));
            if(values==true)
            {
              _getEmployees();
            }
          },
        ),
        body:RefreshIndicator(
          onRefresh: ()
          async {
            await _getEmployees();
          },
          child: ListView.builder(
            itemCount: count,
            itemBuilder: (context,index)
            {
              return
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Card(
                    child: ListTile(

                      leading: CircleAvatar(
                        backgroundColor:Colors.primaries[Random().nextInt(Colors.primaries.length)] ,

                        backgroundImage: NetworkImage(
                            "http://10.0.2.2/helpdesk/${Services.employees![index]['image']}"),
                      ),


                      // trailing:
                      // IconButton(icon: Icon(Icons.edit,),
                      //
                      //     onPressed:() {
                      //       setState(() async {
                      //         bool values= await  Navigator.push(context, MaterialPageRoute(builder: (context) => editexpert(expertid1: Services.employees![index]['expertid'])));
                      //         if(values==true)
                      //         {
                      //           _getEmployees();
                      //
                      //         }
                      //       });
                      //     }
                      // ),
                      title: Text(Services.employees![index]['first_name'].toString()+ " "+Services.employees![index]['last_name'].toString()),
                      subtitle: Text(Services.employees![index]['phonenumber'].toString()),
                      onTap: ()
                      {
                        setState(() async {

                          bool values= await Navigator.push(context, MaterialPageRoute(builder: (context)=>editexpert(expertid1: Services.employees![index]['expertid'].toString(),curentimage: Services.employees![index]['image'].toString(),)));
                          if(values==true)
                          {
                            _getEmployees();
                          }
                        });
                      },
                    ),
                  ),
                );
            },
          ) ,
        )
    );
    throw UnimplementedError();
  }

}