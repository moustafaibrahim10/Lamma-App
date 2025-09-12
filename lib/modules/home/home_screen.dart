import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/utils/app_images.dart';
import 'package:social_app/core/utils/enums.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/styles/icon_broken.dart';

import '../../core/shared/components/components.dart';
import '../../core/utils/app_constants.dart';

class HomeScreen extends StatelessWidget {
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.posts.length > 0 && userModel != null,
          builder:
              (context) => SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 10,
                      margin: EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Image(
                            image: NetworkImage(
                              "https://i.pinimg.com/736x/15/2e/dd/152edd489dd909fc30ab4ac4c1d8cc77.jpg",
                            ),
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Communicate with friends",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder:
                          (context, index) => buildPostItem(
                            cubit.posts[index],
                            context,
                            cubit,
                            index,
                          ),
                      separatorBuilder:
                          (context, index) => SizedBox(height: 8.0),
                      itemCount: cubit.posts.length,
                    ),
                    SizedBox(height: 8.0),
                  ],
                ),
              ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem(
    PostModel model,
    context,
    SocialCubit cubit,
    index,
  ) => Card(
    color: Colors.white,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5,
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("${model.image}"),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("${model.name}", style: TextStyle(height: 0.7)),
                        SizedBox(width: 5),
                        Icon(Icons.check_circle, color: Colors.blue, size: 15),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      "${model.dateTime}",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 15),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_horiz, size: 17),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: myDivider(),
          ),
          Text("${model.text}", style: Theme.of(context).textTheme.bodyMedium),
          // Padding(
          //   padding: const EdgeInsets.only(top: 5.0),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       crossAxisAlignment: WrapCrossAlignment.start,
          //       children: [
          //         Container(
          //           padding: const EdgeInsets.only(right: 5.0),
          //           height: 20,
          //           child: MaterialButton(
          //             padding: EdgeInsets.zero,
          //             minWidth: 1.0,
          //             onPressed: () {},
          //             child: Text(
          //               "#bookTest",
          //               style: Theme.of(
          //                 context,
          //               ).textTheme.titleSmall?.copyWith(color: Colors.blue),
          //             ),
          //           ),
          //         ),
          //         Container(
          //           padding: const EdgeInsets.only(right: 5.0),
          //           height: 20,
          //           child: MaterialButton(
          //             padding: EdgeInsets.zero,
          //             minWidth: 1.0,
          //             onPressed: () {},
          //             child: Text(
          //               "#development",
          //               style: Theme.of(
          //                 context,
          //               ).textTheme.titleSmall?.copyWith(color: Colors.blue),
          //             ),
          //           ),
          //         ),
          //         Container(
          //           padding: const EdgeInsets.only(right: 5.0),
          //           height: 20,
          //           child: MaterialButton(
          //             padding: EdgeInsets.zero,
          //             minWidth: 1.0,
          //             onPressed: () {},
          //             child: Text(
          //               "#software",
          //               style: Theme.of(
          //                 context,
          //               ).textTheme.titleSmall?.copyWith(color: Colors.blue),
          //             ),
          //           ),
          //         ),
          //         Container(
          //           padding: const EdgeInsets.only(right: 5.0),
          //           height: 20,
          //           child: MaterialButton(
          //             padding: EdgeInsets.zero,
          //             minWidth: 1.0,
          //             onPressed: () {},
          //             child: Text(
          //               "#MoustafaIbrahimYoussef",
          //               style: Theme.of(
          //                 context,
          //               ).textTheme.titleSmall?.copyWith(color: Colors.blue),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          if (model.postImage != '' && model.postImage != null)
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage("${model.postImage}"),
                  ),
                ),
              ),
            ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        Icon(IconBroken.Heart, size: 18, color: Colors.red),
                        SizedBox(width: 5),
                        Text(
                          "${cubit.likes[index]}",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {},
                ),
              ),
              Expanded(
                child: Container(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(IconBroken.Chat, size: 18, color: Colors.amber),
                          SizedBox(width: 5),
                          Text(
                            "${cubit.comments[cubit.postsIds[index]]?.length}",
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              ),
            ],
          ),
          myDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      showCommentsBottomSheet(context, cubit, index);
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 17,
                          backgroundImage: NetworkImage("${userModel!.image}"),
                        ),
                        SizedBox(width: 12),
                        Text(
                          "Write a comment ...",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        cubit.isLiked[index]
                            ? Icon(
                              IconBroken.Heart,
                              size: 18,
                              color: Colors.red,
                            )
                            : Icon(
                              IconBroken.Heart,
                              size: 18,
                              color: Colors.grey,
                            ),
                        SizedBox(width: 5),
                        Text(
                          "Like",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    cubit.likePost(cubit.postsIds[index], index);
                  },
                ),
                SizedBox(width: 20),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(IconBroken.Upload, size: 18, color: Colors.green),
                        SizedBox(width: 5),
                        Text(
                          "Share",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Future showCommentsBottomSheet(
    BuildContext context,
    SocialCubit cubit,
    postIndex,
  ) {
    cubit.getComments(cubit.postsIds[postIndex]);
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder:
          (context) => BlocBuilder<SocialCubit, SocialStates>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ConditionalBuilder(
                            condition:
                                cubit.comments[cubit.postsIds[postIndex]] !=
                                null,
                            builder:
                                (context) => ListView.separated(
                                  //shrinkWrap: true,
                                  //physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, commentIndex) {
                                    var postComments =
                                        cubit.comments[cubit
                                            .postsIds[postIndex]];
                                    var comment = postComments?[commentIndex];
                                    return Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 20,
                                                  backgroundImage: NetworkImage(
                                                    "${comment?.image}",
                                                  ),
                                                ),
                                                SizedBox(width: 12),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "${comment?.name}",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          "${comment?.date}",
                                                          style: Theme.of(
                                                                context,
                                                              )
                                                              .textTheme
                                                              .labelSmall
                                                              ?.copyWith(
                                                                fontSize: 7,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      "${comment?.comment}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium
                                                          ?.copyWith(
                                                            color:
                                                                Colors
                                                                    .grey[700],
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  separatorBuilder:
                                      (context, index) => SizedBox(height: 10),
                                  itemCount:
                                      cubit
                                          .comments[cubit.postsIds[postIndex]]
                                          ?.length ??
                                      0,
                                ),
                            fallback:
                                (context) => Center(
                                  child: Text(
                                    "No Comments Yet!",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],

                          //   borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(8.0),

                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                "${userModel!.image}",
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                controller: commentController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Write a comment ...",
                                ),
                                onChanged: (value) {
                                  (context as Element).markNeedsBuild();
                                },
                                cursorColor: AppConstants.primaryColor,
                              ),
                            ),

                            if (commentController.text.isNotEmpty)
                              IconButton(
                                onPressed: () {
                                  cubit.commentPost(
                                    cubit.postsIds[postIndex],
                                    commentController.text,
                                  );
                                  commentController.clear();
                                  showToast(
                                    msg: "Comment added",
                                    state: ToastState.success,
                                  );
                                  Focus.of(context).unfocus();
                                },
                                icon: Icon(
                                  IconBroken.Send,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                              ),
                            if (commentController.text.isEmpty)
                              Icon(
                                IconBroken.Send,
                                size: 20,
                                color: Colors.grey,
                              ),
                          ],
                        ),
                      ),
                      // SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}
