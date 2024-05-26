import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:helpdesk/main.dart';
import 'package:helpdesk/user/database/Employee.dart';
import 'package:helpdesk/expert/expert_home.dart';
import 'package:helpdesk/user/database/Services.dart';
class expert_verifcation extends StatefulWidget
{
  String ?phonenumber;
  expert_verifcation({required this.phonenumber});
  expert_verifcation.one({Key? key}) : super(key: key);
  @override

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return expert_verficationsate();
    throw UnimplementedError();
  }

}


class expert_verficationsate extends State<expert_verifcation>
{
  String ?code;
  List<String> recipient=["0960744133"];
  @override
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
                    Text("please enter the 4 digt code that given from your admin "),
                    VerificationCode(
                        length: 4,
                        textStyle: TextStyle(fontSize: 20,color: Colors.black),
                        keyboardType: TextInputType.number,
                        underlineColor: Colors.black,
                        underlineUnfocusedColor: Colors.black,
                        onCompleted: (values)
                        {
                          setState(() {

                          });
                        },
                        onEditing: (values)
                        {
                          setState(() {

                          });
                        }
                    ),
                    FlatButton(child:Text("send_SMS",style: TextStyle(color: Colors.blue),),
                      onPressed: () async
                      {
                        //codegenerate();
                        String phonenumber=widget.phonenumber.toString();
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool('isLoggedIn', true);
                        prefs.setString('phonenumber', '$phonenumber');
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: ((context) => experthome())));
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
  void codegenerate ()
  {
    code=Random().nextInt(10000).toString();
  }
  sendsms(String message ,List<String> recipient) async
  {
    String resullt=await sendSMS(message: message, recipients: recipient)
        .catchError((onError){
      print(onError);
    });
    print(resullt);
  }

}

