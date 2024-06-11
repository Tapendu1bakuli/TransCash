class UpdateProfileModel {
  UpdateProfileModel({
     this.status,
     this.shortMessage,
     this.longMessage,
  });
   int? status;
   String? shortMessage;
   String? longMessage;

  UpdateProfileModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    shortMessage = json['short_message'];
    longMessage = json['long_message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['short_message'] = shortMessage;
    _data['long_message'] = longMessage;
    return _data;
  }
}