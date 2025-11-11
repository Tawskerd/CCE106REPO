import 'package:flutter/material.dart';

import 'package:socmed_part2/model/userdata.dart';

import 'package:socmed_part2/views/mainheader.dart';
import 'package:socmed_part2/views/infoheader.dart';
import 'package:socmed_part2/views/friendlist.dart';
import 'package:socmed_part2/views/postlist.dart';

class SocialMedia extends StatefulWidget {
  const SocialMedia({super.key});

  @override
  State<SocialMedia> createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {
  late Userdata userdata;

  @override
  void initState() {
    userdata = Userdata();      
    super.initState();
  }

  final followTxtStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          MainHeader(userdata: userdata),
          InfoHeader(userdata: userdata),
          Friendlist(userdata: userdata),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text("Posts", style: followTxtStyle),
          ),

          const SizedBox(height: 20),

          PostList(userdata: userdata),
        ],
      ),
    );
  }
}
