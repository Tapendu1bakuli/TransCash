class SavedCardModel {
  SavedCardModel({
     this.shortMessage,
     this.longMessage,
     this.data,
     this.status,
  });
   String? shortMessage;
   String? longMessage;
   List<Data>? data;
   int? status;

  SavedCardModel.fromJson(Map<String, dynamic> json){
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
    required this.numberLast,
    required this.expMonth,
    required this.expYear,
  });
  late final int id;
  late final String numberLast;
  late final String expMonth;
  late final String expYear;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    numberLast = json['number_last'];
    expMonth = json['exp_month'];
    expYear = json['exp_year'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['number_last'] = numberLast;
    _data['exp_month'] = expMonth;
    _data['exp_year'] = expYear;
    return _data;
  }
}