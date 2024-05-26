import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helpdesk/admin.dart';
//import 'package:helpdesk/topbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:helpdesk/user/firstpage.dart';
import 'package:helpdesk/user/userdrawer.dart';
import 'package:helpdesk/main.dart';
import 'package:helpdesk/user/generalfeedback.dart';
import 'package:helpdesk/user/software1.dart';
import 'package:helpdesk/user/hardware.dart';
import 'package:helpdesk/user/other.dart';
import 'package:helpdesk/user/network.dart';
import 'package:helpdesk/user/admin_feedback.dart';
import 'package:helpdesk/user/database/Services.dart';
class userhome extends StatefulWidget
{
  const userhome({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return userhomestate();
    throw UnimplementedError();
  }

}
class userhomestate extends State<userhome>
    with SingleTickerProviderStateMixin {
//Map<String,String> bar=Map()
  String tite = "Dashbaord";
  late TabController control;
  get flutterView => null;
  var timeleft=4;
  var titleprogresse;
  var from_phonenumber;
  var expert_in;
  var adminmessage=0;
  var expertmessage=0;
  @override
  void initState() {
    super.initState();
    //navigate();
    control = TabController(length: 5, vsync: this);
    control.addListener(() {
      setState(() {
        tite = appbartitle(controller: control);
      });
    });
    showProgress();
    number_adminmessage();
    number_expertmessage();
  }

  void dispose() {
    control.dispose();
    super.dispose();
  }
  Future<bool> _onWillPop() async {
    return true;
  }
  number_adminmessage()async
  {
      final prefs = await SharedPreferences.getInstance();
      from_phonenumber= prefs.getString("phonenumber").toString();
      print("phonenumber");
      services.number_addmin_message(from_phonenumber.toString()).then((employees) {
        setState(() {


        });
        adminmessage=services.adminmessage!.length;
      });


  }
  number_expertmessage()async
  {
    final prefs = await SharedPreferences.getInstance();
    from_phonenumber= prefs.getString("phonenumber").toString();
    print("phonenumber");
    expert_in=messagenumber(controller: control);
    services.number_expert_message(from_phonenumber.toString(),expert_in.toString()).then((employees) {
      setState(() {


      });
      adminmessage=services.expertmessage!.length;
    });


  }
  showProgress() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if(timeleft>0)
      {
        setState(() {
          timeleft--;
          titleprogresse='updating...........';
        });

      }
      else
      {
        timer.cancel();

      }
    });
  }
  var count=0;
  DateTime timepress=DateTime.now();
  Widget build(BuildContext context) {
    // TODO: implement build
    //adminsidebar side=new adminsidebar();
   return
   SafeArea(child:
     WillPopScope(
     onWillPop: _onWillPop,
     child: Scaffold(
       // drawer:adminsidebar(),
       drawer: userdrawer(),
       appBar: AppBar(
         title: Text(timeleft==0||timeleft>4?tite:titleprogresse!),
         centerTitle: true,
         bottom: TabBar(
           controller: control,
           tabs: [
             Expanded(child: Container(child: Row(children: [Tab(icon: Icon(Icons.notification_add)),SizedBox(width: 7,),adminmessage>0?CircleAvatar(backgroundColor:Colors.red,radius: 9,child: Text(adminmessage.toString(),style: TextStyle(fontSize: 16,color: Colors.white),),):Container(child: null,)],),),),
             Expanded(child: Container(child: Row(children: [Tab(icon: Icon(Icons.people_alt)),SizedBox(width: 7,),expertmessage>0?CircleAvatar(backgroundColor:Colors.red,radius: 9,child: Text(expertmessage.toString(),style: TextStyle(fontSize: 16,color: Colors.white),),):Container(child: null,)],),),),
             Expanded(child: Container(child: Row(children: [Tab(icon: Icon(Icons.people_alt)),SizedBox(width: 7,),expertmessage>0?CircleAvatar(backgroundColor:Colors.red,radius: 9,child: Text(expertmessage.toString(),style: TextStyle(fontSize: 16,color: Colors.white),),):Container(child: null,)],),),),
             Expanded(child: Container(child: Row(children: [Tab(icon: Icon(Icons.people_alt)),SizedBox(width: 7,),expertmessage>0?CircleAvatar(backgroundColor:Colors.red,radius: 9,child: Text(expertmessage.toString(),style: TextStyle(fontSize: 16,color: Colors.white),),):Container(child: null,)],),),),
             Expanded(child: Container(child: Row(children: [Tab(icon: Icon(Icons.people_alt)),SizedBox(width: 7,),expertmessage>0?CircleAvatar(backgroundColor:Colors.red,radius: 9,child: Text(expertmessage.toString(),style: TextStyle(fontSize: 16,color: Colors.white),),):Container(child: null,)],),),),
           ],
         ),
       ),
       body: GestureDetector(
         child: Stack(
           children: [
             TabBarView(controller: control, children: [

               admin_feedback(),
               software(expertin: "Software"),
               hardware(expertin: "Hardware"),
               network(expertin: "Network"),
               other(expertin: "Other"),
             ]),
           ],
         ),
       ),
     ),
     )
    );


    throw UnimplementedError();
  }

  appbartitle({required TabController controller}) {
    String title = "Generalfeeback";
    switch (controller.index) {
      case 0:
        title = "Generalfeedback";
        break;
      case 1:
        title = "Software Expert Feedback";
        break;
      case 2:
        title="Hardware Expert Feedback";
        break;
      case 3:
        title="Newtwork Expert Feedback";
        break;
      case 4:
        title="Other Expert Feedback";

    }
    return title;
  }
  messagenumber({required TabController controller}) {
    String title = "Generalfeeback";
    switch (controller.index) {
      case 1:
        title = "Software";
        break;
      case 2:
        title = "Hardware";
        break;
      case 3:
        title="Networke";
        break;
      case 4:
        title="Other";
        break;

    }
    return title;
  }
}
