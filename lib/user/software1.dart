
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:helpdesk/user/database/Services.dart';
import 'package:helpdesk/user/firstpage.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:helpdesk/user/generalfeedback.dart';
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
  String ?from_phonenumber;
  String listmessage="";
  String ?to_phonenuber;
  int one=0;
  List list=[];
  bool same=false;
  var firststring="";
  @override
  void initState() {
    super.initState();

    _employees = [];
    getfrom_phonenumber();
    _getEmployees();


  }
  getfrom_phonenumber ()async
  {

    final prefs = await SharedPreferences.getInstance();
    from_phonenumber= prefs.getString("phonenumber").toString();
  }


  getmessagelist() {

    services.getlistmessage(from_phonenumber.toString(),to_phonenuber.toString()).then((employees) {
      listmessage=services.message![0]['message_text'];
   one++;

     /* _employees!.map(
              (employee) =>Text(employee.firstName.toString()));*/
      list.add(listmessage);


    });
    print(list);
   return to_phonenuber;

  }

  _getEmployees() async{

    Services.getEmployees(widget.expertin.toString()).then((employees) {
      print("Length: ${employees.length}");
      count=employees.length;
      setState(() {

      });
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
    return   Scaffold(
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

          String fullname=Services.employees![index]['first_name'].toString()+ " "+Services.employees![index]['last_name'].toString();
          String imageexpert="http://10.0.2.2/helpdesk/${Services.employees![index]['image']}";
          String expertid=Services.employees![index]['expertid'].toString();
          String  phonenumber= Services.employees![index]['phonenumber'].toString();
          return  softwareexpert(fullname,imageexpert,expertid,phonenumber);
        },
      ) ,
      )
    );

    throw UnimplementedError();

  }

  softwareexpert(String fullname ,String imageexpert,String expertid,String phonenumber) {

      return
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.primaries[Random().nextInt(
                  Colors.primaries.length)],
              backgroundImage: NetworkImage(imageexpert),
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
            title: Text(fullname),
            subtitle: Text(phonenumber),
            onTap: () {
              setState(() async {
                bool values = await Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                        generalfeedback(expertid1:expertid)));
                if (values == true) {
                  _getEmployees();
                }
              });
            },

          ),
        );
    }


}
