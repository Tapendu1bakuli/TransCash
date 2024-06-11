class TransactionHistoryModel {
  TransactionHistoryModel({
    this.shortMessage,
    this.longMessage,
    this.data,
    this.status,
  });
  String? shortMessage;
  String? longMessage;
  List<Data>? data;
  int? status;

  TransactionHistoryModel.fromJson(Map<String, dynamic> json){
    shortMessage = json['short_message'];
    longMessage = json['long_message'];
    data = (json['data'] == null ? null : List.from(json['data']).map((e)=>Data.fromJson(e)).toList());
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['short_message'] = shortMessage;
    _data['long_message'] = longMessage;
    _data['data'] = data!.map((e)=>e.toJson()).toList();
    _data['status'] = status;
    return _data;
  }
}

class Data {
  Data({
    this.id,
    this.status,
    this.amount,
    this.date,
    this.senderDetails,
    this.receiverDetails,
  });
  String? id;
  String? status;
  String? amount;
  String? date;
  TransactionDetails? senderDetails;
  ReceiverDetails? receiverDetails;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'] ?? "";
    status = json['status'];
    amount = json['amount'];
    date = json['date'];
    senderDetails = json['sender_details']==null?TransactionDetails.fromJson(json['receiver_Details']):TransactionDetails.fromJson(json['sender_details']);
    receiverDetails = (json["receiver_Details"] == null ? ReceiverDetails():TransactionDetails.fromJson(json["receiver_Details"])) as ReceiverDetails?;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['status'] = status;
    _data['amount'] = amount;
    _data['date'] = date;
    _data['sender_details'] = senderDetails!.toJson();
    return _data;
  }
}

class ReceiverDetails {
  ReceiverDetails({
     this.name,
     this.email,
     this.countryCode,
     this.phone,
     this.profilePhoto,
  });
   String? name;
   String? email;
   String? countryCode;
   String? phone;
   String? profilePhoto;

  ReceiverDetails.fromJson(Map<String, dynamic> json){
    name = json['name'];
    email = json['email'];
    countryCode = json['country_code'];
    phone = json['phone'];
    profilePhoto = json['profile_photo'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['email'] = email;
    _data['country_code'] = countryCode;
    _data['phone'] = phone;
    _data['profile_photo'] = profilePhoto;
    return _data;
  }
}

class TransactionDetails {
  TransactionDetails({
    this.name,
    this.email,
    this.countryCode,
    this.phone,
    this.profilePhoto,
  });
  String? name;
  String? email;
  String? countryCode;
  String? phone;
  String? profilePhoto;

  TransactionDetails.fromJson(Map<String, dynamic> json){
    name = json['name'];
    email = json['email'];
    countryCode = json['country_code'];
    phone = json['phone'];
    profilePhoto = json['profile_photo'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['email'] = email;
    _data['country_code'] = countryCode;
    _data['phone'] = phone;
    _data['profile_photo'] = profilePhoto;
    return _data;
  }
}
