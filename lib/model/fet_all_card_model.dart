class FetchAllBankModel {
  FetchAllBankModel({
     this.shortMessage,
     this.longMessage,
     this.data,
     this.status,
  });
   String? shortMessage;
   String? longMessage;
   List<Data>? data;
   int? status;

  FetchAllBankModel.fromJson(Map<String, dynamic> json){
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
    required this.id,
    required this.accHolderName,
    required this.accNumber,
    required this.bankName,
    required this.ifscCode,
    required this.type,
  });
  late final int id;
  late final String accHolderName;
  late final String accNumber;
  late final String bankName;
  late final String ifscCode;
  late final String type;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    accHolderName = json['acc_holder_name'];
    accNumber = json['acc_number'];
    bankName = json['bank_name'];
    ifscCode = json['ifsc_code'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['acc_holder_name'] = accHolderName;
    _data['acc_number'] = accNumber;
    _data['bank_name'] = bankName;
    _data['ifsc_code'] = ifscCode;
    _data['type'] = type;
    return _data;
  }
}