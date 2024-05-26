class Employee {
  String ?id;
  String ?firstName;
  String ?lastName;
  String ?gender;
  String ?birthdate;
  String ?email;
  String ?phonenumber;
  String ?education;
  String ?campus;
  String ?building;
  String ?room;

  Employee({this.id, this.firstName, this.lastName,this.gender,this.birthdate,this.email,this.phonenumber,this.education,this.campus,this.building,this.room});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      gender: json['gender'] as String,
      birthdate: json['birthdate'] as String,
      email: json['email'] as String,
      phonenumber: json['phonenumber'] as String,
      education:json['education'] as String,
      campus: json['campuss'] as String,
      building: json['building'] as String,
      room: json['room'] as String,
    );
  }
}
