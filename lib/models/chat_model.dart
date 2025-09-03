import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel{
  Timestamp? dateTime;
  String? receiverId;
  String? senderId;
  String? text;
  ChatModel({this.dateTime, this.receiverId, this.senderId, this.text});

  ChatModel.fromJson(Map<String,dynamic> json){
    dateTime= json['dateTime'];
    receiverId = json['receiverId'];
    senderId = json['senderId'];
    text = json['text'];
  }

  Map<String,dynamic> toMap(){
    return{
      "dateTime":dateTime,
      "receiverId":receiverId,
      "senderId":senderId,
      "text":text,
    };
  }
}