import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/chat_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel user;
  TextEditingController messageController = TextEditingController();

  ChatDetailsScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(receiverId: user.uId.toString());
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            SocialCubit cubit = SocialCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(IconBroken.Arrow___Left_2),
                ),
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage("${user.image}"),
                    ),
                    SizedBox(width: 15.0),
                    Text(
                      "${user.name}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              body:ConditionalBuilder(
                  condition: cubit.messages.length > 0 && cubit.messages.isNotEmpty,
                  builder: (context)=>Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context,index){
                             if(cubit.messages[index].senderId == AppConstants.uId)
                               return buildMyMessage(cubit.messages[index],context);
                             return buildMessage(cubit.messages[index],context);
                            },
                            separatorBuilder: (context,index)=>SizedBox(height: 15,),
                            itemCount: cubit.messages.length,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                          ),
                        ),
                        SizedBox(height: 15,),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Write a message...",
                                  ),
                                  onChanged: (value) {
                                    (context as Element).markNeedsBuild();
                                  },
                                ),
                              ),
                              if (messageController.text.isNotEmpty)
                                IconButton(
                                  onPressed: () {
                                    cubit.sendMessage(
                                      receiverId: user.uId.toString(),
                                      text: messageController.text,
                                    );
                                    messageController.clear();
                                  },
                                  icon: Icon(IconBroken.Send),
                                ),
                              if (messageController.text.isEmpty)
                                Icon(IconBroken.Send, color: Colors.grey),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  fallback: (context)=>Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(child: Center(child: Text(" No messages yet \n Start a conversation"))),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Write a message...",
                                  ),
                                  onChanged: (value) {
                                    (context as Element).markNeedsBuild();
                                  },
                                ),
                              ),
                              if (messageController.text.isNotEmpty)
                                IconButton(
                                  onPressed: () {
                                    cubit.sendMessage(
                                      receiverId: user.uId.toString(),
                                      text: messageController.text,
                                    );
                                    messageController.clear();
                                  },
                                  icon: Icon(IconBroken.Send),
                                ),
                              if (messageController.text.isEmpty)
                                Icon(IconBroken.Send, color: Colors.grey),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
              ),
            );
          },
        );
      }
    );
  }
  Widget buildMessage(ChatModel chatModel,BuildContext context)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text("${chatModel.text}",style:TextStyle(fontSize: 14),),
          SizedBox(height: 5,),
          Text("${chatModel.dateTime?.toDate().toString()}",style: Theme.of(
            context,
          ).textTheme.labelSmall?.copyWith(fontSize: 5),
          ),
        ],
      ),
    ),
  );
  Widget buildMyMessage(ChatModel chatModel,BuildContext context)=>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: AppConstants.primaryColor.withOpacity(0.25),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${chatModel.text}",style:TextStyle(fontSize: 14),),
          SizedBox(height: 5,),
          Text("${chatModel.dateTime?.toDate().toString()}",style: Theme.of(
            context,
          ).textTheme.labelSmall?.copyWith(fontSize: 6),
          ),
        ],
      ),
    ),
  );

}
