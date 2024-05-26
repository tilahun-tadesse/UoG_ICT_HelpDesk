import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:helpdesk/admin/database/Employee.dart';

class Services {

  static const ROOT = 'http://10.0.2.2/helpdesk/test_1.php';
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
 static  List ?employees=[];
  static  List ?experts=[];
  static  List ?userfeedback=[];
  static  List ?message=[];
  static Future<List<Employee>> getEmployees(String expertin) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_ACTION;
      map['expertin']=expertin;
      final response = await http.post(ROOT, body: map);
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

  static Future<String> addEmployee(String expertid,String firstName, String lastName,String Gender,String birthdata,String email,String phonenumber,String education,String campuss,String building,String room,String image,String expert_in,String code) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _ADD_EMP_ACTION;
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
      final response = await http.post(ROOT, body: map);
      print("addEmployee >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
    /*
    final response=await http.post(Uri.parse(ROOT),body:
      {
        "expertid":"tytyty",
        "first_name":"tytyty",
        "last_name":"tytyty",
        "gender":"tytyty",
        "birthdate":"tytyty",
        "email":email,
        "phonenumber":phonenumber,
        "education":education,
        "campuss":campuss,
        "building":building,
        "room":room,
        'image':image,
        'expert_in':expert_in,
      });

      if(response.statusCode==201)
        {
          print("addEmployee >> Response:: ${response.body}");
        }
      else {
         print("not input");
      }
     */
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
