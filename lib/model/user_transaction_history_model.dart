class UserTransactionHistory {
  UserTransactionHistory({
     this.shortMessage,
     this.longMessage,
     this.data,
     this.totalReceive,
     this.totalPay,
     this.status,
  });
   String? shortMessage;
   String? longMessage;
   List<Data>? data;
   int? totalReceive;
   int? totalPay;
   int? status;

  UserTransactionHistory.fromJson(Map<String, dynamic> json){
    shortMessage = json['short_message'];
    longMessage = json['long_message'];
    data = (json['data'] == null ? null : List.from(json['data']).map((e)=>Data.fromJson(e)).toList());
    totalReceive = json['total_receive'];
    totalPay = json['total_pay'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['short_message'] = shortMessage;
    _data['long_message'] = longMessage;
    _data['data'] = data!.map((e)=>e.toJson()).toList();
    _data['total_receive'] = totalReceive;
    _data['total_pay'] = totalPay;
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
   SenderDetails? senderDetails;
   ReceiverDetails? receiverDetails;

  Data.fromJson(Map<String, dynamic> json){
    id = null;
    status = json['status'];
    amount = json['amount'];
    date = json['date'];
    senderDetails = SenderDetails.fromJson(json['sender_details']);
    receiverDetails = ReceiverDetails.fromJson(json['receiver_details']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['status'] = status;
    _data['amount'] = amount;
    _data['date'] = date;
    _data['sender_details'] = senderDetails!.toJson();
    _data['receiver_details'] = receiverDetails!.toJson();
    return _data;
  }
}

class SenderDetails {
  SenderDetails({
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

  SenderDetails.fromJson(Map<String, dynamic> json){
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