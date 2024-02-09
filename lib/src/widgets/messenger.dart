import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/message.dart';
import '../providers/message_chat.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
          title: const Center(
            child: Text('Messanger'),
          ),
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontFamily: AutofillHints.addressCity
          ),
      ), // Puedo Añadir Nombres
      // body: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     Expanded(
      //       flex: 2,
      //       child: Consumer<ChatProvider>(
      //         builder: (context, chatProvider, _) => ListView.builder(
      //           itemCount: chatProvider.messages.length,
      //           itemBuilder: (context, index) {
      //             final message = chatProvider.messages[index];
      //             return Container(
      //
      //
      //               margin: const EdgeInsets.all(8.0),
      //               decoration: BoxDecoration(
      //                 color: theme.colorScheme.primary,
      //                 borderRadius: BorderRadius.circular(8.0),
      //               ),
      //               child: ListTile(
      //                 title: Text(
      //                   message.text,
      //                   style: theme.textTheme.bodyMedium!
      //                       .copyWith(color: theme.colorScheme.onPrimary),
      //                 ),
      //                 subtitle: Text('${message.timestamp}'),
      //                 trailing: const Column(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     Icon(Icons.check)
      //                   ],
      //                 ),
      //                 isThreeLine: true,
      //               ),
      //             );
      //           },
      //         ),
      //       ),
      //     ),
      //     const MessageInput(),
      //   ],
      // ),

      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: Consumer<ChatProvider>(
              builder: (context, chatProvider, _) => ListView.builder(
                itemCount: chatProvider.messages.length,
                itemBuilder: (context, index) {
                  final message = chatProvider.messages[index];
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width:300,
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(1.0),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondary,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ListTile(
                        title: Text(
                          message.text,
                          style: theme.textTheme.bodyText1!
                              .copyWith(color: theme.colorScheme.onPrimary),
                        ),
                        subtitle: Text('${message.timestamp}'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const MessageInput(),
        ],
      ),
    );
  }
}

class MessageInput extends StatefulWidget {
  const MessageInput({super.key});

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                fillColor: Colors.red,
                focusColor: Colors.red,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final text = _controller.text;
                    if (text.isNotEmpty) {
                      final message = Message(text, DateTime.now());
                      final chatProvider =
                      Provider.of<ChatProvider>(context, listen: false);
                      chatProvider.addMessage(message);
                      _controller.clear();
                    }
                  },
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                hintText: 'Mensaje',
              ),
              autofocus: true,
            ),
          ),

        ],
      ),
    );
  }
}
