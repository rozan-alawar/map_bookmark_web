class FavoriteResponse {
  int? code;
  String? massege;
  bool? success;
  List<dynamic>? data;

  FavoriteResponse({this.code, this.success, this.data, this.massege});

  FavoriteResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    massege = json['massege'];
    if (json['data'] != null) {
      data = <Favorite>[];
      json['data'].forEach((v) {
        data!.add(Favorite.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['success'] = success;
    data['massege'] = massege;

    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Favorite {
  String? sId;
  String? username;
  String? title;
  String? desc;
  String? long;
  String? lat;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Favorite(
      {this.sId,
      this.username,
      this.title,
      this.desc,
      this.long,
      this.lat,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Favorite.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    title = json['title'];
    desc = json['desc'];
    long = json['long'];
    lat = json['lat'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['username'] = username;
    data['title'] = title;
    data['desc'] = desc;
    data['long'] = long;
    data['lat'] = lat;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class AddToFavorite {
  int? code;
  String? massege;
  bool? success;
  Favorite? data;

  AddToFavorite({this.code, this.success, this.data, this.massege});

  AddToFavorite.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    massege = json['massege'];
    data = Favorite.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['success'] = success;
    data['massege'] = massege;

    if (this.data != null) {
      data['data'] = data;
    }
    return data;
  }
}
