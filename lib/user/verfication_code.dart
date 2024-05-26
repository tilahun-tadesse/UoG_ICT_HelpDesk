
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:helpdesk/user/userhome.dart';
import 'package:helpdesk/main.dart';
import 'package:helpdesk/user/database/Services.dart';
import 'package:helpdesk/user/database/Employee.dart';
import 'dart:io';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class verifcation extends StatefulWidget
{
 String ?phonenumber;
 String ?firstname;
 String ?lastname;

  verifcation({required this.phonenumber,required this.firstname,required this.lastname});
  verifcation.one({Key? key}) : super(key: key);
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
  _adduser(String firstname,String lastname,phonenumber,image)
  {
    services.addEmployee(firstname, lastname, phonenumber, image).then((result) {

      if("succes"==result)
      {
         setState(() {

         });
      }
      else
      {
            setState(() {

            });
      }
    });
  }

  List<String> recipient=["0960744133"];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Help desk"),
        centerTitle: false,
      ),
      body:
      ModalProgressHUD(
        inAsyncCall: false,
        child:
      GestureDetector(

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
                   String firstname=widget.firstname.toString();
                   String latname=widget.lastname.toString();
                   String image="";
                   _adduser(firstname, latname, phonenumber, image);
                   final prefs = await SharedPreferences.getInstance();
                     prefs.setBool('isLoggedIn', true);
                     prefs.setString('phonenumber', '$phonenumber');
                     String? phonennumber='';
                     phonennumber= prefs.getString("phonenumber");
                     print("abebebebeb");
                     print(phonennumber);
                     Navigator.pushReplacement(context,
                         MaterialPageRoute(builder: ((context) => userhome())));



                 },
               ),
             ],
           )
       ),
      )
      ),
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

