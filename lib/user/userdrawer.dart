import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:helpdesk/user/database/Services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:helpdesk/user/firstpage.dart';
import 'dart:math';
import 'dart:io';
import 'package:helpdesk/user/ask_help.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:helpdesk/user/database/Employee.dart';
import 'package:image_picker/image_picker.dart';
import 'package:helpdesk/user/verfication.dart';
class userdrawer extends StatefulWidget
{
  //String ?phonenumber;
  //userdrawer({required this.phonenumber});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return userdrawerstate();
    throw UnimplementedError();
  }

}
class userdrawerstate extends State<userdrawer> {

  bool visible =true;
  String ?fullname;
  String ?phonenumberexpert;
  String ?userid;
  String ?image;
  String ?phonenumber="098234823";
  List<employee> ?_employees=[];
  String ?base64Image;
  Future<File> ?file;
  String ?fileName;
  File ?tmpFile;
  @override
  void initState() {
    super.initState();
    _getExpertone();
  }
  gettt()
  {
    //print ("the result${Services.experts![0]['firstname']}");
  }
  _getExpertone() async{
    print("jghfdvhsdv");
    final prefs = await SharedPreferences.getInstance();
    phonenumber= prefs.getString("phonenumber");
    print(phonenumber);
    services.getExpertone(phonenumber.toString()).then((employees) {
      setState(() {
        fullname=services.experts![0]['firstName']+services.experts![0]['lastName'];
        phonenumberexpert=services.experts![0]['phonenumber'].toString();
        userid=services.experts![0]['userid'].toString();
        image=services.experts![0]['image'].toString();
        userid=services.experts![0]['userid'].toString();
      });

    });

    print(userid);
  }
  startUpload() {
    if (null == tmpFile) {
      return;
    }
    fileName = tmpFile!.path.split('/').last;
    upload(fileName!);
  }

  upload(String fileName) {
    http.post('http://10.0.2.2/helpdeskuser/image', body: {
      "image": base64Image,
      "name": fileName,
    }).then((result) {
    }).catchError((error) {
    });
  }
  Widget showImage() {
    return FutureBuilder<File>(
      future:file ,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data!.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data!,
              fit: BoxFit.cover,
            ),
          );
        }
        else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }
  chooseImage() {
    setState(() {
      file=ImagePicker.pickImage(source: ImageSource.gallery);
      print("the image name${file.toString()}");
    });
  }
  _updateuser() {
    startUpload();
    services.updateuser(
       fileName.toString(),userid.toString()
        )
        .then((result) {
      if("success"==result)
      {

      }

    });
  }

  Widget build(BuildContext context) {
    // TODO: implement build

    return
      WillPopScope(
        onWillPop: ()async
        {
          return gettt();
          },
      child: Drawer(
        child:GestureDetector(
          child:Stack(
            children: [
              Material(

                child: Column(
                  children: [
                    UserAccountsDrawerHeader(
                        accountName:Text("${fullname}"),
                        accountEmail:Text("$phonenumberexpert"),
                        currentAccountPicture:
                            GestureDetector(
                              onTap: ()
                              {
                                setState(() {
                                  chooseImage();
                                  showImage();
                                });

                              },
                            child: Expanded(
                              child: CircleAvatar(
                                backgroundColor:Colors.primaries[Random().nextInt(Colors.primaries.length)] ,
                                backgroundImage: NetworkImage(
                                    "http://10.0.2.2/helpdeskuser/${image}"),
                              ),
                            ),
                            ),
                  otherAccountsPictures: [
                    Expanded(child:
                    Column(
                      children: [
                        Expanded(child:
                        PopupMenuButton(itemBuilder: (context)=>[
                          PopupMenuItem(child: Row(
                            children: [
                              FlatButton(onPressed: ()async
                              {
                                final prefs = await SharedPreferences.getInstance();
                                prefs.setBool('isLoggedIn', false);
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                    builder: (context) => user()), (route) => false);
                                //Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => user())));
                              }, child: Text("Logout")),
                              Icon(Icons.logout),
                            ],
                          )
                          ),
                          ]
                        )
                        )
                      ],
                    )
                    ),
                  ],
                    ),
                 ListTile(
                   leading: Icon(Icons.help_outline),
                   title: Text("Ask help"),
                   onTap: ()async
                   {

                     Navigator.push(context,MaterialPageRoute(builder: (context)=>ask(userid: userid)));
                   },
                 ),
                    ListTile(
                      leading: Icon(Icons.help_outline),
                      title: Text("help verfication"),
                      onTap: ()async
                      {

                        Navigator.push(context,MaterialPageRoute(builder: (context)=>verifcation()));
                      },
                    ),
                  ],

                ),
              )
            ],
          ) ,
        ),

      ),
    );
  }
}