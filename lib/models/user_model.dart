
class FollowModel {
  String? name;
  String? image;
  String? uId;
  bool? isFollowing;

  FollowModel({
    this.name,
    this.image,
    this.uId,
    this.isFollowing,
  });
  FollowModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    image = json["image"];
    uId = json["uId"];
    isFollowing = json["isFollowing"];
  }
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "image": image,
      "uId": uId,
      "isFollowing": isFollowing,
    };
  }
}

class UserModel {
  String? name;
  String?nameLower;
  String? email;
  String? phone;
  String? password;
  String? uId;
  String? image;
  String? cover;
  String? bio;
  bool? isEmailVerified;
  double?lat;
  double? long;
  List<FollowModel>? followers;
  List<FollowModel>? following;

  UserModel({
    this.name,
    this.nameLower,
    this.email,
    this.phone,
    this.password,
    this.uId,
    this.isEmailVerified,
    this.image,
    this.bio,
    this.cover,
    this.lat,
    this.long,
    this.followers,
    this.following,
  });

  UserModel copyWith ({
    final String? name,
    final String? nameLower,
    final String? email,
    final String? phone,
    final String? password,
    final String? uId,
    final String? image,
    final String? cover,
    final String? bio,
    final bool? isEmailVerified,
    final double? lat,
    final double? long,
    final List<FollowModel>? followers,
    final List<FollowModel>? following,
}){
    return UserModel(
      name: name ?? this.name,
      nameLower: nameLower ?? this.nameLower,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      uId: uId ?? this.uId,
      image: image ?? this.image,
      cover: cover ?? this.cover,
      bio: bio ?? this.bio,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      lat: lat ?? this.lat ,
      long: long??this.long,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
}

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    nameLower = json["nameLower"];
    email = json["email"];
    phone = json["phone"];
    password = json["password"];
    uId = json["uId"];
    isEmailVerified = json["isEmailVerified"];
    image = json["image"];
    bio=json["bio"];
    cover=json["cover"];
    lat = json["lat"];
    long = json["long"];
    followers = json["followers"] != null ?
        List<FollowModel>.from(
          json["followers"].map((e)=>FollowModel.fromJson(e))
        ): null ;
    following= json["following"]!=null ?
        List<FollowModel>.from(
          json["following"].map((e)=> FollowModel.fromJson(e))
        ): null;
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "nameLower": name?.toLowerCase(),
      "email": email,
      "phone": phone,
      "uId":uId,
      "password": password,
      "isEmailVerified": isEmailVerified,
      "image": image,
      "bio":bio,
      "cover":cover,
      "lat": lat,
      "long":long,
      "followers": followers?.map((e) => e.toMap()).toList(),
      "following" : following?.map((e)=>e.toMap()).toList(),
    };
  }
}

