import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpdesk/user/database/Services.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
class verifcation extends StatefulWidget
{
  String ?code;
  verifcation({required this.code});
  @override

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return verficationsate();
    throw UnimplementedError();
  }

}

class verficationsate extends State<verifcation>
{

  @override
  int timeleft=4;
 String ?_titleprogress;
  void initState() {
    super.initState();
   code.text=widget.code.toString();
  }
 TextEditingController code=TextEditingController();
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
                     Text("this is your expert verfication code give to expert "),
                    Container(
                        padding: EdgeInsets.only(left: 100,right: 200,),
                        child:  Center(
                          child: TextField(
                            enabled: false,
                            cursorWidth: 30,
                            controller:code ,
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
                              send_request("Sending_Text...........");
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

}

