import 'dart:math';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:helpdesk/user/user_verfication_code.dart';
import 'package:helpdesk/admin/database/admin_database/Services.dart';
import 'package:helpdesk/admin/database/admin_database/Employee.dart';
class detail extends StatefulWidget
{
  String ?userid;
  detail({required this.userid});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return detailstate();
    throw UnimplementedError();
  }

}
class detailstate extends State<detail>
{
  var catagory = ["Software","Harware","Network","other"];
  var curentcatagory = "Software";
  var priority=["EXTREME HIGH","HIGH","MEDIUM","LOW"];
  var currentpriority = "EXTREME HIGH";
  var campus = ["Atsetewdros", "Atsefasil", 'Maraci', 'Gc', 'Teda'];
  var currentcampuss = "Atsetewdros";
  var problem_id;
  var asigend_expert_phonenmuber;
  int ?code;
  TextEditingController roomnumber=TextEditingController();
  TextEditingController building_number=TextEditingController();
  TextEditingController probletitle=TextEditingController();
  List<Employee> ?_employees=[];
  void initState() {
    super.initState();
    _getrequest();

  }

  @override

  _getrequest() {

    Services.getrequest(widget.userid.toString()).then((employees) {
      setState(() {
        _employees = employees.cast<Employee>();
      });
      //_showProgress(widget.title);
      print("${Services.experts![0]['problem_priority']}");
      _setValues(Services.experts![0]['problem_catagory'],Services.experts![0]['probleme_title'],Services.experts![0]['problem_priority'],
          Services.experts![0]['campus'],Services.experts![0]['building'],Services.experts![0]['room'],Services.experts![0]['problem_id']);
      print("Length: ${employees.length}");


    });

  }
  _setValues(String _problem_catagory,String _problem_title,String _problem_priority,String _cumpas,String _building,String _room,String _problem_id) {
    curentcatagory=_problem_catagory;
    probletitle.text="yytyy";
    currentpriority=_problem_priority;
    currentcampuss=_cumpas;
    building_number.text=_building;
    roomnumber.text=_room;
    problem_id=_problem_id;
  }
  asigned_expert(String prolme_id,String asigned_expert_phonenumber) {
    print("helkocofahfaf");
    Services.asigned_expert(prolme_id,asigned_expert_phonenumber)
        .then((result) {
      if("success"==result)
      {

      }

    });
  }

  asign_expert()
  {
    Services.asign_expert(curentcatagory,currentcampuss).then((employees) {
      setState(() {
        _employees = employees.cast<Employee>();
      });

      code=Random().nextInt(Services.experts!.length);
      print("hellooooo");

     asigend_expert_phonenmuber=Services.experts![code!]['phonenumber'];
      asigned_expert(problem_id, asigend_expert_phonenmuber);
      if(Services.experts!.length>0)
        {
          showsnackbar();
        }
      else
        {
          showsnackbar_no();
        }

    });




  }
  void showsnackbar_no()
  {
    bool dismiss=true;
    Flushbar(
      icon: Icon(Icons.error,color: Colors.white,),
      messageText: Text("",style: TextStyle(color: Colors.white),),
      borderRadius: 15,
      duration: Duration(seconds: 4),
      mainButton:
      Row(
        children: [
          FlatButton(
              child: Text("calcel",style: TextStyle(color: Colors.white),),
              onPressed:()
              {

              }),
          FlatButton(
              child: Text("ok",style: TextStyle(color: Colors.white),),
              onPressed:()
              {

              })
        ],
      ),
      margin: EdgeInsets.only(top: 60,right: 10,left: 10),
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      flushbarPosition: FlushbarPosition.TOP,

    )..show(context);

  }
  void showsnackbar()
  {
    bool dismiss=true;
    Flushbar(
      icon: Icon(Icons.error,color: Colors.white,),
      messageText: Text("are you sure you want to asign expert",style: TextStyle(color: Colors.white),),
      borderRadius: 15,
      duration: Duration(seconds: 4),
      mainButton:
      Row(
        children: [
          FlatButton(
              child: Text("calcel",style: TextStyle(color: Colors.white),),
              onPressed:()
              {

              }),
          FlatButton(
              child: Text("ok",style: TextStyle(color: Colors.white),),
              onPressed:()
              {
                setState(() {
                  asign_expert();
                });
              })
        ],
      ),
      margin: EdgeInsets.only(top: 60,right: 10,left: 10),
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      flushbarPosition: FlushbarPosition.TOP,

    )..show(context);

  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
        appBar: AppBar(
          title:Text("Ask Help"),

        ),

        body: GestureDetector(
            child:
            Stack(
              children: [
                Expanded(child:
                Container(
                  padding: EdgeInsets.only(left: 30,right: 20,top: 40),
                  child:
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child:
                    Column(
                      children: [
                        Center(
                          child: Text("Fill The Following Information "),

                        ),
                        SizedBox(height: 30,),
                        Row(
                          children: [
                            Text("Problem catagory:"),
                            Expanded(
                                child: Container(
                                    padding:
                                    EdgeInsets.only(top: 10.0, left: 40),
                                    height: 50,
                                    width: 400,
                                    child: DropdownButton(
                                      items: catagory
                                          .map((String drop) =>
                                          DropdownMenuItem<String>(
                                              value: drop,
                                              child: Text(drop)))
                                          .toList(),
                                      onChanged: (var stat) {
                                        setState(() {
                                          curentcatagory = stat.toString();
                                        });
                                      },
                                      value: curentcatagory,
                                    )))
                          ],
                        ),
                        Row(
                          children: [
                            Text("problem title:",style: TextStyle(fontSize: 13.0),),
                            Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: 75.0,
                                  ),
                                  width: 400,
                                  height: 50.0,
                                  child: TextFormField(
                                      style: TextStyle(fontSize: 13.0),
                                      validator: (values) {
                                        if (values=="") {
                                          return "Enter correct name";
                                        }
                                        else {
                                          return null;
                                        }
                                      },
                                      controller: probletitle,
                                      decoration: InputDecoration(
                                        labelText: "problem title",

                                      )
                                  ),
                                )
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text("Problempriority:"),
                            Expanded(
                                child: Container(
                                    padding:
                                    EdgeInsets.only(top: 10.0, left: 50),
                                    height: 50,
                                    width: 400,
                                    child: DropdownButton(
                                      items: priority
                                          .map((String drop) =>
                                          DropdownMenuItem<String>(
                                              value: drop,
                                              child: Text(drop)))
                                          .toList(),
                                      onChanged: (var stat) {
                                        setState(() {
                                          currentpriority = stat.toString();
                                        });
                                      },
                                      value: currentpriority,
                                    )))
                          ],
                        ),
                        SizedBox(height: 20,),
                        Center(
                          child: Text("ADDRESS"),
                        ),
                        SizedBox(height: 30,),
                        Row(
                          children: [
                            Text("Campus:"),
                            Expanded(
                                child: Container(
                                    padding: EdgeInsets.only(
                                      left: 30.0,
                                    ),
                                    width: 400,
                                    height: 30.0,
                                    child: DropdownButton(
                                      items: campus
                                          .map((String drop) =>
                                          DropdownMenuItem(
                                              value: drop,
                                              child: Text(drop)))
                                          .toList(),
                                      onChanged: (var values) {
                                        setState(() {
                                          currentcampuss =
                                              values.toString();
                                        });
                                      },
                                      value: currentcampuss,
                                    )
                                )
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text("Building  :",style: TextStyle(fontSize: 13.0),),
                            Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: 30.0,
                                  ),
                                  width: 400,
                                  height: 50.0,
                                  child: TextFormField(
                                      keyboardType:TextInputType.number,
                                      style: TextStyle(fontSize: 13.0),
                                      validator: (values) {
                                        if (values=="") {
                                          return "Enter correct Input";
                                        }
                                        else {
                                          return null;
                                        }
                                      },
                                      controller: building_number,
                                      decoration: InputDecoration(
                                        labelText: "Building number ",

                                      )
                                  ),
                                ))
                          ],
                        ),
                        Row(
                          children: [
                            Text("Room  :",style: TextStyle(fontSize: 13.0),),
                            Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: 40.0,
                                  ),
                                  width: 400,
                                  height: 50.0,
                                  child: TextFormField(
                                      style: TextStyle(fontSize: 13.0),
                                      validator: (values) {
                                        if (values=="") {
                                          return "Enter correct input";
                                        }
                                        else {
                                          return null;
                                        }
                                      },
                                      controller: roomnumber,
                                      decoration: InputDecoration(
                                        labelText: "Room number ",

                                      )
                                  ),
                                )
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 20,left: 50),
                       child:  FlatButton(onPressed:()
                       {
                                 asign_expert();
                       },
                           child:Text("asign_expert",style: TextStyle(color: Colors.blue,fontSize: 15),)
                       ),
                        )
                      ],
                    ),
                  ),
                ),
                ),
              ],

            )
        )

    );
    throw UnimplementedError();
  }
}