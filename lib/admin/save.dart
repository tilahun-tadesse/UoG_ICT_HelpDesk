import 'package:flutter/material.dart';
import 'package:helpdesk/admin/adminhome.dart';
void main()
{
  runApp(app(),);
}
class app extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "help desk",
      home: exce(),
    );
    throw UnimplementedError();
  }

}
class exce extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return excestate();
    throw UnimplementedError();
  }

}
class excestate extends State<exce> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: drawer(),
        appBar: AppBar(

          title: Text("helpdesk"),
          centerTitle: true,
        )
    );
  }
  Widget drawer()
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
    return ListView(
      children: [
      ListTile(
       onTap: ()
        {
         // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>adminhome()));
          Navigator.of(context).pop();
        },
      )
      ],
    );
  }
  Widget menuitem({required String text,required IconData icon,})
  {
    final color=Colors.white;
    final hovercolor=Colors.white54;
    VoidCallback? onClicked;
    return ListTile(
      leading: Icon(icon,color:color ,),
      title: Text(text,style: TextStyle(color: color),),
      hoverColor: hovercolor,
      onTap: ()
      {
       // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>adminhome()));
        Navigator.of(context).pop();
      },

    );
  }

}
