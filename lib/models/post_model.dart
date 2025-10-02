class PostModel {
  String? name;
  String? image;
  String? uId;
  String? dateTime;
  String? text;
  String? postImage;
  String? postId;

  PostModel({

    this.name,
    this.image,
    this.uId,
    this.dateTime,
    this.text,
    this.postImage,
    this.postId,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    uId = json['uId'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];
    postId = json['postId'];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "image": image,
      "uId": uId,
      "dateTime": dateTime,
      "text": text,
      "postImage": postImage,
      "postId": postId,
    };
  }
}
