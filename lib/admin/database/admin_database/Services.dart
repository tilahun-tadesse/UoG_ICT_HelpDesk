import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:helpdesk/admin/database/Employee.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
class Services {

  static const ROOT = 'http://10.0.2.2:8000/expert-list/';
  static const String _GET_ACTION = 'GET_ALL';
  static const String _CREATE_TABLE = 'CREATE_TABLE';
  static const String _ADD_EMP_ACTION = 'ADD_EMP';
  static const String _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const String _DELETE_EMP_ACTION = 'DELETE_EMP';
  static const String _GET_EXPERT_ONE='GET_ONE';
  static const String _GET_REQUEST='GET_REQUEST';
  static const String _GET_USER='GET_USER';
  static const String _ASIGN_EXPERT='ASIGN_EXPERT';
  static const String _ADD_TEXT='ADD_USER_TEXT';
  static const String _ASIGNED_EXPERT='ASIGNED_EXPERT';
  static const String _GET_USER_FEEDBACK='GET_USER_ADMIN_FEEDBACK';
  static const String _GET_USER_MESSAGE='GET_USER_MESSAGE';
  static const String _GET_USER_ONE='GET_USER_ONE';
  static const String _GET_ALL_USER='GET_ALL_USER';
  static const String _GET_ALL_EXPERT='GET_ALL_EXPERT';
  static const String _GET_ALL_COMPLETED_TASK='GET_ALL_COMPLETED_TASK';
  static bool updating=true;
  static  var dio = Dio();
 static  List ?employees=[];
  static  List ?experts=[];
  static  List ?user=[];
  static  List ?userfeedback=[];
  static  List ?message=[];
  static const String authority="reqres.in";
  static Future<List<Employee>> getEmployees(String expertin) async {
    try {
      var map = new Map<String, dynamic>();
map["action"] = _GET_ACTION;
      map['expertin']=expertin;
      final url = 'http://10.0.2.2:8000/expert-list/';
      final response = await http.get(url);
      // final response = await http.post(Uri.https(authority, '/api/users'));
      print("getEmployees >> Response:: ${response.body}");
      employees=json.decode(response.body);
      if (response.statusCode == 200) {
        List<Employee> list = parsePhotos(response.body);
        return list;
      } else {
        throw <Employee>[];
      }
    } catch (e) {
      return <Employee>[];
    }

  }

  static List<Employee> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
  }
  static Future<List<Employee>> getrequest(String userid) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_REQUEST;
      map['userid']=userid;
      final response = await http.post(ROOT, body: map);
      print("getRequest >> Response:: ${response.body}");
      experts=json.decode(response.body);
      //print("the userid=${Services.experts![3]['userid']}");
      if (response.statusCode == 200) {
        List<Employee> list = parsePhotos(response.body);
        return list;
      } else {
        throw <Employee>[];
      }
    } catch (e) {
      return <Employee>[];
    }

  }
  static Future<List<Employee>> getuserfeedback() async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_USER_FEEDBACK;
      final response = await http.post(ROOT, body: map);
      print("get_userfeedback >> Response:: ${response.body}");
      userfeedback=json.decode(response.body);
      //print("the userid=${Services.experts![3]['userid']}");
      if (response.statusCode == 200) {
        List<Employee> list = parsePhotos(response.body);
        return list;
      } else {
        throw <Employee>[];
      }
    } catch (e) {
      return <Employee>[];
    }

  }
  static Future<List<Employee>>get_user_message(String to ) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_USER_MESSAGE;
      map['to_phonenumber']=to;
      final response = await http.post(ROOT, body: map);
      print("get_user_message>> Response:: ${response.body}");
      message=json.decode(response.body);

      if (response.statusCode == 200) {
        List<Employee> list = parsePhotos(response.body);
        return list;
      } else {
        throw <Employee>[];
      }
    } catch (e) {
      return <Employee>[];
    }

  }

  static Future<List<Employee>>get_all_user() async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] =_GET_ALL_USER;
      final response = await http.post(ROOT, body: map);
      print("get_all_user>> Response:: ${response.body}");
      user=json.decode(response.body);

      if (response.statusCode == 200) {
        List<Employee> list = parsePhotos(response.body);
        return list;
      } else {
        throw <Employee>[];
      }
    } catch (e) {
      return <Employee>[];
    }

  }
  static Future<List<Employee>>get_all_expert() async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_ALL_EXPERT;
      final response = await http.post(ROOT, body: map);
      print("get_all_expert>> Response:: ${response.body}");
      experts=json.decode(response.body);
      if (response.statusCode == 200) {
        List<Employee> list = parsePhotos(response.body);
        return list;
      } else {
        throw <Employee>[];
      }
    } catch (e) {
      return <Employee>[];
    }

  }
  static Future<List<Employee>>get_all_today_task() async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_ALL_COMPLETED_TASK;
      final response = await http.post(ROOT, body: map);
      print("get_user_message>> Response:: ${response.body}");
      message=json.decode(response.body);

      if (response.statusCode == 200) {
        List<Employee> list = parsePhotos(response.body);
        return list;
      } else {
        throw <Employee>[];
      }
    } catch (e) {
      return <Employee>[];
    }

  }
  static Future<List<Employee>>get_all_onwork_expert() async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_USER_MESSAGE;
      final response = await http.post(ROOT, body: map);
      print("get_user_message>> Response:: ${response.body}");
      message=json.decode(response.body);

      if (response.statusCode == 200) {
        List<Employee> list = parsePhotos(response.body);
        return list;
      } else {
        throw <Employee>[];
      }
    } catch (e) {
      return <Employee>[];
    }

  }
  static Future<List<Employee>>get_completed_task() async {
    try {
      var map = new Map<String, dynamic>();

      final response = await http.post(ROOT, body: map);
      print("get_user_message>> Response:: ${response.body}");
      message=json.decode(response.body);

      if (response.statusCode == 200) {
        List<Employee> list = parsePhotos(response.body);
        return list;
      } else {
        throw <Employee>[];
      }
    } catch (e) {
      return <Employee>[];
    }

  }
  static Future<List<Employee>>get_all_completed_task() async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_ALL_COMPLETED_TASK;
      final response = await http.post(ROOT, body: map);
      print("get_user_message>> Response:: ${response.body}");
      message=json.decode(response.body);

      if (response.statusCode == 200) {
        List<Employee> list = parsePhotos(response.body);
        return list;
      } else {
        throw <Employee>[];
      }
    } catch (e) {
      return <Employee>[];
    }

  }
  static Future<List<Employee>>get_uncompleted_task() async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_USER_MESSAGE;
      final response = await http.post(ROOT, body: map);
      print("get_user_message>> Response:: ${response.body}");
      message=json.decode(response.body);

      if (response.statusCode == 200) {
        List<Employee> list = parsePhotos(response.body);
        return list;
      } else {
        throw <Employee>[];
      }
    } catch (e) {
      return <Employee>[];
    }

  }
  static Future<List<Employee>>get_all_uncompleted_task() async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_USER_MESSAGE;
      final response = await http.post(ROOT, body: map);
      print("get_user_message>> Response:: ${response.body}");
      message=json.decode(response.body);

      if (response.statusCode == 200) {
        List<Employee> list = parsePhotos(response.body);
        return list;
      } else {
        throw <Employee>[];
      }
    } catch (e) {
      return <Employee>[];
    }

  }
  static Future<List<Employee>> asign_expert(String expert_in,String campus) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _ASIGN_EXPERT;
     map['expert_in']=expert_in;
     map['campus']=campus;
      final response = await http.post(ROOT, body: map);
      print("asign_expert >> Response:: ${response.body}");
      experts=json.decode(response.body);
      //print("the userid=${Services.experts![3]['userid']}");
      if (response.statusCode == 200) {
        List<Employee> list = parsePhotos(response.body);
        return list;
      } else {
        throw <Employee>[];
      }
    } catch (e) {
      return <Employee>[];
    }

  }

  static Future<List<Employee>> getuser() async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_USER;
      final response = await http.post(ROOT, body: map);
      print("getuser >> Response:: ${response.body}");
      experts=json.decode(response.body);
      //print("the userid=${Services.experts![3]['userid']}");
      if (response.statusCode == 200) {
        List<Employee> list = parsePhotos(response.body);
        return list;
      } else {
        throw <Employee>[];
      }
    } catch (e) {
      return <Employee>[];
    }

  }
  static Future<List<Employee>> get_user_one(String userid) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_USER_ONE;
      map['userid']=userid;
      final response = await http.post(ROOT, body: map);
      print("get_user_one >> Response:: ${response.body}");
      experts=json.decode(response.body);
      //print("the userid=${Services.experts![3]['userid']}");
      if (response.statusCode == 200) {
        List<Employee> list = parsePhotos(response.body);
        return list;
      } else {
        throw <Employee>[];
      }
    } catch (e) {
      return <Employee>[];
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

  static Future<String> addtext(String text,String to) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _ADD_TEXT;
      map['text']=text;
      map['to_phonenumber']=to;
      final response = await http.post(ROOT, body: map);
      print("add_user_text>> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<Object> addEmployee(String expertid,String firstName, String lastName,String Gender,String birthdata,String email,String phonenumber,String education,String campuss,String building,String room,File image,String expert_in,String code) async {
    try {

      var map = new Map<String, dynamic>();
      map["expertid"]=expertid;
      map["firstName"] = firstName;
      map["lastName"] = lastName;
      map["gender"]=Gender;
      map["birthdate"] = birthdata;
      map["email"] = email;
      map["phonenumber"] = phonenumber;
      map["education"] = education;
      map["campus"] =campuss ;
      map["building"] = building;
      map["room"] = room;
      map['image']=image;
      map['expert_in']=expert_in;

      var stream = new http.ByteStream(DelegatingStream.typed(image.openRead()));
      // get file length
      var length = await image.length();

      // string to uri
      var uri = Uri.parse("http://10.0.2.2:8000/expert-list/");

      // create multipart request
      var request = new http.MultipartRequest("POST", uri,);
      request.fields["expertid"] =expertid;
      request.fields["firstName"] =firstName;
      request.fields["lastName"] =lastName;
      request.fields["gender"] =Gender;
      request.fields["birthdate"] =birthdata;
      request.fields["email"] =email;
      request.fields["phonenumber"] =phonenumber;
      request.fields["education"] =education;
      request.fields["campus"] =campuss;
      request.fields["building"] =building;
      request.fields["room"] =room;
      request.fields["expert_in"] =expert_in;
      // request.fields["firstName"] ="tilahunb nmlkn";
      // multipart that takes file
      var multipartFile = new http.MultipartFile('image', stream, length,
          filename: path.basename(image.path));

      // add file to multipart
      request.files.add(multipartFile);

      // send
      var response = await request.send();

      print(response.statusCode);

      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });

      // final response = await http.post('http://10.0.2.2:8000/expert-list/',
      //     body: map);
      if (response.statusCode == 201) {
        updating=true;
      }
      else {

        updating=false;

      }

       return updating;


    }
    catch (e) {
      return true;
    }
  }
  static Future<String> asigned_expert(
      String problme_id,String asigned_expert_phonenumber) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _ASIGNED_EXPERT;
      map['problem_id']=problme_id;
      map["asigned_expert_phonenumber"] = asigned_expert_phonenumber;
      final response = await http.post(ROOT, body: map);
      print("asigend_expert >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }
  static Future<String> updateEmployee(
     String expertid,String firstName, String lastName,String Gender,String birthdata,String email,String phonenumber,String education,String campuss,String building,String room,String image, String updatedid) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _UPDATE_EMP_ACTION;
      map['updatedid']=updatedid;
      map["first_name"] = firstName;
      map["expertid"]=expertid;
      map["last_name"] = lastName;
      map["gender"]=Gender;
      map["birthdate"] = birthdata;
      map["email"] = email;
      map["phonenumber"] = phonenumber;
      map["education"] = education;
      map["campuss"] =campuss ;
      map["building"] = building;
      map["room"] = room;
      map['image']=image;
      final response = await http.post(ROOT, body: map);
      print("UpdateExpert >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> deleteEmployee(String expertid) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _DELETE_EMP_ACTION;
      map["expertid"] = expertid;
      final response = await http.post(ROOT, body: map);
      print("deleteEmployee >> Response:: ${response.body}");
      return response.body;
    }
    catch (e) {
      return 'er';
    }
  }
}
