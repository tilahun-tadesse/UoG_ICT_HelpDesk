import 'package:flutter/material.dart';
import 'package:helpdesk/user/user_verfication_code.dart';
import'package:helpdesk/user/database/Services.dart';
class ask extends StatefulWidget
{
  String ?userid;
  ask({required this.userid});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return askstate();
    throw UnimplementedError();
  }

}
class askstate extends State<ask>
{
  var catagory = ["Software","Harware","Network","other"];
  var curentcatagory = "Software";
  var priority=["EXTREME HIGH","HIGH","MEDIUM","LOW"];
  var currentpriority = "EXTREME HIGH";
  var campus = ["Atsetewdros", "Atsefasil", 'Maraci', 'Gc', 'Teda'];
  var currentcampuss = "Atsetewdros";
  TextEditingController roomnumber=TextEditingController();
  TextEditingController building_number=TextEditingController();
  TextEditingController probletitle=TextEditingController();

  @override


  Widget build(BuildContext context) {
    // TODO: implement build
  return  Scaffold(
      appBar: AppBar(
        title:Text("Ask Help"),

      ),
      floatingActionButton: FloatingActionButton(
        child:Icon(Icons.arrow_forward) ,
        onPressed: ()async
        {
print(widget.userid.toString());
          Navigator.push(context, MaterialPageRoute(builder: (context)=>verifcation(
            problem_catagory: curentcatagory.toString(),
          problem_title:probletitle.text ,
          problme_priority:currentpriority ,
          campus:currentcampuss ,
          building: building_number.text,
          room: roomnumber.text,
          userid: widget.userid.toString(),)));
        },
      ),
      body: GestureDetector(
        child:
        Stack(
          children: [
            Expanded(child:
            Container(
              padding: EdgeInsets.only(left: 30,right: 20,top: 20),
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