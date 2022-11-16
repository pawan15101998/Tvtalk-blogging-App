class AdClass {
  bool? ok;
  String? message;
  List<MarkRead>? markRead;

  AdClass({this.ok, this.message, this.markRead});

  AdClass.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    message = json['message'];
    if (json['markRead'] != null) {
      markRead = <MarkRead>[];
      json['markRead'].forEach((v) {
        markRead!.add(new MarkRead.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this.ok;
    data['message'] = this.message;
    if (this.markRead != null) {
      data['markRead'] = this.markRead!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MarkRead {
  int? id;
  String? title;
  int? adType;
  String? content;
  bool? isShow;
  dynamic link;
  String? createdAt;
  String? updatedAt;

  MarkRead(
      {this.id,
      this.title,
      this.adType,
      this.content,
      this.isShow,
      this.link,
      this.createdAt,
      this.updatedAt});

  MarkRead.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    adType = json['adType'];
    content = json['content'];
    isShow = json['isShow'];
    link = json['link'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['adType'] = this.adType;
    data['content'] = this.content;
    data['isShow'] = this.isShow;
    data['link'] = this.link;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}