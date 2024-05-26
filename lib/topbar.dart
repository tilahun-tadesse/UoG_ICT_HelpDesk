import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:helpdesk/admin.dart';
import 'package:helpdesk/main.dart';
import 'package:helpdesk/admin/adminhome.dart';
import 'package:helpdesk/admin/database/admin_database/Services.dart';
import 'package:helpdesk/admin/database/admin_database/Employee.dart';
import 'package:helpdesk/admin/new_request.dart';
import 'package:helpdesk/admin/user_feedback.dart';
import 'package:helpdesk/admin/dashbord.dart';
void main()
{
  runApp(matarial());
}
class matarial extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    MaterialApp(
      title: "helpdesk",
      home: homebar(),
    );
    throw UnimplementedError();
  }

}
class homebar extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homebarstate();
    throw UnimplementedError();
  }

}
class homebarstate extends State<homebar>
    with SingleTickerProviderStateMixin
{
//Map<String,String> bar=Map()
String home="home";
String person="person";
String tite = "Dashbaord";
int  count=0;
int timeleft =4;
List<Employee> ?_employees=[];
String ?titileprogress;
  late TabController control;
  @override

  void initState() {
    super.initState();
    control = TabController(length: 4, vsync: this);
    control.addListener(() {
      setState(() {
        tite = appbartitle(controller: control);
      });
    });
    getrequest();
    showProgress();
  }
 void dispose()
 {
   control.dispose();
   super.dispose();
 }
showProgress() {
  Timer.periodic(Duration(seconds: 1), (timer) {
    if(timeleft>0)
    {
      setState(() {
        timeleft--;
        titileprogress='updating...........';
      });

    }
    else
    {
      timer.cancel();

    }
  });
}
getrequest (){

Services.getuser().then((employees) {
setState(() {
_employees = employees.cast<Employee>();
       });
count=Services.experts!.length;
    });
}
  Widget build(BuildContext context){
    // TODO: implement build
adminsidebar side=new adminsidebar();
    return  Scaffold(
          drawer:adminsidebar(),
          appBar: AppBar(
            title: Text(timeleft==0||timeleft>4?tite:titileprogress!),
            centerTitle: true,
            bottom: TabBar(
              controller: control,
              tabs: [
                Tab(icon: Icon(Icons.dashboard_customize_outlined)
                ),
                Expanded(child: Container(child: Row(children: [Tab(icon: Icon(Icons.notification_add)),SizedBox(width: 7,),count>0?CircleAvatar(backgroundColor:Colors.red,radius: 9,child: Text(count.toString(),style: TextStyle(fontSize: 16,color: Colors.white),),):Container(child: null,)],),),),
                Expanded(child: Container(child: Row(children: [Tab(icon: Icon(Icons.people_alt)),SizedBox(width: 7,),count>0?CircleAvatar(backgroundColor:Colors.red,radius: 9,child: Text(count.toString(),style: TextStyle(fontSize: 16,color: Colors.white),),):Container(child: null,)],),),),
                Expanded(child: Container(child: Row(children: [Tab(icon: Icon(Icons.person_add)),SizedBox(width: 7,),count>0?CircleAvatar(backgroundColor:Colors.red,radius: 9,child: Text(count.toString(),style: TextStyle(fontSize: 16,color: Colors.white),),):Container(child: null,)],),),),

              ],
            ),
          ),

          body: GestureDetector(
            child: Stack(
              children: [
                TabBarView(
                  controller: control,
                    children: [
                     MakeDashboardItems(),
                      user_request(),
                      user_feedback(),
                  fourth(),
                ]
                ),

              ],
            ),
          ),
        );


    throw UnimplementedError();
  }
   Widget first()
   {
     return GestureDetector(
       child: Stack(
         children: [
           Container(
             width: double.infinity,
             height: double.infinity,
             color: Colors.black,
             child: Text("flutter" ),

           )
         ],
       ),
     );
   }
   Widget second()=>GestureDetector(
     child: Stack(
       children: [
         Container(
           width: double.infinity,
           height: double.infinity,
           color: Colors.pink,

         )
       ],
     ),
   );
  Widget third()=>GestureDetector(
    child: Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blue,

        )
      ],
    ),
  );
  Widget fourth()=>GestureDetector(
    child: Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.green,

        )
      ],
    ),
  );

  }
appbartitle({required TabController controller})
{
  String title="Dashbaord";
  switch (controller.index) {
    case 0:
      title = "Dashbaord";
      break;
    case 1:
      title = "Requests";
      break;
    case 2:
      title = "user Feedback";
      break;
    case 3:
      title = "expert message";
      break;
  }
  return title;

}
