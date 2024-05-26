import 'package:flutter/material.dart';
//import 'package:helpdesk/user/usermodel.dart';
//import 'package:helpdesk/user/userclass.dart';
import 'package:helpdesk/admin/database/Services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:helpdesk/user/database/Services.dart';
import 'dart:io';
class admin_message extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return admin_messagestate();
    throw UnimplementedError();
  }

}
class admin_messagestate extends State<admin_message> {
  String ?image;
  String ?fullname;
  String ?to_phonenumber;
  String ?from_phonenumber;
  String predate="";
  int count=0;
  TextEditingController text=TextEditingController();
  @override
  Future<File> ?file;
  void initState() {
    super.initState();
    getmessage();

  }

  _chatBubble(String message, bool isMe, bool isSameUser,String message_date,message_time) {
    if (isMe) {
      return Column(
        children: <Widget>[
          Container(
              alignment: Alignment.topRight,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery
                      .of(context)
                      .size
                      .width * 0.80,
                ),
                padding: EdgeInsets.only(left: 15,top: 10,bottom: 10,right: 10),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child:
                RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(
                            text: message+'\r',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            )
                        ),
                        TextSpan(
                            text: '\r'+message_time,
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            )
                        ),
                        TextSpan(
                          text: '\r'+"✓",
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,

                          ),
                        ),
                      ]
                  ),


                ),

              )
          ),

          ! isSameUser
              ?

          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 150),
                padding: EdgeInsets.only(left: 10,right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Text(
                  message_date,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ],

          )
              : Container(
            child: null,
          ),
        ],
      );
    }
    else {
      return Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery
                    .of(context)
                    .size
                    .width * 0.80,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: RichText(
                text: TextSpan(
                    children: [
                      TextSpan(
                          text: message+'\r',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          )
                      ),
                      TextSpan(
                        text: '\r'+message_time+'\r',
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,

                        ),
                      ),
                    ]
                ),


              ),
            ),
          ),
          !isSameUser
              ?
          Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 150,right: 120),
                // padding: EdgeInsets.only(left: 10,right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Text(
                  message_date,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),

            ],

          )
              : Container(
            child: null,
          ),
        ],
      );
    }
  }

  _sendMessageArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25,
            color: Theme
                .of(context)
                .primaryColor,
            onPressed: () {
              chooseImage() {
                setState(() {
                  file=ImagePicker.pickImage(source: ImageSource.gallery);
                });
              }
            },
          ),
          Expanded(
            child: TextField(
              minLines: 1,
              maxLines: 15,
              controller: text,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message..',
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Theme
                .of(context)
                .primaryColor,
            onPressed: () {
              setState(() {
                addtext();
                getmessage();

              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int prevUserId;
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        brightness: Brightness.dark,
        centerTitle: true,
        title:
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  "http://10.0.2.2/helpdesk/${image}"),
            ),
            SizedBox(width: 30,),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [

                  TextSpan(
                      text: fullname,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )),
                  TextSpan(text: '\n'),
                  true ?
                  TextSpan(
                    text: 'Online',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                      :
                  TextSpan(
                    text: 'Offline',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.all(20),
              itemCount: count,
              itemBuilder: (BuildContext context, int index) {
                //final Message message = messages[index];
                final bool isSameUser = predate ==services.message![index]['message_date'] ;
                predate=services.message![index]['message_date'];
                final bool isMe = services.message![index]['from_number'] == from_phonenumber;
                String message=services.message![index]['message_text'];
                String message_time=services.message![index]['message_time'];
                String message_date=services.message![index]['message_date'];
                return _chatBubble(message, isMe,isSameUser,message_date,message_time);
              },
            ),
          ),
          _sendMessageArea(),
        ],
      ),
    );
  }

  addtext() async
  {
    final prefs = await SharedPreferences.getInstance();
    from_phonenumber= prefs.getString("phonenumber").toString();
    services.add_admin_text(text.text,from_phonenumber.toString())
        .then((result) {
      if ('success' == result) {

      }
      else {

      }

    });
  }
  getmessage()async {
    final prefs = await SharedPreferences.getInstance();
    from_phonenumber= prefs.getString("phonenumber").toString();
    print("phonenumber");
    services.get_admin_message(from_phonenumber.toString()).then((employees) {
      setState(() {

        count=employees.length;
      });
      print(services.message!.length);
    });

  }
}
