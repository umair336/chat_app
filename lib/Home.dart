import 'dart:developer' as log;

import 'package:chat_app/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:tencent_cloud_chat_uikit/tencent_cloud_chat_uikit.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserScreen()),
              );
            },
          ),
        ],
      ),

      body: SafeArea(
        child: TIMUIKitConversation(
          onTapItem: (conversation) {
            log.log(encode(conversation.conversationID).toString());
          },
          itemBuilder: (V2TimConversation conversationItem, [V2TimUserStatus? onlineStatus]) {
            log.log(encode(conversationItem.toJson()).toString());
            return ListTile(
              title: Text(conversationItem.showName.toString()),
              subtitle: Text(conversationItem.lastMessage?.textElem!.text.toString() ?? ''),
            );
          },
        ),
      ),
    );
  }
}
