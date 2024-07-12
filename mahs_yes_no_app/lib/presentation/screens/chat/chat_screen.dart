import 'package:flutter/material.dart';
import 'package:mahs_yes_no_app/domain/entities/message.dart';
import 'package:mahs_yes_no_app/presentation/providers/chat_provider.dart';
import 'package:mahs_yes_no_app/presentation/widgets/chat/my_message.dart';
import 'package:mahs_yes_no_app/presentation/widgets/chat/her_message.dart';
import 'package:mahs_yes_no_app/presentation/widgets/shared/message_field_box.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://media.tenor.com/jNccxJwSwVIAAAAi/valorant-omen-cat-dance.gif'),
          ),
        ),
        title: const Text('Usuario'),
        centerTitle: false,
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              controller: chatProvider.chatScrollController,
              itemCount: chatProvider.messages.length,
              itemBuilder: (context, index) {
                final message = chatProvider.messages[index];

                return (message.fromWho == FromWho.me)
                    ? MyMessage(message: message)
                    : HerMessage(message: message);
              },
            )),
            MessageFileBox(
              onValue: (value) => chatProvider.sendMessage(value),
              //onValue: chatProvider.sendMessage,
            )
          ],
        ),
      ),
    );
  }
}
