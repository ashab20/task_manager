// ignore_for_file: unnecessary_new

class UserMOdel {
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;
  String? photo;

  UserMOdel(
      {this.email, this.firstName, this.lastName, this.mobile, this.photo});

  UserMOdel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['mobile'] = mobile;
    data['photo'] = photo;
    return data;
  }
}
