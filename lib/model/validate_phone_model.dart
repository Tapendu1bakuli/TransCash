class ValidatePhoneModel {
  String? shortMessage;
  String? longMessage;
  Data? data;
  int? status;

  ValidatePhoneModel(
      {this.shortMessage, this.longMessage, this.data, this.status});

  ValidatePhoneModel.fromJson(Map<String, dynamic> json) {
    shortMessage = json['short_message'];
    longMessage = json['long_message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['short_message'] = this.shortMessage;
    data['long_message'] = this.longMessage;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? phone;
  String? userType;
  String? dob;
  String? createdAt;
  String? updatedAt;
  int? isVerified;
  String? profileImage;
  String? countryCode;
  int? otpCode;
  int? isActive;

  Data(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.phone,
        this.userType,
        this.dob,
        this.createdAt,
        this.updatedAt,
        this.isVerified,
        this.profileImage,
        this.countryCode,
        this.otpCode,
        this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    phone = json['phone'];
    userType = json['user_type'];
    dob = json['dob'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isVerified = json['is_verified'];
    profileImage = json['profile_image'];
    countryCode = json['country_code'];
    otpCode = json['otp_code'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['phone'] = this.phone;
    data['user_type'] = this.userType;
    data['dob'] = this.dob;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_verified'] = this.isVerified;
    data['profile_image'] = this.profileImage;
    data['country_code'] = this.countryCode;
    data['otp_code'] = this.otpCode;
    data['is_active'] = this.isActive;
    return data;
  }
}
