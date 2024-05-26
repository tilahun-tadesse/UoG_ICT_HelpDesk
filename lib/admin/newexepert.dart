import 'dart:async';

import 'package:flutter/material.dart';
import 'package:helpdesk/admin.dart';
import 'package:helpdesk/main.dart';
import 'package:helpdesk/admin/adminhome.dart';
import 'package:helpdesk/admin/experts/network.dart';
import 'package:helpdesk/admin/experts/software1.dart';
import 'package:helpdesk/admin/experts/hardware.dart';
import 'package:helpdesk/admin/experts/other.dart';

void main() {
  runApp(matarial());
}

class matarial extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    MaterialApp(
      title: "helpdesk",
      home: newexpert(),
    );
    throw UnimplementedError();
  }
}

class newexpert extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return newexpertsate();
    throw UnimplementedError();
  }
}

class newexpertsate extends State<newexpert>
    with SingleTickerProviderStateMixin {
//Map<String,String> bar=Map()
  String home = "home";
  String ?titleprogress;
  String person = "person";
  int timeleft=3;
  String tite = "Software";
  late TabController control;

  @override
  void initState() {
    super.initState();
    control = TabController(length: 4, vsync: this);
     _showProgress();
    control.addListener(() {
      setState(() {
        tite = appbartite(controller: control);
      });
    });
  }

  void dispose() {
    control.dispose();
    super.dispose();
  }
  _showProgress() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if(timeleft>0)
      {
        setState(() {
          titleprogress="Updating.....";

          timeleft--;

        });
      }
      else
      {
        timer.cancel();

      }
    });
  }

  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text(timeleft==0?tite:titleprogress.toString()),
        centerTitle: true,
        actions: [
          IconButton(
        icon: Icon(Icons.search_off)
            ,onPressed: ()
              {

              },
          )
        ],
        bottom: TabBar(
          controller: control,
          tabs: [
            Tab( icon: Icon(Icons.code)),
            Tab(icon: Icon(Icons.hardware_outlined)),
            Tab(icon: Icon(Icons.network_check_outlined)),
            Tab(icon: Icon(Icons.devices_other)),
          ],
        ),
      ),
      body: GestureDetector(
        child: Stack(
          children: [
            TabBarView(controller: control, children: [
              software(expertin: "Software"),
              hardware(expertin: "Hardware"),
              network(expertin: "Network"),
              other(expertin: "other"),
            ]),
          ],
        ),
      ),
    );


    throw UnimplementedError();
  }

}

String appbartite({required TabController controller}) {
  String title = "Sotware";
  switch (controller.index) {
    case 0:
      title = "Software";
      break;
    case 1:
      title = "Hardware";
      break;
    case 2:
      title = "Network";
      break;
    case 3:
      title = "Other";
      break;
  }
  return title;
}
