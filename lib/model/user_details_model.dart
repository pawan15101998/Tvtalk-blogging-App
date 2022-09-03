class UserDetails {
  Data? data;
  String? message;

  UserDetails({this.data, this.message});

  UserDetails.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? name;
  String? email;
  int? mobile;
  String? dob;
  int? gender;
  String? image;
  int? status;
  String? resetToken;
  Null? fcmToken;
  Null? socialLoginType;
  Null? socialLoginId;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.name,
      this.email,
      this.mobile,
      this.dob,
      this.gender,
      this.image,
      this.status,
      this.resetToken,
      this.fcmToken,
      this.socialLoginType,
      this.socialLoginId,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    dob = json['dob'];
    gender = json['gender'];
    image = json['image'];
    status = json['status'];
    resetToken = json['reset_token'];
    fcmToken = json['fcm_token'];
    socialLoginType = json['social_login_type'];
    socialLoginId = json['social_login_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['image'] = this.image;
    data['status'] = this.status;
    data['reset_token'] = this.resetToken;
    data['fcm_token'] = this.fcmToken;
    data['social_login_type'] = this.socialLoginType;
    data['social_login_id'] = this.socialLoginId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}