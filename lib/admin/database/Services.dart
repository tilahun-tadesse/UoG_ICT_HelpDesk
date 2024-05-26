import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:helpdesk/admin/database/Employee.dart';

class Services {

  static const ROOT = 'http://127.0.0.1:8000/addexpert';
  static const String _GET_ACTION = 'GET_ALL';
  static const String _CREATE_TABLE = 'CREATE_TABLE';
  static const String _ADD_EMP_ACTION = 'ADD_EMP';
  static const String _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const String _DELETE_EMP_ACTION = 'DELETE_EMP';
  static const String _GET_EXPERT_ONE='GET_ONE';
  static  List ?employees=[];
  static  List ?experts=[];
  static bool updating=true;

  static Future<List<Employee>> getEmployees(String expertin) async {
    try {
      var map = new Map<String, dynamic>();
       print("get employee");
      final url = 'http://10.0.2.2:8000/expert-list/?expert_in=${expertin}';
      final response = await http.get(url);
      if (response.statusCode == 200)
        {
        employees=json.decode(response.body);
        updating=false;
      List<Employee> list = parsePhotos(response.body);

      return list;
      }

      else {
        updating=true;
        print("hello error");
        throw <Employee>[];
      }
    }
    catch (e) {
      return <Employee>[];
    }

  }

  static List<Employee> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
  }
  static Future<List<Employee>> getExpertone(String expertid) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_EXPERT_ONE;
      map["expertid"]=expertid;
      final url = 'http://10.0.2.2:8000/expert-list/?expertid=${expertid}';
      final response = await http.get(url);
      print("getExpertone >> Response:: ${response.body}");
      experts=json.decode(response.body);
      if (response.statusCode == 200) {
        List<Employee> list = parsePhotos(response.body);
        experts=json.decode(response.body);
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

  static  addEmployee(String expertid,String firstName, String lastName,String Gender,String birthdata,String email,String phonenumber,String education,String campuss,String building,String room,String image,String expert_in,String code,String file) async {
    try {
      var dio = Dio();
      var map = new Map<String, dynamic>();
      print("ghhhhhhhh");
      map["first_name"] = firstName;
      map["gender"]=Gender;
      map["expertid"]=expertid;
      map["last_name"] = lastName;
      map["birthdate"] = birthdata;
      map["email"] = email;
      map["phonenumber"] = phonenumber;
      map["education"] = education;
      map["campuss"] =campuss ;
      map["building"] = building;
      map["room"] = room;
      map['image']=image;
      map['expert_in']=expert_in;

      var response = await dio.post(ROOT, data: map);
      print(response.data.toString());

      if (response.data['response']['data'] == 'success') {
      }
      else {


      }

      if(response.statusCode==201)
        {
          updating=true;
        }
      else
        {
          updating=false;
        }
      return updating;
    }
    catch (e) {
      return 'error';
    }
  }

  static Future<String> updateEmployee(
     String expertid,String firstName, String lastName,String Gender,String birthdata,String email,String phonenumber,String education,String campuss,String building,String room,String image, int updatedid) async {
    try {
      var map = new Map<String, dynamic>();
      print("hello");
      // map["expertid"]=expertid;
      map["firstName"] = "tola";
      // map["lastName"] = lastName;
      // map["gender"]=Gender;
      // map["birthdate"] = birthdata;
      // map["email"] = email;
      // map["phonenumber"] = phonenumber;
      // map["education"] = education;
      // map["campus"] =campuss ;
      // map["building"] = building;
      // map["room"] = room;
      // map['image']=image;
      // final url = 'http://10.0.2.2:8000/expert-delete/${updatedid}';
      // final response = await http.patch(url,body: 'firstName:"tita"');
      // print("UpdateExpert >> Response:: ${response.body}");
      // if (response.statusCode == 200)
      //   {
      //     print("correct ");
      //   }
      // else
      //   {
      //     print("not corect");
      //   }
      // final http.Response response = await http.put(Uri.parse('http://10.0.2.2:8000/expert-delete/10'),
      //   headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
      //     body:map);
      // var stream = new http.ByteStream(DelegatingStream.typed(image.openRead()));
      // // get file length
      // var length = await image.length();
      //
      // // string to uri
      // var uri = Uri.parse("http://10.0.2.2:8000/expert-list/");
      //
      // // create multipart request
      // var request = new http.MultipartRequest("POST", uri,);
      // request.fields["expertid"] =expertid;
      // request.fields["firstName"] =firstName;
      // request.fields["lastName"] =lastName;
      // request.fields["gender"] =Gender;
      // request.fields["birthdate"] =birthdata;
      // request.fields["email"] =email;
      // request.fields["phonenumber"] =phonenumber;
      // request.fields["education"] =education;
      // request.fields["campus"] =campuss;
      // request.fields["building"] =building;
      // request.fields["room"] =room;
      //
      // // request.fields["firstName"] ="tilahunb nmlkn";
      // // multipart that takes file
      // var multipartFile = new http.MultipartFile('image', stream, length,
      //     filename: path.basename(image.path));

      // add file to multipart
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

      final response = await http.put(Uri.parse('http://10.0.2.2:8000/expert-delete/15'),
          headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',},
          body:  jsonEncode(<String, String>{
          'firstName': "abebe"}));
      if (response.statusCode == 200)
          {
            print("correct ");
          }
      else
          {
            print("not corrrect");
          }
      return response.body;

    } catch (e) {
      return 'error';
    }
  }

  static Future<String> deleteEmployee(int  expertid) async {
    try {
      var map = new Map<String, dynamic>();
      final url = 'http://10.0.2.2:8000/expert-delete/${expertid}';
      final response = await http.delete(url);
      print("deleteEmployee >> Response:: ${response.body}");
      return response.body;
    }
    catch (e) {
      return 'er';
    }
  }
}
