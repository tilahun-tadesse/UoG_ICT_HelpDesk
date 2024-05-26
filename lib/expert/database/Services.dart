import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:helpdesk/expert/database/Employee.dart';
import 'package:shared_preferences/shared_preferences.dart';

class services {

  static const ROOT = 'http://10.0.2.2/helpdesk/test.php';
  static const String _GET_ACTION = 'GET_ALL';
  static const String _CREATE_TABLE = 'CREATE_TABLE';
  static const String _ADD_EMP_ACTION = 'ADD_EMP';
  static const String _ADD_TEXT_ACTION= 'ADD_TEXT';
  static const String _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const String _DELETE_EMP_ACTION = 'DELETE_EMP';
  static const String _GET_EXPERT_ONE='GET_ONE';
  static const String _GET_MESAGE='GET_MESAAGE';
  static const String _GET_USER_LISTMESAGE='GET_LISTMESAAGE';
  static const String _USER_REQUEST='ADD_REQUEST';
  static const String _GET_REQUEST='GET_USER_REQUEST';
  static const String _GET_USER_REQUEST_DETIAL='GET_USER_REQUEST_DETIAL';
  static const String _GET_USER_FEEDBACK='GET_USER_FEEDBACK';
  static const String _GET_EXPERT_FEEDBACK='GET_EXPERT_FEEDBACK';
  static const String _GET_USER_MESSAGE='GET_USER_MESSAGE';
  static const String _GET_USER_ONE='GET_USER_ONE';
  static const String _GET_ALL_USER_FEEDBACK='GET_ALL_USER_FEEDBACK';
  static const String _GET_ALL_ADMIN_FEEDBACK='GET_ALL_ADMIN_FEEDBACK';
  static const String _UPDATE_USER_MESSAGESEEN='UPDATE_USER_MESSAGESEEN';
  static const String _NUMBER_NEWMESSAGE='NUMBER_NEWMESSAGE';
 static  List ?employees=[];
  static  List ?experts=[];
  static  List ?users=[];
  static  List ?message=[];
  static  List ?feedback=[];
  static List ?alluserfeedback=[];
  static List ?newmessage=[];
  static List ?alladminfeedback=[];
  static String ?fullname="tilahun";
  static String tita="tilahun";
  static List<employee> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<employee>((json) => employee.fromJson(json)).toList();
  }
  static Future<List<employee>> getExpertone(String phonenumber) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_EXPERT_ONE;
      map["phonenumber"]=phonenumber;
      print("767");
      final response = await http.post(ROOT, body: map);
      print("getExpertone >> Response:: ${response.body}");
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
  static Future<List<employee>> getuserone(String userid) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_USER_ONE;
      map["userid"]=userid;
      final response = await http.post(ROOT, body: map);
      print("getuserone >> Response:: ${response.body}");
      users=json.decode(response.body);
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
      map["action"] = _GET_MESAGE;
      map["from_phonenumber"]=from;
      map['to_phonenumber']=to;
      print(from);
      print(to);
      final response = await http.post(ROOT, body: map);
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


  static Future<List<employee>>get_user_message(String from ,String to ) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_USER_MESSAGE;
      map["from_phonenumber"]=from;
      map['to_phonenumber']=to;
      final response = await http.post(ROOT, body: map);
      print("get_user_message>> Response:: ${response.body}");
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

  static Future<List<employee>> getrequest(String phonenumber) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_REQUEST;
      map["phonenumber"]=phonenumber;
      final response = await http.post(ROOT, body: map);
      print("getrequest>> Response:: ${response.body}");
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
  static Future<List<employee>> getalluserfeedback(String phonenumber) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_ALL_USER_FEEDBACK;
      map["to_phonenumber"]=phonenumber;
      final response = await http.post(ROOT, body: map);
      print("getalluserfeedback>> Response:: ${response.body}");
      alluserfeedback=json.decode(response.body);
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
  static Future<List<employee>> getalladminfeedback(String phonenumber) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_ALL_ADMIN_FEEDBACK;
      map["phonenumber"]=phonenumber;
      final response = await http.post(ROOT, body: map);
      print("getalladminfeedback>> Response:: ${response.body}");
      alladminfeedback=json.decode(response.body);
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
  static Future<List<employee>> getrequest_detail(String problem_id) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_USER_REQUEST_DETIAL;
      map["problem_id"]=problem_id;
      final response = await http.post(ROOT, body: map);
      print("getrequest>> Response:: ${response.body}");
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

  static Future<List<employee>> getlistmessage(String from ,String to ) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_MESAGE;
      map["from_phonenumber"]=from;
      map['to_phonenumber']=to;
      final response = await http.post(ROOT, body: map);
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

  static Future<String> addEmployee(String firstName, String lastName,String phonenumber,String image) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _ADD_EMP_ACTION;
      map["first_name"] = firstName;
      map["last_name"] = lastName;
      map["phonenumber"] = phonenumber;
      map['image']=image;
      final response = await http.post(ROOT, body: map);
      print("addEmployee >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }
  static Future<List<employee>> get_user_feedback(String phonenumber) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_USER_FEEDBACK;
      map["to_phonenumber"]=phonenumber;
      final response = await http.post(ROOT, body: map);
      print("get_user_feedback>> Response:: ${response.body}");
      feedback=json.decode(response.body);

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
  static Future<List<employee>> number_newmessage(String from_phonenumber,String to_phonenumber) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _NUMBER_NEWMESSAGE;
      map['from_phonenumber']=from_phonenumber;
      map["to_phonenumber"]=to_phonenumber;
      final response = await http.post(ROOT, body: map);
      print("number_newmessage>> Response:: ${response.body}");
      newmessage=json.decode(response.body);
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
  static Future<List<employee>> get_expert_feedback(String phonenumber) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_EXPERT_FEEDBACK;
      map["to_phonenumber"]=phonenumber;
      final response = await http.post(ROOT, body: map);
      print("get_admin_feedback >> Response:: ${response.body}");
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
  static Future<String> expert_verfication(
      String problem_id) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _UPDATE_EMP_ACTION;
      map["problem_id"] = problem_id;
      final response = await http.post(ROOT, body: map);
      print("UpdateExpert >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
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
      map['userid']=00948;
      map["varfication_code"]=verfication;
      final response = await http.post(ROOT, body: map);
      print("user_request >> Response:: ${response.body}");
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

  static Future<String> updateusermessageseen(String from_phonenumber,String to_phonenumber) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _UPDATE_USER_MESSAGESEEN;
      map["from_phonenumber"] = from_phonenumber;
      map['to_phonenumber']=to_phonenumber;
      final response = await http.post(ROOT, body: map);
      print("Updatusermessageseen >> Response:: ${response.body}");
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


