import 'package:flutter/material.dart';
import 'package:tencent_cloud_chat_uikit/business_logic/separate_models/tui_chat_separate_view_model.dart';
import 'package:tencent_cloud_chat_uikit/business_logic/view_models/tui_chat_global_model.dart';
import 'package:tencent_cloud_chat_uikit/tencent_cloud_chat_uikit.dart';
import 'package:tencent_cloud_chat_uikit/ui/controller/tim_uikit_chat_controller.dart';

class Chatscreen extends StatefulWidget {
  final V2TimConversation selectedConversation;
  final V2TimMessage? initFindingMessage;
  const Chatscreen({
    super.key,
    required this.selectedConversation,
    this.initFindingMessage,
  });

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  final TIMUIKitChatController _controller = TIMUIKitChatController();
  final TIMUIKitHistoryMessageListController _historyMessageListController =
      TIMUIKitHistoryMessageListController();
  final TIMUIKitInputTextFieldController _textFieldController =
      TIMUIKitInputTextFieldController();
  bool _haveMoreData = true;
  bool isInit = false;

  String? _getConvID() {
    return widget.selectedConversation.type == 1
        ? widget.selectedConversation.conversationID
        : widget.selectedConversation.groupID;
  }

  Future<bool> loadHistoryMessageList(
    String? lastMsgID,
    LoadDirection direction, [
    int? count,
    int? lastSeq,
  ]) async {
    if (_haveMoreData) {
      _haveMoreData = await _controller.loadHistoryMessageList(
        count: count ?? 20,
        direction: direction,
        userID: widget.selectedConversation.userID,
        groupID: widget.selectedConversation.groupID,
        lastMsgID: lastMsgID,
      );
    }
    return _haveMoreData;
  }

  @override
  Widget build(BuildContext context) {
    final isBuild = isInit;
    isInit = true;
    return TIMUIKitChatProviderScope(
      isBuild: isBuild,
      controller: _controller,
      // TIMUIKietChatController needs to be provided if you use it.
      config: const TIMUIKitChatConfig(),
      conversationID: _getConvID() ?? "",
      conversationType: ConvType.values[widget.selectedConversation.type ?? 1],
      builder: (context, model, w) {
        return GestureDetector(
          onTap: () {
            _textFieldController.hideAllPanel();
          },
          child: Scaffold(
            appBar: TIMUIKitAppBar(
              config: AppBar(
                title: Text(widget.selectedConversation.showName.toString()),
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: TIMUIKitHistoryMessageListSelector(
                      conversationID: _getConvID() ?? '',
                      builder: (context, messageList, index) {
                        return TIMUIKitHistoryMessageList(
                          conversation: widget.selectedConversation,
                          model: model,
                          messageList: messageList,
                          controller: _historyMessageListController,
                          onLoadMore: loadHistoryMessageList,
                          itemBuilder: (context, message) {
                            return TIMUIKitHistoryMessageListItem(
                              message: message!,
                              topRowBuilder: (context, message) {
                                return Row(
                                  children: [Text("this is top Raw builder")],
                                );
                              },
                              showMessageReadReceipt: false,
                              onScrollToIndex:
                                  _historyMessageListController.scrollToIndex,
                              onScrollToIndexBegin:
                                  _historyMessageListController
                                      .scrollToIndexBegin,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
