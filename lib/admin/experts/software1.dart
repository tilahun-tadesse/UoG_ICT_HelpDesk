
import 'package:flutter/material.dart';
//import 'package:/database/note.dart';
//import 'package:helpdesk/admin/software/newexpert.dart';
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

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class software extends StatefulWidget
{
  String ?expertin;
  software({required this.expertin});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return softwarestate();
    throw UnimplementedError();
  }

}
class softwarestate extends State<software>
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
      print("helo world");
      count=Services.employees!.length;

    });
  }

  /*_setValues(Employee employee) {
    firstname.text = employee.firstName.toString();
    lastname.text= employee.lastName.toString();
    gender=employee.gender.toString();
    setState(() {
      _isUpdating = true;
    });
  }*/


  Widget build(BuildContext context) {
    // TODO: implement buildreturn
    return
      Scaffold(
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
      body:
      ModalProgressHUD(
        inAsyncCall: Services.updating,
        child:  RefreshIndicator(
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
                    child:
                    InkWell(
                      child:
                      ListTile(

                        leading: CircleAvatar(
                          backgroundColor:Colors.primaries[Random().nextInt(Colors.primaries.length)] ,

                          backgroundImage: NetworkImage(
                             '${Services.employees![index]['image'].toString()}' ),
                        ),


                        /*trailing:
                        IconButton(icon: Icon(Icons.edit,),

                            onPressed:() {
                              setState(() async {
                                bool values= await  Navigator.push(context, MaterialPageRoute(builder: (context) => editexpert(expertid1: Services.employees![index]['expertid'])));
                                if(values==true)
                                {
                                  _getEmployees();

                                }
                              });
                            }
                        ),*/
                        title: Text(Services.employees![index]['firstName'].toString()+ " "+Services.employees![index]['lastName'].toString()),
                        subtitle: Text(Services.employees![index]['phonenumber'].toString()),
                        onTap: ()
                        {
                          setState(() async {

                            curentexpertid= await Services.employees![index]['expertid'];
                            bool values= await Navigator.push(context, MaterialPageRoute(builder: (context)=>editexpert(expertid1: curentexpertid.toString(),curentimage: Services.employees![index]['image'].toString(),)));
                            if(values==true)
                            {
                              _getEmployees();
                            }
                          });
                        },
                      ),
                    )
                );
            },
          ) ,
        ),
      )

    );

    throw UnimplementedError();

  }



}