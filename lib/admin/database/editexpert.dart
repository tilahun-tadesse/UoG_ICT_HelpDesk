import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:helpdesk/admin/database/Employee.dart';
import 'package:helpdesk/admin/database/Services.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';
class editexpert extends StatefulWidget
{
String ?expertid1;
String title="Edit Expert";
String ?curentimage;
editexpert({required this.expertid1,required this.curentimage});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return editexpertstate();
    throw UnimplementedError();
  }

}
class editexpertstate extends State<editexpert>
{
  List<Employee> ?_employees=[];
  GlobalKey<ScaffoldState> ?_scafoldkey;
  int count =0;
  int timeleft=2;
  int _currentindex=0;
  int time=5;
  int ?deleteid;
  DateTime dateTime = DateTime(2014, 6, 21);
  var formkey = GlobalKey<FormState>();
  String gender = "male";
  var states = ["Bsc", "Msc", "phd"];
  var curentstates = "Bsc";
  var image;
  String ?fileName;
 int ?length;
  var campus = ["Atsetewdros", "Atsefasil", 'Maraci', 'Gc', 'Teda'];
  var currentcampuss = "Atsetewdros";
  GlobalKey<ScaffoldState> ?_scaffoldKey;
  String ?phounumberinput;
  TextEditingController expertid=TextEditingController() ;
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname=TextEditingController() ;
  TextEditingController phonenumber=TextEditingController() ;
  TextEditingController emailadress=TextEditingController() ;
  TextEditingController building_number=TextEditingController() ;
  TextEditingController rom_number=TextEditingController() ;
  Employee ?_selectedEmployee;
  bool _isUpdating=false;
  String ?_titleProgress;
  Future<File> ?file;
  String status = '';
  String ?base64Image;
  File ?tmpFile;
  String errMessage = 'Error Uploading Image';
  @override
  void initState() {
    super.initState();
    _employees = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    lastname=TextEditingController();
    firstname=TextEditingController();
    gender="male";
    _getExpertone();

  }


  _showProgress(String message) {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if(timeleft>0)
      {
        setState(() {
          timeleft--;
          _titleProgress=message;
        });

      }
      else
      {
        timer.cancel();

      }
    });
  }
  _getExpertone() {

    Services.getExpertone(widget.expertid1.toString()).then((employees) {
      setState(() {
        _employees = employees;
      });
      //_showProgress(widget.title);
      _setValues(Services.experts![0]['id'],Services.experts![0]['expertid'],Services.experts![0]['firstName'],Services.experts![0]['lastName'],Services.experts![0]['gender'],Services.experts![0]['birthdate'],Services.experts![0]['email'],Services.experts![0]['phonenumber'],Services.experts![0]['education']
          ,Services.experts![0]['campuss'],Services.experts![0]['building'],Services.experts![0]['room'],Services.experts![0]['image']);
      print("Length: ${employees.length}");

      length=employees.length;
    });



  }
  _deleteEmployee() {
    _showProgress('Deleting Employee...');
    Services.deleteEmployee(deleteid!).then((result) {
      if ('success' == result) {
        setState(() {

        });
        _clearValues();
      }

    });
  }

  _updateEmployee() {
    _showProgress('Updating Employee...');
    startUpload();
    Services.updateEmployee(
       expertid.text.toString(),firstname.text,lastname.text,gender.toString(),dateTime.toString(),emailadress.text,phonenumber.text,curentstates,currentcampuss,building_number.text,rom_number.text,fileName.toString(),deleteid!)
        .then((result) {
          if("success"==result)
            {
              showupdatesnack();
            }

    });
  }


  _setValues(int _deleteid,String _expertid,String _firstname,String _lasatname,String _gender,String _birthdate,String _email,String _phonenumber,String _education,String _campuss,String _building,String _room,String _image) {
    deleteid=_deleteid;
    expertid.text=_expertid;
    firstname.text=_firstname;
    lastname.text=_lasatname;
    gender=_gender;
    image=_image.toString();
    emailadress.text=_email;
    phonenumber.text=_phonenumber.substring(4,13) ;
    curentstates=_education;
    currentcampuss=_campuss;
    building_number.text=_building;
    rom_number.text=_room;
    fileName=_image;
    setState(() {
      _isUpdating = true;
      showImage();
    });
    showImage();
  }

  _clearValues() {
    firstname.text = '';
    lastname.text= '';
    expertid.text="";
    emailadress.text="";
    phonenumber.text="";
    building_number.text="";
    rom_number.text="";
    tmpFile=null;
    fileName="";

  }
  chooseImage() {
    setState(() {
      file=ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }
  setStatus(String message) {
    setState(() {
      status = message;
    });
  }
  startUpload() {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    fileName = tmpFile!.path.split('/').last;
    upload(fileName!);
  }

  upload(String fileName) {
    http.post('http://10.0.2.2/helpdesk/testtt.php', body: {
      "image": base64Image,
      "name": fileName,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error) {
      setStatus(error);
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
              tmpFile!,
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
          return Expanded(child:
            Image.network("http://10.0.2.2/helpdesk/$image")
          );
        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Scaffold(
      key: _scaffoldKey,

      appBar: AppBar(
        title: Text(timeleft==0? "New Expert":_titleProgress.toString()),
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed:backnavigation,),
        actions: <Widget>[

        ],
      ),

      body:
          Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.only(top: 60.0, left: 20, right: 30.0,bottom: 30),
              color: Colors.white,
              child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  physics: AlwaysScrollableScrollPhysics(),
                  child:Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Expert id :",style: TextStyle(fontSize: 13.0),),
                            Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: 35.0,
                                  ),
                                  width: 400,
                                  height: 50.0,
                                  child: TextFormField(
                                      style: TextStyle(fontSize: 13.0),
                                      validator: (values) {
                                        if (values=="") {
                                          return "Enter correct name";
                                        }
                                        else {
                                          return null;
                                        }
                                      },
                                      controller: expertid,
                                      decoration: InputDecoration(
                                        labelText: "Expert id ",

                                      )
                                  ),
                                ))
                          ],
                        ),
                        Row(
                          children: [
                            Text("Firstname :",style: TextStyle(fontSize: 13.0),),
                            Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: 30.0,
                                  ),
                                  width: 400,
                                  height: 50.0,
                                  child: TextFormField(
                                      style: TextStyle(fontSize: 13.0),
                                      validator: (values) {
                                        if (values=="") {
                                          return "Enter correct name";
                                        }
                                        else {
                                          return null;
                                        }
                                      },
                                      controller: firstname,
                                      decoration: InputDecoration(
                                        labelText: "First name ",

                                      )
                                  ),
                                ))
                          ],
                        ),

                        Row(
                          children: [
                            Text("Lastname :",style: TextStyle(fontSize: 13.0),),
                            Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: 30.0,
                                  ),
                                  width: 400,
                                  height: 50.0,
                                  child: TextFormField(
                                      style: TextStyle(fontSize: 13.0),
                                      validator: (values) {
                                        if (values=="") {
                                          return "Enter correct name";
                                        }
                                        else {
                                          return null;
                                        }
                                      },
                                      controller: lastname,
                                      decoration: InputDecoration(
                                        labelText: "Last name ",

                                      )
                                  ),
                                ))
                          ],
                        ),
                        Row(
                          children: [
                            Text("Gender:"),
                            SizedBox(
                              width: 50,
                              height: 10,
                            ),
                            Radio(
                              value: "male",
                              groupValue: gender,
                              onChanged: (values) {
                                setState(() {
                                  gender = values.toString();
                                });
                              },
                            ),
                            Text("Male"),
                            SizedBox(
                              width: 20.0,
                            ),
                            Radio(
                              value: "female",
                              groupValue: gender,
                              onChanged: (values) {
                                setState(() {
                                  gender = values.toString();
                                });
                              },
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Female"),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Birth Date:"),
                            Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 30.0),
                                  width: 300,
                                  child: ElevatedButton(
                                    child: Text(
                                        '${dateTime.year}/${dateTime.month}/${dateTime.day}'),
                                    onPressed: () async {
                                      final date = await pickdate();
                                      if (date == null) return;
                                      setState(() {
                                        dateTime = date;
                                      });
                                    },
                                  ),
                                ))
                          ],
                        ),
                        Row(
                          children: [
                            Text("Email Address :",style: TextStyle(fontSize: 13.0),),
                            Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: 30.0,
                                  ),
                                  width: 400,
                                  height: 50.0,
                                  child: TextFormField(
                                      style: TextStyle(fontSize: 13.0),
                                      validator: (values) {
                                        if (values=="" ) {
                                          return "Enter correct Email Address";
                                        }
                                        else {
                                          return null;
                                        }
                                      },
                                      controller: emailadress,
                                      decoration: InputDecoration(
                                        labelText: "Emaill Address ",

                                      )
                                  ),
                                ))
                          ],
                        ),
                        Row(
                          children: [
                            Text("Phone :",style: TextStyle(fontSize: 13.0),),
                            Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: 30.0,
                                  ),
                                  width: 400,
                                  height: 50.0,
                                  child: IntlPhoneField(
                                    initialCountryCode: "ET",
                                    controller:phonenumber ,
                                    decoration: const InputDecoration(
                                      labelText: 'Phone Number',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(),
                                      ),
                                    ),
                                    onChanged: (phone) {
                                      phounumberinput=phone.completeNumber.toString();
                                    },
                                    onCountryChanged: (country) {
                                      print('Country changed to: ' + country.name);
                                    },
                                  ),
                                )
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text("Educational Level:"),
                            Expanded(
                                child: Container(
                                    padding:
                                    EdgeInsets.only(top: 10.0, left: 40),
                                    height: 50,
                                    width: 400,
                                    child: DropdownButton(
                                      items: states
                                          .map((String drop) =>
                                          DropdownMenuItem<String>(
                                              value: drop,
                                              child: Text(drop)))
                                          .toList(),
                                      onChanged: (var stat) {
                                        setState(() {
                                          curentstates = stat.toString();
                                        });
                                      },
                                      value: curentstates,
                                    )))
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          height: 20,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 50,
                                  ),
                                  child: Text(
                                    "Expert Capmus Address",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ))
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 40, top: 20.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text("Campus:"),
                                  Expanded(
                                      child: Container(
                                          padding: EdgeInsets.only(
                                            left: 30.0,
                                          ),
                                          width: 400,
                                          height: 30.0,
                                          child: DropdownButton(
                                            items: campus
                                                .map((String drop) =>
                                                DropdownMenuItem(
                                                    value: drop,
                                                    child: Text(drop)))
                                                .toList(),
                                            onChanged: (var values) {
                                              setState(() {
                                                currentcampuss =
                                                    values.toString();
                                              });
                                            },
                                            value: currentcampuss,
                                          )))
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Building :",style: TextStyle(fontSize: 13.0),),
                                  Expanded(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          left: 30.0,
                                        ),
                                        width: 400,
                                        height: 50.0,
                                        child: TextFormField(
                                            keyboardType:TextInputType.number,
                                            style: TextStyle(fontSize: 13.0),
                                            validator: (values) {
                                              if (values=="") {
                                                return "Enter correct Input";
                                              }
                                              else {
                                                return null;
                                              }
                                            },
                                            controller: building_number,
                                            decoration: InputDecoration(
                                              labelText: "Building number ",

                                            )
                                        ),
                                      ))
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Room  :",style: TextStyle(fontSize: 13.0),),
                                  Expanded(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          left: 40.0,
                                        ),
                                        width: 400,
                                        height: 50.0,
                                        child: TextFormField(
                                            style: TextStyle(fontSize: 13.0),
                                            validator: (values) {
                                              if (values=="") {
                                                return "Enter correct input";
                                              }
                                              else {
                                                return null;
                                              }
                                            },
                                            controller: rom_number,
                                            decoration: InputDecoration(
                                              labelText: "Room number ",

                                            )
                                        ),
                                      ))
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Expert Image:"),
                                  Expanded(
                                      child: Container(
                                          padding:
                                          EdgeInsets.only(top: 10.0),
                                          height: 200,
                                          width: 400,
                                          child:
                                          Expanded(
                                            child: Column(
                                              children: [
                                                OutlinedButton(
                                                  onPressed: chooseImage,
                                                  child: Text("choose Image"),
                                                ),

                                            file==null? Image.network(widget.curentimage!,fit: BoxFit.cover,):showImage(),
                                                Text(status,style: TextStyle(),)
                                              ],
                                            ),
                                          )
                                      )
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(

                        )
                      ],
                    ),
                  )
              )
          ),
      bottomNavigationBar: bottomnavigation(),
    );
  }
  Future<DateTime?> pickdate() => showDatePicker(
    context: context,
    initialDate: dateTime,
    firstDate: DateTime(1960),
    lastDate: DateTime(2100),
  );
 Widget bottomnavigation()
  {
    return BottomNavigationBar(
      currentIndex: _currentindex,
        items:[
      BottomNavigationBarItem(
        backgroundColor: Colors.blue,
          icon: Icon(Icons.update),
           label: "Upadate"
      ),

      BottomNavigationBarItem(
         backgroundColor: Colors.red,
          icon: Icon(Icons.delete),
          label: "delete"
      )
    ],
    selectedItemColor: Colors.red,
    unselectedItemColor: Colors.black87,
    backgroundColor: Colors.blue,
  type: BottomNavigationBarType.fixed,
    onTap: (index)
        {
          setState(() {
            _currentindex=index;
          });
          if(_currentindex==0)
            {
              _updateEmployee();
            }
          if(_currentindex==1)
            {
              showsnackbar();
            }
        }

    );

  }
  backnavigation()
  {
    Navigator.pop(context,true);
  }
  /*
  void snackbar(String message)
  {
    var snack=SnackBar(content: Text("hello"),

    action: SnackBarAction(
      label: "ok",
      onPressed: ()
      {

      },
    )
    );
    Scaffold.of(context).showSnackBar(snack);
  }
  void snack( BuildContext context, String item)
  {
    var snackbar=SnackBar(
      content: Text(" are sure to delete this file $item"),
      margin: EdgeInsets.only(bottom: 40),
      action: SnackBarAction(
          label:" ok",
          onPressed:()
          {
            debugPrint("ok");
          }
      ),

    );

    Scaffold.of(context).showSnackBar(snackbar);
  }*/
 void showsnackbar()
 {
   bool dismiss=true;
   Flushbar(
     icon: Icon(Icons.error,color: Colors.white,),
     messageText: Text("are you sure you wan to delete",style: TextStyle(color: Colors.white),),
     borderRadius: 15,
     duration: Duration(seconds: time),
     mainButton:
         Row(
           children: [
             FlatButton(
               child: Text("calcel",style: TextStyle(color: Colors.white),),
                 onPressed:()
                    {
                      time=0;
              }),
             FlatButton(
               child: Text("ok",style: TextStyle(color: Colors.white),),
                 onPressed:()
             {
               setState(() {
                 _deleteEmployee();
               });
             })
           ],
         ),
     margin: EdgeInsets.only(top: 60,right: 10,left: 10),
     dismissDirection: FlushbarDismissDirection.HORIZONTAL,
     flushbarPosition: FlushbarPosition.TOP,

   )..show(context);

 }
showupdatesnack()
{
  Flushbar(
    icon: Icon(Icons.error,color: Colors.white,),
    messageText: Text("you successfully update experts",style: TextStyle(color: Colors.white),),
    duration: Duration(seconds: 5),
    margin: EdgeInsets.only(top: 60,right: 10,left: 10),
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    flushbarPosition: FlushbarPosition.TOP,
    borderRadius: 15,

  )..show(context)
  ;
}

}