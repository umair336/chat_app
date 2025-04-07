import 'dart:developer' as log;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tencent_cloud_chat_uikit/tencent_cloud_chat_uikit.dart';

class ProfileScreen extends StatefulWidget {
  final String userID;
  const ProfileScreen({super.key, required this.userID});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              sendMessage(widget.userID, 'Hellow');
            },
            child: Icon(Icons.send),
          ),
        ],
      ),
      body: TIMUIKitProfile(
        userID: widget.userID,
        // builder: (context, userInfo, message, friendType, isMute) {
        //   log.log(encode(userInfo.toJson()));
        //   log.log(encode(message.toJson()));
        //   return TextButton(onPressed: (){}, child: const Text('Send Message'));
        // },
      ),
    );
  }

  Future<void> sendMessage(String reciever, String text) async {
    // step 1: create the message
    V2TimValueCallback<V2TimMsgCreateInfoResult> messagecreateResult =
        await TencentImSDKPlugin.v2TIMManager
            .getMessageManager()
            .createTextMessage(text: text);
    log.log(encode(messagecreateResult.data!.toJson()));

    log.log(encode(messagecreateResult.data!.id.toString()));
    if (messagecreateResult.code == 0) {
    } else {
      if (kDebugMode) {
        print(
          "Failed to create message: ${messagecreateResult.code} ${messagecreateResult.desc}",
        );
      }
    }
    if (messagecreateResult.data! == null &&
        messagecreateResult.data!.id != null) {
      // step 2: send the created message
      V2TimValueCallback<V2TimMessage> result = await TencentImSDKPlugin
          .v2TIMManager
          .getMessageManager()
          .sendMessage(
            id: messagecreateResult.data!.id!,
            receiver: reciever,
            groupID: '',
            
          );
      if (result.code == 0) {
        if (kDebugMode) {
          print("Message sent successfully: ${result.data}");
        }
      } else {
        if (kDebugMode) {
          print("Failed to send message: ${result.code} ${result.desc}");
        }
      }
    } else {
      if (kDebugMode) {
        print("Message creation failed");
      }
    }
  }
}
