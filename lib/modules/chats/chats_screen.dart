import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/user_model.dart';

import '../../core/shared/components/components.dart';
import '../../cubit/cubit.dart';
import 'chat_details_screen.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.users.length > 0,
          builder:
              (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder:
                    (context, index) =>
                        buildChatItem(context, cubit.users[index]),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: cubit.users.length,
              ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(BuildContext context, UserModel user) {
    return InkWell(
      onTap: () {
        navigateTo(context, ChatDetailsScreen(user:user));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                "${user.image}",
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${user.name}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${DateTime.now()}",
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall?.copyWith(fontSize: 7),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  "End message",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
