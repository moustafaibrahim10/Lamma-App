import 'package:flutter/material.dart';
import 'package:social_app/models/user_model.dart';

class ProfileSearchScreen extends StatelessWidget {
  final UserModel profileModel;
  const ProfileSearchScreen({ required this.profileModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 190,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          topRight: Radius.circular(4.0),
                        ),
                        image: DecorationImage(
                          image: NetworkImage('${profileModel?.cover}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 59,
                    backgroundColor:
                    Theme.of(context).scaffoldBackgroundColor,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundImage: NetworkImage(
                        '${profileModel?.image}',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Text(
              " ${profileModel?.name}",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 5),
            Text(
              "${profileModel?.bio}",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            "100",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            "Posts",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            "289",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            "Photos",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            "10K",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            "Following",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            "69",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            "Following",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // CacheHelper.removeData(key: 'uId');
                      // navigateTo(context, LoginScreen());

                    },
                    child: Text("Add friend"),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
