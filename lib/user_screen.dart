import 'package:chat_app/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:tencent_cloud_chat_uikit/ui/views/TIMUIKitAddFriend/tim_uikit_add_friend.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User')),
      body: TIMUIKitAddFriend(
        onTapAlreadyFriendsItem: (String userID) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen(userID: userID)),
          );
        },
      ),
    );
  }
}
