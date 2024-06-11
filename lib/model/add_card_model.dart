class AddCardModel {
  AddCardModel({
     this.shortMessage,
     this.longMessage,
     this.status,
  });
   String? shortMessage;
   String? longMessage;
   int? status;

  AddCardModel.fromJson(Map<String, dynamic> json){
    shortMessage = json['short_password'];
    longMessage = json['long_message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['short_password'] = shortMessage;
    _data['long_message'] = longMessage;
    _data['status'] = status;
    return _data;
  }
}