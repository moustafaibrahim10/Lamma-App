import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/modules/search/profile_search_screen.dart';
import 'package:social_app/styles/icon_broken.dart';

import '../../core/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});


  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80.0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(IconBroken.Arrow___Left_2,color: Colors.grey,),
            ),
            title: defaultTextFormField(
              controller: searchController,
              icon: IconBroken.Search,
              labelText: "Search",
              validate: (value) {
                if (value == null || value.isEmpty)
                  return "Search must not be empty";
                else
                  return null;
              },
              submited: (value) {
                cubit.searchUser(value);
                return null;
              },
            ),
          ),
          body: ConditionalBuilder(
            condition: state is SearchSuccessState,
            builder:
                (context) => Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ListView.separated(
                    itemBuilder:
                        (context, index) => InkWell(
                          onTap: () {
                            cubit.getTargetUserPosts(targetUid: cubit.userSearch[index].uId.toString());
                            cubit.getUserById(cubit.userSearch[index].uId.toString());
                            navigateTo(
                              context,
                              ProfileSearchScreen(),
                            );
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  cubit.userSearch[index].image.toString(),
                                ),
                                radius: 30.0,
                              ),
                              SizedBox(width: 20.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(cubit.userSearch[index].name.toString()),
                                  SizedBox(height: 10.0),
                                  Text(
                                    cubit.userSearch[index].bio.toString(),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                    separatorBuilder: (context, index) => SizedBox(height: 20.0,),
                    itemCount: cubit.userSearch.length,
                  ),
                ),
            fallback:
                (context) =>
                    state is SearchLoadingState
                        ? Center(child: CircularProgressIndicator())
                        :
                    Center(
                          child: Container(child: Text("Enter a name to want to search for! ")),
                        ),
          ),
        );
      },
    );
  }
}
