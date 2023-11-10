import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_flutter/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController messageController = TextEditingController();
  ScrollController scollController = ScrollController();
  bool isSwitch = false;

  void _sendMessage(String message) {
    if (message.isEmpty) {
      return;
    }

    final user = UserModel.fromJson({
      'id': '2',
      'name': 'Bibliothèque 2',
      'image': 'https://picsum.photos/250?image=202',
    });
    final newChat = ChatModel()
      ..id = '${int.parse(FakeChats.chats.last.id ?? '') + 1}'
      // ..id = Util.getID()
      ..message = message
      ..user = user;
    FakeChats.chats.add(newChat);
    messageController.clear();
    _scrollScreen();
    setState(() {});
  }

  void _deleteMessage(String id) {
    FakeChats.chats.removeWhere((element) => element.id == id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xff191970),
        body: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SlidableAutoCloseBehavior(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0)
                      .copyWith(top: 16.0, bottom: 20.0),
                  controller: scollController,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 14.0),
                  itemBuilder: (context, index) {
                    final chat = FakeChats.chats[index];
                    bool isMe = ((chat.user ?? UserModel()).id ?? '') == '2';
                    bool isRecalled = chat.isRecalled ?? false;
                    return Slidable(
                      key: ValueKey(chat.id),
                      startActionPane: isMe
                          ? null
                          : !isMe
                              ? _buildActionPaneOne(chat)
                              : !isRecalled
                                  ? _buildActionPaneTwo(chat)
                                  : _buildActionPaneThree(chat),
                      endActionPane: !isMe
                          ? null
                          : !isMe
                              ? _buildActionPaneOne(chat)
                              : !isRecalled
                                  ? _buildActionPaneTwo(chat)
                                  : _buildActionPaneThree(chat),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: isMe
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          if (!isMe) ...[
                            _buildAvatar(chat),
                            const SizedBox(width: 6.0),
                          ],
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: _buildMessageBox(
                                isMe, isRecalled, context, chat),
                          ),
                          if (isMe) ...[
                            const SizedBox(width: 6.0),
                            _buildAvatar(chat),
                          ],
                        ],
                      ),
                    );
                  },
                  itemCount: FakeChats.chats.length,
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ).copyWith(bottom: MediaQuery.of(context).viewInsets.bottom + 24.0),
          child: _buildWriteMessageBox(),
        ),
      ),
    );
  }

  TextField _buildWriteMessageBox() {
    return TextField(
      controller: messageController,
      onTap: () {
        Timer(
          const Duration(milliseconds: 600),
          () => _scrollScreen(),
        );
      },
      style: const TextStyle(color: Colors.orange),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xff383D3F).withOpacity(0.4),
        hintStyle: const TextStyle(color: Color(0xffB7B8BA), fontSize: 14.0),
        hintText: 'Lorem ipsum bla blu blo',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        suffixIcon: GestureDetector(
          onTap: () => _sendMessage(messageController.text.trim()),
          child: const Icon(Icons.send, color: Colors.white),
        ),
      ),
    );
  }

  ActionPane _buildActionPaneOne(ChatModel chat) {
    return ActionPane(
      motion: const DrawerMotion(),
      children: [
        SlidableAction(
          onPressed: (_) => _deleteMessage(chat.id ?? ''),
          backgroundColor: const Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.delete,
        ),
        SlidableAction(
          onPressed: (_) {},
          backgroundColor: const Color(0xFF21B7CA),
          foregroundColor: Colors.white,
          icon: Icons.cancel_outlined,
        ),
      ],
    );
  }

  ActionPane _buildActionPaneTwo(ChatModel chat) {
    return ActionPane(
      motion: const DrawerMotion(),
      children: [
        SlidableAction(
          onPressed: (_) => _deleteMessage(chat.id ?? ''),
          backgroundColor: const Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.delete,
        ),
        SlidableAction(
          onPressed: (_) {
            chat.isRecalled = true;
            setState(() {});
          },
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          icon: Icons.beach_access,
        ),
        SlidableAction(
          onPressed: (_) {},
          backgroundColor: const Color(0xFF21B7CA),
          foregroundColor: Colors.white,
          icon: Icons.cancel_outlined,
        ),
      ],
    );
  }

  ActionPane _buildActionPaneThree(ChatModel chat) {
    return ActionPane(
      motion: const DrawerMotion(),
      children: [
        SlidableAction(
          onPressed: (_) => _deleteMessage(chat.id ?? ''),
          backgroundColor: const Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.delete,
        ),
        SlidableAction(
          onPressed: (_) {
            chat.isRecalled = false;
            setState(() {});
          },
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          icon: Icons.restore,
        ),
        SlidableAction(
          onPressed: (_) {},
          backgroundColor: const Color(0xFF21B7CA),
          foregroundColor: Colors.white,
          icon: Icons.cancel_outlined,
        ),
      ],
    );
  }

  Padding _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(
        top: MediaQuery.of(context).padding.top + 6.0,
        bottom: 12.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/images/avt.png', width: 44.0),
          const Text(
            'Virtusl Coach',
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                color: Colors.white),
          ),
          Container(
            width: 122.0,
            height: 50.0,
            decoration: BoxDecoration(
              color: const Color(0xffFFFFFF).withOpacity(0.3),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 7.6, horizontal: 16.0),
                  child: Image.asset('assets/images/bird.png',
                      width: 42.0, height: 36.0),
                ),
                GestureDetector(
                  onTap: () => setState(() => isSwitch = !isSwitch),
                  child: Container(
                    width: 38.0,
                    height: 22.0,
                    padding: const EdgeInsets.all(2.4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(11.6),
                    ),
                    child: Align(
                      alignment: !isSwitch
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Container(
                        width: 18.0,
                        decoration: BoxDecoration(
                          color: isSwitch ? Colors.pink : Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  ClipRRect _buildAvatar(ChatModel chat) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: CachedNetworkImage(
        imageUrl: chat.user?.image ?? '',
        width: 32.0,
        height: 32.0,
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: SizedBox.square(
            dimension: 24.0,
            child: CircularProgressIndicator(strokeWidth: 2.6),
          ),
        ),
        errorWidget: (context, url, error) => const CircleAvatar(
          radius: 16.0,
          backgroundColor: Colors.orange,
          child: Icon(Icons.error_outline, color: Colors.white),
        ),
      ),
    );
  }

  Container _buildMessageBox(
      bool isMe, bool isRecalled, BuildContext context, ChatModel chat) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: isMe ? Colors.grey.withOpacity(0.5) : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isMe
              ? isRecalled
                  ? 0.0
                  : 16.0
              : 2.0),
          topRight: Radius.circular(isMe
              ? isRecalled
                  ? 0.0
                  : 2.0
              : 16.0),
          bottomLeft: Radius.circular(isRecalled ? 0.0 : 16.0),
          bottomRight: Radius.circular(isRecalled ? 0.0 : 16.0),
        ),
      ),
      // width: MediaQuery.of(context).size.width * 0.8,

      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.68),
      child: Text(
        chat.isRecalled ?? false
            ? 'The message is recalled'
            : chat.message ?? '-:-',
        style: TextStyle(
          color: isMe
              ? isRecalled
                  ? Colors.cyan
                  : Colors.orange
              : Colors.brown,
          fontSize: 14.0,
        ),
      ),
    );
  }

  void _scrollScreen() {
    scollController.animateTo(
      scollController.position.maxScrollExtent + 80.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
