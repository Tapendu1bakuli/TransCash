class OTPSentForForgetPasswordModel {
  OTPSentForForgetPasswordModel({
    this.status,
    this.shortMessage,
    this.longMessage,
    this.data,
  });
  int? status;
  String? shortMessage;
  String? longMessage;
  Data? data;

  OTPSentForForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    shortMessage = json['short_message'];
    longMessage = json['long_message'];
    data = json['data'] == null ? null : Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['short_message'] = shortMessage;
    _data['long_message'] = longMessage;
    _data['data'] = data!.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.accessToken,
  });
  late final String accessToken;

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['access_token'] = accessToken;
    return _data;
  }
}
