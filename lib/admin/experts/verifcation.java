import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpdesk/user/database/Services.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
class verifcation extends StatefulWidget
{
String ?problem_catagory;
String ?problem_title;
String ?problme_priority;
String ?campus;
String ?building;
String ?room;
verifcation({required this.problem_catagory,this.problem_title,this.problme_priority,this.campus,this.building,this.room});
  @override

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return verficationsate();
    throw UnimplementedError();
  }

}

class verficationsate extends State<verifcation>
{
  String ?code;
  int timeleft=4;
  String ?_titleprogress;
  TextEditingController verfication=TextEditingController();
  void initState() {
    super.initState();
    codegenerate();

  }
  @override
  user_reqsuet()
  {

    print("phonenumber");
    services.userrequet(widget.problem_catagory.toString(),widget.problem_title.toString(),widget.problme_priority.toString(),widget.campus.toString(),
       widget.building.toString(),widget.room.toString(),code.toString()).then((employees) {
      setState(() {

      });
      print(services.message!.length);
    });

  }
  send_request(String message)
  {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if(timeleft>0)
      {
        setState(() {
          timeleft--;
          _titleprogress=message;
        });

      }
      else
      {
        timer.cancel();

      }
    });
  }
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
    
      appBar: AppBar(
        title: Text(timeleft==0||timeleft==4?"Help desk":_titleprogress.toString()),
        centerTitle: true,
      ),
      body: GestureDetector(

          child:
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child:  Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: 300,horizontal: 20),
                child:Column(
                  children: [
                    Center(
                      child: Text("VERIFICATION",style: TextStyle(fontSize: 30),),

                    ),
                    SizedBox(height: 20,),
                    Text("this is your verfication code please keep it in your mind or note book"),
                    Container(
                      padding: EdgeInsets.only(left: 100,right: 200,),
                      child:  Center(
                        child: TextField(
                          enabled: false,
                          cursorWidth: 30,
                          controller: verfication,
                        ),
                      )
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 30,left: 200),
                          child: FlatButton(
                            child: Text("Send_Text",style: TextStyle(color: Colors.blue),),
                            onPressed:()
                            {
                                send_request("Sending_Request...........");
                                user_reqsuet();
                            },
                          ),
                        )
                      ],
                    )
                  ],
                )
            ),
          )
      ),
    );
    throw UnimplementedError();
  }
  void codegenerate ()
  {
    code=Random().nextInt(10000).toString();
    verfication.text=code!;
  }

}

