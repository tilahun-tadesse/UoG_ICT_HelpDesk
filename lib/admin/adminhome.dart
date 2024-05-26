import 'package:flutter/material.dart';
import 'package:helpdesk/admin.dart';

import 'package:helpdesk/admin/save.dart';

import 'package:helpdesk/admin/newexepert.dart';
import 'package:helpdesk/topbar.dart';
class adminsidebar extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return adminsidebarstate();
    throw UnimplementedError();
  }

}
class adminsidebarstate extends State<adminsidebar> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Drawer(

        child:
        GestureDetector(
          child: Stack(
            children: [
              Material(
                color: Colors.blue,
                child: Column(

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
            ],
          ),
        )
    );

  }




  Widget list()
  {
    final color=Colors.white;
    final textcolor=Colors.white;
    final hovercover=Colors.white12;
    return Column(
      children: [
        SizedBox(height: 40.0,),
        ListTile(
          leading: Icon(Icons.person_add,color:color),
          title: Text("New Expert",style: TextStyle(fontSize: 14.0,color: textcolor)),
          onTap: ()
          {

            Navigator.push(context, MaterialPageRoute(builder: (context)=>newexpert()));

          },
          hoverColor:hovercover ,
        ),
        ListTile(
          leading: Icon(Icons.task_alt,color: color,),
          title: Text("Assigned Task",style: TextStyle(fontSize: 14.0,color: textcolor),),
          onTap: ()
          {
            //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>newexperthome()));
            Navigator.of(context).pop();
          },
          hoverColor: hovercover,
        ),
        ListTile(
          leading: Icon(Icons.person_add,color: color,),
          title: Text("Change User Password",style: TextStyle(fontSize: 14.0,color: textcolor),),
          onTap: ()
          {
            //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>newexperthome()));
            Navigator.of(context).pop();
          },
          hoverColor: hovercover,
        )

      ],
    );
  }


}
