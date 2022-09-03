
class GetComment{
  Data? data;
  String? message;

  GetComment({this.data, this.message});

  GetComment.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? postLikes;
  Comments? comments;

  Data({this.postLikes, this.comments});

  Data.fromJson(Map<String, dynamic> json) {
    postLikes = json['post_likes'];
    comments = json['comments'] != null
        ?  Comments.fromJson(json['comments'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_likes'] = this.postLikes;
    if (this.comments != null) {
      data['comments'] = this.comments!.toJson();
    }
    return data;
  }
}

class Comments {
  int? count;
  List<Rows>? rows;

  Comments({this.count, this.rows});

  Comments.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <Rows>[];
      json['rows'].forEach((v) {
        rows!.add(new Rows.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rows {
  int? id;
  int? userId;
  int? postId;
  String? content;
  String? createdAt;
  String? createdDate;
  String? updatedAt;
  int? userIde;
  int? commentLikes;
  User? user;
  List<Replies>? replies;

  Rows(
      {this.id,
      this.userId,
      this.postId,
      this.content,
      this.createdAt,
      this.createdDate,
      this.updatedAt,
      this.userIde,
      this.commentLikes,
      this.user,
      this.replies});

  Rows.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    postId = json['postId'];
    content = json['content'];
    createdAt = json['createdAt'];
    createdDate = json['createdDate'];
    updatedAt = json['updatedAt'];
    userId = json['UserId'];
    commentLikes = json['comment_likes'];
    user = json['User'] != null ? new User.fromJson(json['User']) : null;
    if (json['Replies'] != null) {
      replies = <Replies>[];
      json['Replies'].forEach((v) {
        replies!.add(new Replies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['postId'] = this.postId;
    data['content'] = this.content;
    data['createdAt'] = this.createdAt;
    data['createdDate'] = this.createdDate;
    data['updatedAt'] = this.updatedAt;
    data['UserId'] = this.userId;
    data['comment_likes'] = this.commentLikes;
    if (this.user != null) {
      data['User'] = this.user!.toJson();
    }
    if (this.replies != null) {
      data['Replies'] = this.replies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  dynamic image;
  String? createdAt;
  String? createdDate;
  String? updatedAt;

  User(
      {this.id,
      this.name,
      this.email,
      this.image,
      this.createdAt,
      this.createdDate,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    createdAt = json['createdAt'];
    createdDate = json['createdDate'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['image'] = this.image;
    data['createdAt'] = this.createdAt;
    data['createdDate'] = this.createdDate;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Replies {
  int? id;
  int? userId;
  int? commentId;
  String? content;
  String? createdAt;
  String? createdDate;
  String? updatedAt;
  int? userIde;
  User? user;

  Replies(
      {this.id,
      this.userId,
      this.commentId,
      this.content,
      this.createdAt,
      this.createdDate,
      this.updatedAt,
      this.userIde,
      this.user});

  Replies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    commentId = json['commentId'];
    content = json['content'];
    createdAt = json['createdAt'];
    createdDate = json['createdDate'];
    updatedAt = json['updatedAt'];
    userId = json['UserId'];
    user = json['User'] != null ? new User.fromJson(json['User']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['commentId'] = this.commentId;
    data['content'] = this.content;
    data['createdAt'] = this.createdAt;
    data['createdDate'] = this.createdDate;
    data['updatedAt'] = this.updatedAt;
    data['UserId'] = this.userId;
    if (this.user != null) {
      data['User'] = this.user!.toJson();
    }
    return data;
  }
}