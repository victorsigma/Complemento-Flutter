import 'package:flutter/material.dart';
import 'package:mahs_yes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:mahs_yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  final ScrollController chatScrollController = ScrollController();
  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();

  List<Message> messages = [
    Message(text: "Ostias CHAVAL", fromWho: FromWho.me)
  ];

  Future<void> sendMessage(String value) async {
    if (value.trim().isEmpty) return;
    final newMessage = Message(text: value, fromWho: FromWho.me);

    messages.add(newMessage);

    if (value.trim().endsWith('?')) {
      await herMessage();
    }
    notifyListeners();
    moveScrollToBottom();
  }

  Future<void> herMessage() async {
    final herMessage = await getYesNoAnswer.getAnswer();

    messages.add(herMessage);
    notifyListeners();
    await moveScrollToBottom();
  }

  Future moveScrollToBottom() async {
    await Future.delayed(const Duration(microseconds: 100));
    chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut);
  }
}
