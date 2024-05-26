class Employee {
  String ?expertid;
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
  String ?image;
  String ?expert_in;
  Employee({this.expertid, this.firstName, this.lastName,this.gender,this.birthdate,this.email,this.phonenumber,this.education,this.campus,this.building,this.room,this.image,this.expert_in});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      expertid: json['id'] as String,
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
      image:json['image'] as String,
      expert_in: json['expert_in'] as String,
    );
  }
}
