import 'dart:convert';

List<Welcome> welcomeFromJson(String str) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
  String ?expertid;
  String ?firstName;
  String ?lastName;
  Gender ?gender;
  String ?birthdate;
  String ?email;
  String ?phonenumber;
  Education ?education;
  Campuss ?campuss;
  String ?building;
  String ?room;
  Welcome({
    this.expertid,
    this.firstName,
    this.lastName,
    this.gender,
    this.birthdate,
    this.email,
    this.phonenumber,
    this.education,
    this.campuss,
    this.building,
    this.room,
  });



  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    expertid: json["expertid"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    gender: genderValues.map[json["gender"]],
    birthdate: json["birthdate"],
    email: json["email"],
    phonenumber: json["phonenumber"],
    education: educationValues.map[json["education"]],
    campuss: campussValues.map[json["campuss"]],
    building: json["building"],
    room: json["room"],
  );

  Map<String, dynamic> toJson() => {
    "expertid": expertid,
    "first_name": firstName,
    "last_name": lastName,
    "gender": gender,
    "birthdate": birthdate,
    "email": email,
    "phonenumber": phonenumber,
    "education": education,
    "campuss": campuss,
    "building": building,
    "room": room,
  };
}

enum Campuss { EMPTY, ATSETEWDROS }

final campussValues = EnumValues({
  "Atsetewdros": Campuss.ATSETEWDROS,
  "": Campuss.EMPTY
});

enum Education { EMPTY, BSC }

final educationValues = EnumValues({
  "Bsc": Education.BSC,
  "": Education.EMPTY
});

enum Gender { MALE, EMPTY }

final genderValues = EnumValues({
  "": Gender.EMPTY,
  "male": Gender.MALE
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> ?reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
