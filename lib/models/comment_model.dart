import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String? name;
  String? image;
  String? uId;
  String? comment;
  DateTime? date;

  CommentModel(this.name, this.image, this.uId, this.comment, this.date);

  CommentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    uId = json['uId'];
    comment = json['comment'];
    if(json['date'] is Timestamp)
      date=(json['date'] as Timestamp).toDate();
    else
    date = DateTime.tryParse(json['date']);
  }
  Map<String,dynamic> toMap()
  {
    return{
      "name": name,
      "image": image,
      "uId": uId,
      "comment": comment,
      "date": date,
    };
  }
}
