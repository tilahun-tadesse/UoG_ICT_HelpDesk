class employee {

  String ?firstName;
  String ?lastName;
  String ?image;
 String ?phonenumber;
  employee({ this.firstName, this.lastName,this.phonenumber,this.image});

  factory employee.fromJson(Map<String, dynamic> json) {
    return employee(

      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      phonenumber: json['phonenumber'] as String,
      image:json['image'] as String,
    );
  }
}
