import 'package:flutter/material.dart';
import 'package:helpdesk/expert/expert_verfication_code.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:helpdesk/user/verfication_code.dart';
import 'package:helpdesk/user/userhome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:helpdesk/expert/expert_login.dart';
class expert extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return expertstate();
    throw UnimplementedError();
  }

}
class expertstate extends State<expert>
{
  TextEditingController firstname=TextEditingController();
  TextEditingController lastname=TextEditingController();
  bool gett=true;
  String ?phonenumber;
  var formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(child:
    Scaffold(
        appBar: AppBar(
          title: Text("helpdesk"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          child:Icon(Icons.arrow_forward) ,
          onPressed: ()async
          {
            final prefs = await SharedPreferences.getInstance();
            prefs.setBool('isLoggedIn', true);

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) => expert_verifcation(phonenumber: phonenumber))));

          },
        ),
        body:

        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:  GestureDetector(
            child: Container(
              padding: EdgeInsets.only(left: 30,right: 30,top: 20),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    Image(image: AssetImage("image/helpdesk.png"),
                    ),
                    TextFormField(
                      controller: firstname,
                      decoration: InputDecoration(
                          label: Text("firstname"),
                          border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )


                      ),
                    ),
                    SizedBox(height: 30,),
                    TextFormField(
                      controller: lastname,
                      decoration: InputDecoration(
                          label: Text("lastname"),
                          border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )

                      ),
                    ),
                    SizedBox(height: 30,),
                    IntlPhoneField(
                      initialCountryCode: "ET",

                      decoration: const InputDecoration(

                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      onChanged: (phone) {
                        phonenumber=phone.completeNumber.toString();
                      },
                      onCountryChanged: (country) {
                        print('Country changed to: ' + country.name);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
    ),
      onWillPop: ()async
      {
        // SystemNavigator.pop();
        return true;
      },
    );
    throw UnimplementedError();
  }

}