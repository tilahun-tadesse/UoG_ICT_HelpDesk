import 'dart:math';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:helpdesk/admin/database/Employee.dart';
import 'package:helpdesk/admin/database/admin_database/Services.dart';
import 'dart:io';
import 'dart:convert';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:country_picker/country_picker.dart';
import 'package:http/http.dart' as http;
import 'package:helpdesk/admin/experts/admin_verfication.dart';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;
class DataTableDemo extends StatefulWidget {

   String title="New Expert ";
  String ?expertin;
  DataTableDemo({required this.expertin});


  @override
  DataTableDemoState createState() => DataTableDemoState();
}

class DataTableDemoState extends State<DataTableDemo> {
  List<Employee> ?_employees=[];
  Services services=Services();

  GlobalKey<ScaffoldState> ?_scafoldkey;
  int count =0;
  int timeleft=2;
  DateTime dateTime = DateTime(2014, 6, 21);
  var formkey = GlobalKey<FormState>();
  var gender = "male";
  var states = ["Bsc", "Msc", "phd"];
  var curentstates = "Bsc";
  String ?fileName;
  var campus = ["Atsetewdros", "Atsefasil", 'Maraci', 'Gc', 'Teda'];
  var currentcampuss = "Atsetewdros";
  GlobalKey<ScaffoldState> ?_scaffoldKey;
  TextEditingController expertid=TextEditingController() ;
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname=TextEditingController() ;
  String  ?phonenumber;
  TextEditingController emailadress=TextEditingController() ;
  TextEditingController building_number=TextEditingController() ;
  TextEditingController rom_number=TextEditingController() ;

  Employee ?_selectedEmployee;
  bool _isUpdating=false;
  String ?_titleProgress;
  Future<File> ?file;
  String status = '';
  String ?base64Image;
  var tmpFile;
  String  ?code;
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
  }

  void codegenerate ()
  {
    code=Random().nextInt(10000).toString();
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
  _addEmployee() {
    codegenerate();
    _showProgress('Adding Employee...');
    Services.addEmployee(expertid.text,firstname.text,lastname.text,gender.toString(),dateTime.toString(),emailadress.text,phonenumber.toString(),curentstates,currentcampuss,building_number.text,rom_number.text,tmpFile,widget.expertin.toString(),code.toString() )
        .then((result) {
     showsnack();
    });
  }
  _clearValues() {
    firstname.text = '';
    lastname.text= '';
    expertid.text="";
    emailadress.text="";
    phonenumber="";
    building_number.text="";
    rom_number.text="";
    tmpFile=null;
    fileName="";

  }
  chooseImage() {
    setState(() {
      file=ImagePicker.pickImage(source: ImageSource.gallery) ;
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
    upload(tmpFile!);

  }

  upload(File fileName) async {
    var request = http.MultipartRequest("POST", Uri.parse("http://637cfebf16c1b892ebc51e02.mockapi.io/api/v1/expert_image"));
    request.fields["image_name"] ="tilahunb nmlkn";
    var pic = await http.MultipartFile.fromPath("image", fileName.path);
    request.files.add(pic);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
  }
  upload_image(File fileName) async {
    // open a bytestream
    var stream = new http.ByteStream(DelegatingStream.typed(fileName.openRead()));
    // get file length
    var length = await fileName.length();

    // string to uri
    var uri = Uri.parse("http://10.0.2.2:8000/image-list/");

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);
    request.fields["firstName"] ="tilahunb nmlkn";

    // multipart that takes file
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: path.basename(fileName.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }
  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
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
  showsnack() {
    if (Services.updating == true) {
      Flushbar(
        icon: Icon(Icons.error, color: Colors.white,),
        messageText: Text("you successfully add new experts",
          style: TextStyle(color: Colors.white),),
        duration: Duration(seconds: 5),
        margin: EdgeInsets.only(top: 60, right: 10, left: 10),
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        flushbarPosition: FlushbarPosition.TOP,
        borderRadius: 15,

      )..show(context);
    }
    else
      {
        Flushbar(
          icon: Icon(Icons.error,color: Colors.white,),
          messageText: Text("adding new expert is failde",style: TextStyle(color: Colors.white),),
          duration: Duration(seconds: 5),
          margin: EdgeInsets.only(top: 60,right: 10,left: 10),
          dismissDirection: FlushbarDismissDirection.HORIZONTAL,
          flushbarPosition: FlushbarPosition.TOP,
          borderRadius: 15,

        )..show(context);
      }




  }
  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(timeleft==0? "New Expert":_titleProgress.toString()),
        leading: IconButton(icon: Icon(Icons.arrow_back,),onPressed:backnavigation ,),
        actions: <Widget>[

          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
             
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {

            }
          ),
        ],
      ),
      body:
      Stack(
        children: [
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
                                child:
                                Container(
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
                            Text("Phone:",style: TextStyle(fontSize: 13.0),),
                            Expanded(
                                child:
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 30.0,
                                  ),
                                  width: 400,
                                  height: 50.0,
                                  child:
                                        IntlPhoneField(
                                          initialCountryCode: "ET",

                                          decoration: const InputDecoration(

                                            labelText: 'Phone Number',
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(),
                                            ),
                                          ),
                                          onChanged: (phone) {
                                            phonenumber=phone.completeNumber.toString();
                                          },
                                          onCountryChanged: (country) {
                                            print('Country changed to: ' + country.name);
                                          },
                                        ),
                                      )
                                  ),
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
                                  Text("Building  :",style: TextStyle(fontSize: 13.0),),
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
                                                      showImage(),
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
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          startUpload();
          _addEmployee();
          _clearValues();
          Navigator.push(context, MaterialPageRoute(builder: (context)=>verifcation(code: code)));
        },
        child: Icon(Icons.save),
      ),
    );
  }
  backnavigation()
  {
    Navigator.pop(context,true);
  }
  Future<DateTime?> pickdate() => showDatePicker(
    context: context,
    initialDate: dateTime,
    firstDate: DateTime(1960),
    lastDate: DateTime(2100),
  );
}
