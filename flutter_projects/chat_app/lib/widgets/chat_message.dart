import 'package:chat_app/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No messages found'));
        }
        if (snapshot.hasError) {
          return const Center(
              child: Text(
                  'Something went horribly wrong! Please check on my mental state ASAP!'));
        }
        final loadedMessage = snapshot.data!.docs;
        return ListView.builder(
            padding: const EdgeInsets.only(bottom: 40, left: 13, right: 13),
            reverse: true,
            itemCount: loadedMessage.length,
            itemBuilder: (ctx, index) {
              final chatMessage = loadedMessage[index].data();
              // To see if the next Message is sent by the current user
              // index +1 is the next messge in line and if it exceed the boundary of the list of messages that the current User sent
              final nextChatMessage = index + 1 < loadedMessage.length
                  ? loadedMessage[index + 1].data()
                  : null;
              // We check the two Messages' senders UserId and compare it with each other
              // If it is different then the two messages are sent by two different user. otherwise, else :)
              final currentMessageUserId = chatMessage['userId'];
              final nextMessageUserId =
                  nextChatMessage != null ? nextChatMessage['userId'] : null;
              final nextUserIsSame = nextMessageUserId == currentMessageUserId;
              if (nextUserIsSame) {
                return MessageBubble.next(
                    message: chatMessage['text'],
                    isMe: authenticatedUser.uid == currentMessageUserId);
              } else {
                return MessageBubble.first(
                    userImage: chatMessage['userImage'],
                    username: chatMessage['username'],
                    message: chatMessage['text'],
                    isMe: authenticatedUser.uid == currentMessageUserId);
              }
            });
      },
    );
  }
}
