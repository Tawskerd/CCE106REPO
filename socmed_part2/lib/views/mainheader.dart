import 'package:flutter/material.dart';
import '../model/userdata.dart';

class MainHeader extends StatelessWidget {
  final Userdata userdata;

  const MainHeader({super.key, required this.userdata});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(userdata.MyUserAccount.img),
          radius: 40,
        ),
        Text(
          userdata.MyUserAccount.name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        Text(userdata.MyUserAccount.email),
        const SizedBox(height: 20),
      ],
    );
  }
}
