class UserModel {
  String? name;
  String? email;
  String? phone;
  String? password;
  String? uId;
  String? image;
  String? cover;
  String? bio;
  bool? isEmailVerified;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.password,
    this.uId,
    this.isEmailVerified,
    this.image,
    this.bio,
    this.cover
  });

  UserModel copyWith ({
    final String? name,
    final String? email,
    final String? phone,
    final String? password,
    final String? uId,
    final String? image,
    final String? cover,
    final String? bio,
    final bool? isEmailVerified,
}){
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      uId: uId ?? this.uId,
      image: image ?? this.image,
      cover: cover ?? this.cover,
      bio: bio ?? this.bio,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    );
}

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    password = json["password"];
    uId = json["uId"];
    isEmailVerified = json["isEmailVerified"];
    image = json["image"];
    bio=json["bio"];
    cover=json["cover"];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "uId":uId,
      "password": password,
      "isEmailVerified": isEmailVerified,
      "image": image,
      "bio":bio,
      "cover":cover
    };
  }
}
