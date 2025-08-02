import 'package:flutter/material.dart';

///
class MessageInput extends StatelessWidget {
  ///
  final TextEditingController controller;

  ///
  final bool isEditing;

  ///
  final VoidCallback onSend;

  ///
  final VoidCallback onCancelEditing;

  ///
  const MessageInput({
    required this.controller,
    required this.isEditing,
    required this.onSend,
    required this.onCancelEditing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                fillColor: Colors.grey.shade300,
                filled: true,
                hintText: isEditing ? 'Edit message' : 'Enter message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: isEditing
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: onCancelEditing,
                      )
                    : null,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: onSend,
          icon: Icon(isEditing ? Icons.check : Icons.send, color: Colors.amber),
        ),
      ],
    );
  }
}
