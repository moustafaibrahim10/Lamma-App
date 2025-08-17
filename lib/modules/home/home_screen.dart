import 'package:flutter/material.dart';
import 'package:social_app/core/utils/app_images.dart';
import 'package:social_app/styles/icon_broken.dart';

import '../../core/shared/components/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => buildPostItem(context),
            separatorBuilder: (context, index) => SizedBox(height: 8.0),
            itemCount: 10,
          ),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }

  Widget buildPostItem(context) => Card(
    color: Colors.white,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5,
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  "https://i.pinimg.com/736x/82/0e/ea/820eea066798dd89e782dae4076b5684.jpg",
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Moustafa Ibrahim", style: TextStyle(height: 0.7)),
                        SizedBox(width: 5),
                        Icon(Icons.check_circle, color: Colors.blue, size: 15),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      "August 11, 2025 at 2.25 AM",
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
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Container(
              width: double.infinity,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 5.0),
                    height: 20,
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      minWidth: 1.0,
                      onPressed: () {},
                      child: Text(
                        "#bookTest",
                        style: Theme.of(
                          context,
                        ).textTheme.titleSmall?.copyWith(color: Colors.blue),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 5.0),
                    height: 20,
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      minWidth: 1.0,
                      onPressed: () {},
                      child: Text(
                        "#development",
                        style: Theme.of(
                          context,
                        ).textTheme.titleSmall?.copyWith(color: Colors.blue),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 5.0),
                    height: 20,
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      minWidth: 1.0,
                      onPressed: () {},
                      child: Text(
                        "#software",
                        style: Theme.of(
                          context,
                        ).textTheme.titleSmall?.copyWith(color: Colors.blue),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 5.0),
                    height: 20,
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      minWidth: 1.0,
                      onPressed: () {},
                      child: Text(
                        "#MoustafaIbrahimYoussef",
                        style: Theme.of(
                          context,
                        ).textTheme.titleSmall?.copyWith(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  "https://i.pinimg.com/736x/0b/27/26/0b27266d8545446e69957b8a537491fb.jpg",
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
                          "200",
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
                            "120 comment",
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
                    onTap: () {},
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 17,
                          backgroundImage: NetworkImage(
                            "https://i.pinimg.com/736x/82/0e/ea/820eea066798dd89e782dae4076b5684.jpg",
                          ),
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
                        Icon(IconBroken.Heart, size: 18, color: Colors.red),
                        SizedBox(width: 5),
                        Text(
                          "Like",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {},
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
}
