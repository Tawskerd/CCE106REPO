import 'package:flutter/material.dart';
import 'package:socmed_part2/model/userdata.dart';
import 'package:socmed_part2/widgets/post_card.dart';

class PostList extends StatelessWidget {
  final Userdata userdata;

  const PostList({super.key, required this.userdata});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: userdata.userList.length,
      itemBuilder: (context, index) {
        return PostCard(
          userdata: userdata,
          userpost: userdata.userList[index],
        );
      },
    );
  }
}