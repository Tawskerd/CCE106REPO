import 'package:flutter/material.dart';
import '../model/userdata.dart';

class InfoHeader extends StatelessWidget {
  final Userdata userdata;

  const InfoHeader({super.key, required this.userdata});

  final TextStyle followTextStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Followers'),
            Text('Following'),
            Text('Posts'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text( userdata.MyUserAccount.numFollowers,style: followTextStyle,
            ),
            Text( userdata.MyUserAccount.numFollowing,style: followTextStyle,
            ),
            Text(userdata.MyUserAccount.numPosts,style: followTextStyle,
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(color: Colors.grey),
      ],
    );
  }
}
