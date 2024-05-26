import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helpdesk/admin.dart';
import 'package:helpdesk/admin/experts/hardware.dart';
import 'package:helpdesk/admin/experts/software1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:helpdesk/expert/expert_drawer.dart';
import 'package:helpdesk/expert/request.dart';
import 'package:helpdesk/expert/admin_feedback.dart';
import 'package:helpdesk/expert/user_feedback.dart';
import 'package:helpdesk/expert/database/Services.dart';

class experthome extends StatefulWidget
{
  const experthome({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return experthomestate();
    throw UnimplementedError();
  }

}
class experthomestate extends State<experthome>
    with SingleTickerProviderStateMixin {
//Map<String,String> bar=Map()
  String tite = "Request";
  late TabController control;
  get flutterView => null;
  var allrequest=0;
  var alluserfeedback=0;
  var alladminfeedback=0;
  var phonenumber;
  var timeleft=3;
  var titleprogress;
  @override
  void initState() {
    super.initState();
    //navigate();
    control = TabController(length: 3, vsync: this);
    control.addListener(() {
      setState(() {
        tite = appbartitle(controller: control);
      });
    });
    getalluserfeedback();
    getalladminfeedback();
    getallrequest();
    showProgress();
  }

  void dispose() {
    control.dispose();
    super.dispose();

  }
  showProgress() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if(timeleft>0)
      {
        setState(() {
          timeleft--;
          titleprogress='updating...........';
        });

      }
      else
      {
        timer.cancel();

      }
    });
  }
  Future<bool> _onWillPop() async {
    return true;
  }

  getallrequest() async {
    //final prefs = await SharedPreferences.getInstance();
    //phonenumber= prefs.getString("phonenumber");
    phonenumber='0948311213';
    services.getrequest(phonenumber.toString()).then((employees) {
      setState(() {

      });
      print("Length: ${employees.length}");
     allrequest =services.experts!.length;

    });
  }
 getalluserfeedback() async {
    final prefs = await SharedPreferences.getInstance();
    phonenumber= prefs.getString("phonenumber");
    phonenumber='0948311213';
    services.getalluserfeedback(phonenumber.toString()).then((employees) {

      alluserfeedback=services.alluserfeedback!.length;

    });
    print('${services.experts!.length}');
  }
  getalladminfeedback() async {
    final prefs = await SharedPreferences.getInstance();
    phonenumber= prefs.getString("phonenumber");
    phonenumber='0948311213';
    services.getalladminfeedback(phonenumber.toString()).then((employees) {
      setState(() {

      });
      print("Length: ${employees.length}");
      alladminfeedback=services.alladminfeedback!.length;

    });
  }

  DateTime timepress=DateTime.now();
  Widget build(BuildContext context) {
    // TODO: implement build
    //adminsidebar side=new adminsidebar();
    return
      SafeArea(child:
      WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          drawer:expertdrawer(),
          appBar: AppBar(
            title: Text(timeleft==0||timeleft>4?tite:titleprogress),
            centerTitle: true,
            bottom: TabBar(
              controller: control,
              tabs: [
                Expanded(child: Container(child: Row(children: [Tab(icon: Icon(Icons.notification_add)),SizedBox(width: 7,),allrequest>0? CircleAvatar(backgroundColor:Colors.red,radius: 9,child: Text( allrequest.toString(),style: TextStyle(fontSize: 16,color: Colors.white),),):Container(child: null,)],),),),
                Expanded(child: Container(child: Row(children: [Tab(icon: Icon(Icons.feedback)),SizedBox(width: 7,),alluserfeedback>0?CircleAvatar(backgroundColor:Colors.red,radius: 9,child: Text(  alluserfeedback.toString(),style: TextStyle(fontSize: 16,color: Colors.white),),):Container(child: null,)],),),),
                Expanded(child: Container(child: Row(children: [Tab(icon: Icon(Icons.feedback)),SizedBox(width: 7,),alladminfeedback>0?CircleAvatar(backgroundColor:Colors.red,radius: 9,child: Text( alladminfeedback.toString(),style: TextStyle(fontSize: 16,color: Colors.white),),):Container(child: null,)],),),),
              ],
            ),
          ),
          body: GestureDetector(
            child: Stack(
              children: [
                TabBarView(controller: control, children: [
                   request(),
                  user_feedback(),
                  admin_feedback(),
                ]),
              ],
            ),
          ),
        ),
      )
      );


    throw UnimplementedError();
  }
 Widget software()
 {
   return Container(
     color: Colors.blue,
   );
 }
  Widget hardware()
  {
    return Container(
      color: Colors.blue,
    );
  }

  appbartitle({required TabController controller}) {
    String title = "Request";
    switch (controller.index) {
      case 0:
        title = "Request";
        break;
      case 1:
        title = "user feed_back";
        break;
      case 2:
        title = "expert feed_back";
        break;

    }
    return title;
  }
}
