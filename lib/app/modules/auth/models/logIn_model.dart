class LogInModel {
  LogInModel({
     this.data,
     this.shortMessage,
     this.longMessage,
     this.status,
  });
   Data? data;
   String? shortMessage;
   String? longMessage;
   int? status;

  LogInModel.fromJson(Map<String, dynamic> json){
    data =json['data']==null? null :Data.fromJson(json['data']);
    shortMessage = json['short_message'];
    longMessage = json['long_message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data!.toJson();
    _data['short_message'] = shortMessage;
    _data['long_message'] = longMessage;
    _data['status'] = status;
    return _data;
  }
}

class Data {
  Data({
     this.id,
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
    this.profileUrl,
     this.countryCode,
     this.accessToken,
  });
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
   String? profileUrl;
   String? countryCode;
   String? accessToken;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    phone = json['phone'];
    userType = null;
    dob = null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isVerified = json['is_verified'];
    profileImage = json['profile_url'];
    profileUrl = json['profile_url'];
    countryCode = json['country_code'];
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['email_verified_at'] = emailVerifiedAt;
    _data['phone'] = phone;
    _data['user_type'] = userType;
    _data['dob'] = dob;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['is_verified'] = isVerified;
    _data['profile_image'] = profileImage;
    _data['country_code'] = countryCode;
    _data['access_token'] = accessToken;
    return _data;
  }
}