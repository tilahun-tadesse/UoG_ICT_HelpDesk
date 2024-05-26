import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:helpdesk/user/database/Employee.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;
class services {

  static const ROOT = 'http://10.0.2.2/helpdeskuser/userdata.php';
  static const String _GET_ACTION = 'GET_ALL';
  static const String _CREATE_TABLE = 'CREATE_TABLE';
  static const String _ADD_EMP_ACTION = 'ADD_EMP';
  static const String _ADD_TEXT_ACTION= 'ADD_TEXT';
  static const String _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const String _DELETE_EMP_ACTION = 'DELETE_EMP';
  static const String _GET_EXPERT_ONE='GET_ONE';
  static const String _GET_MESSAGE='GET_USER_MESSAGE';
  static const String _GET_USER_LISTMESAGE='GET_LISTMESAAGE';
  static const String _USER_REQUEST='ADD_REQUEST';
  static const String _ADD_ADMIN_TEXT='ADD_ADMIN_TEXT';
  static const String _GET_ADMIN_MESSAGE='GET_ADMIN_MESSAGE';
  static const String _NUMBER_ADMIN_MESSAGE='NUMBER_ADMIN_MESSAGE';
  static const String _NUMBER_EXPERT_MESSAGE='NUMBER_EXPERT_MESSAGE';
 static  List ?employees=[];
  static  List ?experts=[];
  static  List ?message=[];
  static bool updating=true;
  static  List ?adminmessage=[];
  static  List ?expertmessage=[];
  static String ?fullname="tilahun";
  static String tita="tilahun";
  static List<employee> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<employee>((json) => employee.fromJson(json)).toList();
  }
  static Future<List<employee>> getExpertone(String phonenumber) async {
    try {
      print("the number${phonenumber}");
      phonenumber="+251666666666";
      final url = 'http://10.0.2.2:8000/user-list/?phonenumber=${phonenumber}';
      final response = await http.get(url);
      print("getEmployees >> Response:: ${response.body}");
      experts=json.decode(response.body);

      if (response.statusCode == 200) {
        List<employee> list = parsePhotos(response.body);
        return list;
      } else {
        throw <employee>[];
      }
    } catch (e) {
      return <employee>[];
    }

  }
  static Future<List<employee>> getmessage(String from ,String to ) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_MESSAGE;
      map["from_phonenumber"]=from;
      map['to_phonenumber']=to;
      print("ththththththththth");
      final response = await http.post(ROOT, body: map);
      print("user_getmessage>> Response:: ${response.body}");
      message=json.decode(response.body);

      if (response.statusCode == 200) {
        List<employee> list = parsePhotos(response.body);
        return list;
      } else {
        throw <employee>[];
      }
    } catch (e) {
      return <employee>[];
    }

  }
  static Future<List<employee>> get_admin_message(String from ) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_ADMIN_MESSAGE;
      map["from_phonenumber"]=from;
      print("the nuber hfhafhs");
      final response = await http.post(ROOT, body: map);
      print("get_admin_message>> Response:: ${response.body}");
      message=json.decode(response.body);

      if (response.statusCode == 200) {
        List<employee> list = parsePhotos(response.body);
        return list;
      } else {
        throw <employee>[];
      }
    } catch (e) {
      return <employee>[];
    }

  }

  static Future<List<employee>> getlistmessage(String from ,String to ) async {
    try {
      var map = new Map<String, dynamic>();
      map["from_phonenumber"]=from;
      map['to_phonenumber']=to;
      final response = await http.post(ROOT, body: map);
      print("ththththththththth");
      print("getmessage>> Response:: ${response.body}");
      message=json.decode(response.body);

      if (response.statusCode == 200) {
        List<employee> list = parsePhotos(response.body);
        return list;
      } else {
        throw <employee>[];
      }
    } catch (e) {
      return <employee>[];
    }

  }

  static Future<List<employee>> number_addmin_message(String to) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _NUMBER_ADMIN_MESSAGE;
      map['to_phonenumber']=to;
      final response = await http.post(ROOT, body: map);
      print("number_admin_message>> Response:: ${response.body}");
      adminmessage=json.decode(response.body);

      if (response.statusCode == 200) {
        List<employee> list = parsePhotos(response.body);
        return list;
      } else {
        throw <employee>[];
      }
    } catch (e) {
      return <employee>[];
    }

  }
  static Future<List<employee>> number_expert_message(String to,String expert_in) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _NUMBER_EXPERT_MESSAGE;
      map['to_phonenumber']=to;
      map['expert_in']=expert_in;
      final response = await http.post(ROOT, body: map);
      print("number_expert_message>> Response:: ${response.body}");
      expertmessage=json.decode(response.body);

      if (response.statusCode == 200) {
        List<employee> list = parsePhotos(response.body);
        return list;
      } else {
        throw <employee>[];
      }
    } catch (e) {
      return <employee>[];
    }

  }


  static Future<String> createTable() async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _CREATE_TABLE;
      final response = await http.post(ROOT, body: map);
      print("createTable >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }


  static Future<Object> addEmployee(String firstName, String lastName,String phonenumber,String image) async {
    try {
      var map = new Map<String, dynamic>();
      map["firstName"] = firstName;
      map["lastName"] = lastName;
      map["phonenumber"] = phonenumber;
      map['image'] = "";
      print(firstName);
      print(lastName);
      print("hfdahfhdhfhdhf");
      final http.Response response = await http.post(
          Uri.parse('http://10.0.2.2:8000/user-list/'),
          body: map,
          );
      print("addEmployee >> Response:: ${response.body}");
      // final http.Response response = await http.post(
      //     Uri.parse('http://10.0.2.2:8000/user-list/'),
      //     headers: <String, String>{
      //       'Content-Type': 'application/json; charset=UTF-8',
      //     },
      //     body: jsonEncode(<String, String>{
      //       'firstName': firstName,
      //       'lastName':lastName,
      //       'phonenumber':phonenumber,
      //       'image':""
      //
      //     }));
      if (response.statusCode == 201) {
        updating = true;
        print("correct");
      }
      else {
        updating = false;
        print("incorrect");
      }

      return updating;
      // var stream = new http.ByteStream(DelegatingStream.typed(image.openRead()));
      // // get file length
      // var length = await image.length();
      //
      // // string to uri
      // var uri = Uri.parse("http://10.0.2.2:8000/user-list/");
      //
      // // create multipart request
      // var request = new http.MultipartRequest("POST", uri,);
      // request.fields["firstName"] =firstName;
      // request.fields["lastName"] =lastName;
      // request.fields["phonenumber"] =phonenumber;
      // // request.fields["firstName"] ="tilahunb nmlkn";
      // // multipart that takes file
      // var multipartFile = new http.MultipartFile('image', stream, length,
      //     filename: path.basename(image.path));
      //
      // // add file to multipart
      // request.files.add(multipartFile);
      //
      // // send
      // var response = await request.send();
      //
      // print(response.statusCode);
      //
      // // listen for response
      // response.stream.transform(utf8.decoder).listen((value) {
      //   print(value);
      // });
      //
      // // final response = await http.post('http://10.0.2.2:8000/expert-list/',
      // //     body: map);
      // if (response.statusCode == 201) {
      //   updating=true;
      // }
      // else {
      //
      //   updating=false;
      //
      // }
      //
      // return updating;
    }
     catch (e) {
      return true;
    }
  }
  static Future<String> userrequet(String problem_catagory, String problem_title,String problem_priority,String campus,String building,String room ,String verfication,String userid) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _USER_REQUEST;
      map["problem_catagory"] =problem_catagory;
      map["problem_title"] =problem_title;
      map["problem_priority"] = problem_priority;
      map['campus']=campus;
      map["building"]=building;
      map["room"]=room;
      map['userid']=userid;
     map["varfication_code"]=verfication;
      final response = await http.post(ROOT, body: map);
      print("user_request >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }
  static Future<String> expert_verfication(
      String user_verfication) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _UPDATE_EMP_ACTION;
      map["user_verfication"] = user_verfication;
      final response = await http.post(ROOT, body: map);
      print("UpdateExpert >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }
  
  static Future<String> addtext(String text,String from,String to,String expert_in) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _ADD_TEXT_ACTION;
      map['text']=text;
      map['expert_in']=expert_in;
      print(text);
      map['from_phonenumber']=from;
      map['to_Phonenumber']=to;
      final response = await http.post(ROOT, body: map);
      print("addtext>> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> add_admin_text(String text,String from) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _ADD_ADMIN_TEXT;
      map['text']=text;
      map['from_phonenumber']=from;
      final response = await http.post(ROOT, body: map);
      print("add_admin_text>> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> updateuser(
    String image,String userid) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _UPDATE_EMP_ACTION;
      map["userid"] = userid;
      map['image']=image;
      final response = await http.post(ROOT, body: map);
      print("UpdateExpert >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> deleteEmployee(String phonenumber) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _DELETE_EMP_ACTION;
      map["expertid"] = phonenumber;
      final response = await http.post(ROOT, body: map);
      print("deleteEmployee >> Response:: ${response.body}");
      return response.body;
    }
    catch (e) {
      return 'er';
    }
  }
}


