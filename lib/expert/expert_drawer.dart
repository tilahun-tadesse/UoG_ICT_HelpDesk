import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:helpdesk/expert/database/Services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:helpdesk/user/firstpage.dart';
import 'dart:math';
import 'dart:io';
import 'package:helpdesk/user/ask_help.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
class expertdrawer extends StatefulWidget
{
  //String ?phonenumber;
  //userdrawer({required this.phonenumber});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return expertdrawerstate();
    throw UnimplementedError();
  }

}
class expertdrawerstate extends State<expertdrawer> {

  bool visible =true;
  String ?fullname;
  String ?phonenumberexpert;
  String ?userid;
  String ?image;
  String ?phonenumber="+251948311618";
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
  _getExpertone()async{

    final prefs = await SharedPreferences.getInstance();
    phonenumber= prefs.getString("0948311213");
    services.getExpertone(phonenumber.toString()).then((employees) {
      setState(() {

      });
      fullname=services.experts![0]['first_name']+services.experts![0]['last_name'];
      phonenumberexpert=services.experts![0]['phonenumber'].toString();
      image=services.experts![0]['image'].toString();
    });

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
                                  "http://10.0.2.2/helpdesk/${image}"),
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
                      /*ListTile(
                        leading: Icon(Icons.help_outline),
                        title: Text("Ask help"),
                        onTap: ()async
                        {
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>ask()));
                        },
                      ),*/
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