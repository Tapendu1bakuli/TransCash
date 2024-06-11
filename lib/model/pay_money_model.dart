class PayMoneyModel {
  PayMoneyModel({
     this.shortMessage,
     this.longMessage,
     this.status,
  });
   String? shortMessage;
   String? longMessage;
   int? status;

  PayMoneyModel.fromJson(Map<String, dynamic> json){
    shortMessage = json['short_message'];
    longMessage = json['long_message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['short_message'] = shortMessage;
    _data['long_message'] = longMessage;
    _data['status'] = status;
    return _data;
  }
}