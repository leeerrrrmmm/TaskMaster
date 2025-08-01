import 'package:flutter/material.dart';

///
class SendMsgWidget extends StatelessWidget {
  ///
  const SendMsgWidget({
    ///
    required this.messageController,

    ///
    required this.onTap,
    super.key,
  });

  ///
  final TextEditingController messageController;

  ///
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: messageController,
            decoration: const InputDecoration(hintText: 'Enter message'),
          ),
        ),
        IconButton(
          onPressed: onTap,
          icon: const Icon(Icons.send, color: Colors.amber),
        ),
      ],
    );
  }
}
