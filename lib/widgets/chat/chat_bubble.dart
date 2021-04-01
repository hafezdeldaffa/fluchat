import 'package:flutter/material.dart';

class ChatBubbles extends StatelessWidget {
  ChatBubbles(
    this.message,
    this.isMe,
    this.username,
    this.userImage, {
    this.key,
  });

  final String message;
  final bool isMe;
  final String userImage;
  final String username;

  final Key? key;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        Stack(
          children: [
            Row(
              mainAxisAlignment:
                  isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                if (!isMe)
                  Container(
                    padding: const EdgeInsets.only(left: 10, bottom: 30),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(userImage),
                    ),
                  ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      width: deviceSize.width * 0.45,
                      decoration: BoxDecoration(
                        color: isMe
                            ? Colors.grey[300]
                            : Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: !isMe ? Radius.zero : Radius.circular(12),
                          topRight: isMe ? Radius.zero : Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Text(
                            username,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: !isMe ? Colors.white : Colors.black,
                            ),
                            textAlign: isMe ? TextAlign.start : TextAlign.end,
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Text(
                            message,
                            style: TextStyle(
                              color: isMe
                                  ? Colors.black
                                  : Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .color,
                            ),
                            textAlign: isMe ? TextAlign.end : TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
          clipBehavior: Clip.none,
        ),
      ],
    );
  }
}
