import 'dart:async';
import 'dart:math';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpdesk/user/database/Services.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
class verifcation extends StatefulWidget
{

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
  String  ?verfication;
  void initState() {
    super.initState();


  }
  @override

 user_verifcation() {

    services.expert_verfication(verfication.toString()).then((employees) {
      setState(() {

      });
      //_showProgress(widget.title);

    });

  }

  void showsnackbar()
  {
    bool dismiss=true;
    Flushbar(
      icon: Icon(Icons.error,color: Colors.white,),
      messageText: Text("are you sure your problem is solve ",style: TextStyle(color: Colors.white),),
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
              child: Text("YES",style: TextStyle(color: Colors.white),),
              onPressed:()
              {
                setState(() {

                });
              })
        ],
      ),
    );

  }
  void showsnackbar_user()
  {
    bool dismiss=true;
    Flushbar(
      icon: Icon(Icons.error,color: Colors.white,),
      messageText: Text("TANKS FOR YOU USING ",style: TextStyle(color: Colors.white),),
      borderRadius: 15,
      duration: Duration(seconds: 4),
      mainButton:
      Row(
        children: [
          FlatButton(
              child: Text("OK",style: TextStyle(color: Colors.white),),
              onPressed:()
              {
                setState(() {

                });
              })
        ],
      ),
    );

  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Help desk"),
        centerTitle: true,
      ),
      body: GestureDetector(

          child:
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child:  Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: 350),
                child:Column(
                  children: [
                    Center(
                      child: Text("VERIFICATION",style: TextStyle(fontSize: 30),),

                    ),
                    SizedBox(height: 20,),
                    Text("please enter the 4 digt code sende to "),
                    VerificationCode(
                        length: 4,
                        textStyle: TextStyle(fontSize: 20,color: Colors.black),
                        keyboardType: TextInputType.number,
                        underlineColor: Colors.black,
                        underlineUnfocusedColor: Colors.black,
                        onCompleted: (values)
                        {
                          setState(() {
                            verfication=values.toString();
                          });
                        },
                        onEditing: (values)
                        {
                          setState(() {

                          });
                        }
                    ),
                    FlatButton(child:Text("done",style: TextStyle(color: Colors.blue),),
                      onPressed: () async
                      {
                         user_verifcation();
                      },
                    ),
                  ],
                )
            ),
          )
      ),
    );
    throw UnimplementedError();
  }

}

