import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluchat/widgets/chat/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (context, AsyncSnapshot chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final chatDocs = chatSnapshot.data.docs;

        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (context, index) => ChatBubbles(
            chatDocs[index]['text'],
            chatDocs[index]['userId'] == user!.uid,
            chatDocs[index]['username'],
            chatDocs[index]['image_url'],
            key: ValueKey(chatDocs[index].id),
          ),
        );
      },
    );
  }
}
