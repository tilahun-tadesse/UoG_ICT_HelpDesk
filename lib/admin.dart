import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:helpdesk/admin/newexepert.dart';

void main()
{
  runApp(app());
}
class app extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    MaterialApp(
      title: "helpdesk",
      home: homeadmin(),
    );
    throw UnimplementedError();
  }

}
class homeadmin extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeadminstate();
    throw UnimplementedError();
  }

}
class homeadminstate extends State<homeadmin>
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      drawer: sidebar(),
      appBar: AppBar(

      )
    );

    throw UnimplementedError();
  }


}
Widget sidebar()
{
  return Drawer(

    child:
    Container(
      //color: Colors.black26,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [

          UserAccountsDrawerHeader(accountName:Text(""),
              accountEmail: Text(""),
              //currentAccountPicture:CircleAvatar(
              //child: ClipOval(
              // child:Image.asset("image/help.png"),

              // ),
              //),
              decoration: BoxDecoration(
                image:DecorationImage(
                  image: AssetImage("image/help.png"),
                  fit: BoxFit.fill,
                ),
                color: Colors.blue,

              )
          ),
          list(),
        ],
      ),
    ),
  );
}
Widget list()
{
  return Container(

    child: Column(
      children: [
        Container(
          child: ListTile(
            leading: Icon(Icons.person_add),

            title: Text("New Expert",style: TextStyle(fontSize: 14.0),),
            onTap: ()
            {

            },
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.task_alt,

          ),
          title: Text("Assigned Task",style: TextStyle(fontSize: 17.0),),
        ),
        ListTile(
          leading: Icon(
            Icons.share,

          ),
          title: Text("Change user Password",style: TextStyle(fontSize: 17.0),),
          onTap: ()
          {

          },
        ),
        Divider(),
        ListTile(
          leading: Icon(
            Icons.notification_add,

          ),

          trailing:
          ClipOval(
            child: Container(color: Colors.red,
              width: 20,
              height: 20,
              alignment: Alignment.center,
              child: Text("4"),
            ),

          ),
        ),

        ListTile(
          leading: Icon(
            Icons.settings,

          ),
          title: Text("Settings",style: TextStyle(fontSize: 17.0),),
          onTap: ()
          {

          },
        ),
      ],
    ),

  );
}
