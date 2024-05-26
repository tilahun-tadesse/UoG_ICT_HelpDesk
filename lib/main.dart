import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helpdesk/admin/database/newexpert1.dart';
import 'package:helpdesk/admin/experts/software1.dart';
//import 'package:helpdesk/admin/database/DataTableDemo.dart';
//import 'package:helpdesk/dataTable.dart';
//import 'package:helpdesk/datademo.dart';
//import 'package:helpdesk/admin.dart';

import 'package:helpdesk/admin/adminhome.dart';
import 'package:helpdesk/expert/expert_home.dart';
import 'package:helpdesk/topbar.dart';
//import 'package:untitled/admin/adminhome.dart';
//import 'package:untitled/admin/newexepert.dart';
//import 'package:untitled/admin/software/newexpert.dart';
//import 'package:helpdesk/admin/software/newexpert1.dart';
import 'package:helpdesk/user/firstpage.dart';
import 'package:helpdesk/user/userhome.dart';
import 'package:helpdesk/user/verfication_code.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:helpdesk/expert/expert_login.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(MyApp(isLoggedIn: isLoggedIn));
}
class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "help desk",
      debugShowCheckedModeBanner: false,
      home:user(), //isLoggedIn ? const experthome() : expert(),
    );
    throw UnimplementedError();
  }
}

class home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homestate() ;
    throw UnimplementedError();
  }
}

class homestate extends State<home> {
  bool isRememeberMe=true;
  TextEditingController username=TextEditingController();
  TextEditingController password=TextEditingController();
  bool ischeck=false;
  bool isshow=true;
  void shared()async
  {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
  @override
  void initstate()
  {
    super.initState();
    shared();
  }
  Widget build(BuildContext context) {

    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text("help desk"
        ),

      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0x6600cc99),
                          Color(0x9900cc99),
                          Color(0xCC00cc99),
                          Color(0xff00cc99),


                        ]
                    )
                ),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 60.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("signin", style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      SizedBox(height: 60.0),
                      emailbuilde(),
                      SizedBox(height: 20.0),
                      passwordbuilde(),

                      forgetpassword(),
                      checkbox(),
                      loginbutton(),
                      singin(),

                    ],
                  ),
                ),

              )
            ],
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }

  Widget emailbuilde() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text("Email", style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
        ),
        SizedBox(height: 20.0,),
        Container(
          alignment: Alignment.centerLeft,

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),

          ),
          height: 60.0,
          child: TextField(
            controller: username,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(

              color: Colors.black87,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.green,
              ),
              hintText: "tilahuntadesse@gmail.com",
              hintStyle: TextStyle(
                color: Colors.black26,
              ),
              labelText: 'Email',
            ),
          ),

        )
      ],
    );
  }

  Widget passwordbuilde() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("password", style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          ),
        ),
        SizedBox(height: 20.0,),
        Container(
          alignment: Alignment.centerLeft,

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),

          ),
          height: 60.0,
          child: TextField(
            controller: password,
            obscureText:isshow,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(

              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.green,
              ),
              suffixIcon: GestureDetector(
                  onTap: ()
                  {
                    setState(() {
                      isshow=!isshow;
                    });

                  },
                child: Icon(
                isshow?Icons.visibility :Icons.visibility_off

                ),
                 ),

              hintText: "tita",
              hintStyle: TextStyle(
                color: Colors.black26,
              ),
              labelText: 'password',
            ),
          ),

        )
      ],
    );
  }

  Widget forgetpassword() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerRight,
          child: Column(
            children: [

              FlatButton(onPressed: () => print("forgetpassword"),
                child:Text(
                  "Forgetpassword?",style: TextStyle(color: Colors.white,
                  fontSize: 16.0,
                  fontWeight:FontWeight.bold,

                ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
  Widget checkbox()
  {
    return Column(
      children: [
        Container(
          height: 20,
          alignment: Alignment.centerRight,

          child: Row(
            children: [
              Theme(data: ThemeData(unselectedWidgetColor: Colors.white,

              ),
                  child:Checkbox(
                      value:isRememeberMe,
                      checkColor: Colors.green,
                      activeColor: Colors.white,
                      onChanged:(value)
                      {
                         setState(() {
                            isRememeberMe=value!;
                         });
                      }



                  )
              ),

              Text("Remember",style:
                TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              )

            ],
          ),
        )
      ],
    );
  }
  Widget loginbutton()
  {
    return Container(

      padding: EdgeInsets.symmetric(vertical:25,
      horizontal:40.0 ),

      width: double.infinity,
      child:

      RaisedButton(
        elevation: 5,
        onPressed: ()
        {
         setState((){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>expert()));
         });
        },
        padding: EdgeInsets.only(left: 30,right: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.white,
        child: Text("LOGIN",style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,

        ),
        ),
      )
    );
  }
  Widget singin()
  {
    return GestureDetector(
      onTap: ()
      {

      },
      child: RichText(
        text: TextSpan(
          children:
          [
            TextSpan(
              text: "Dont have an account?",
              style: TextStyle(
                color:Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )
            ),

            TextSpan(
              text: "Sing up",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  )
            )
          ]
        ),
      ),
    );
  }

}

