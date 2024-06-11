class AllNotificationModel {
  AllNotificationModel({
     this.shortMessage,
     this.longMessage,
     this.data,
     this.status,
  });
   String? shortMessage;
   String? longMessage;
   List<Data>? data;
   int? status;

  AllNotificationModel.fromJson(Map<String, dynamic> json){
    shortMessage = json['short_message'];
    longMessage = json['long_message'];
    data =  (json['data'] == null ? null : List.from(json['data']).map((e)=>Data.fromJson(e)).toList());
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
     this.userId,
     this.messageId,
     this.title,
     this.body,
     this.seen,
     this.createdAt,
     this.updatedAt,
  });
   int? id;
   String? userId;
   String? messageId;
   String? title;
   String? body;
   String? seen;
   String? createdAt;
   String? updatedAt;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['user_id'];
    messageId = json['message_id'];
    title = json['title'];
    body = json['body'];
    seen = json['seen'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['message_id'] = messageId;
    _data['title'] = title;
    _data['body'] = body;
    _data['seen'] = seen;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}