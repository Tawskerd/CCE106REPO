import 'package:socmed_part2/model/friend.dart';
import 'package:socmed_part2/model/userdata.dart'; 
import 'package:flutter/material.dart'; 

class Friendlist extends StatelessWidget { 
  Friendlist({super.key, required this.userdata});

  final Userdata userdata;
  var followTxtStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  Widget friendCard(Friend friend) => Card(
        child: Column(
          children: [
            Expanded(
              child: Image.asset(friend.img),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(friend.name),
            ),
          ],
        ),
      );

  Widget friendListGrid() => GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 100,
        ),
        itemCount: userdata.friendList.length,
        itemBuilder: (context, index) {
          return friendCard(userdata.friendList[index]);
        },
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: Row(
            children: [
              Text('Friends', style: TextStyle()),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 300,
          child: friendListGrid(),
        ),
        const SizedBox(height: 10),
        const Divider(color: Colors.grey),
      ],
    );
  }
}