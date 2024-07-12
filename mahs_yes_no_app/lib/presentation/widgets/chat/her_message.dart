import 'package:flutter/material.dart';
import 'package:mahs_yes_no_app/domain/entities/message.dart';

class HerMessage extends StatelessWidget {
  final Message message;

  const HerMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(message.text, style: TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(height: 10),
        if (message.image != null) _Image(image: message.image!),
        const SizedBox(height: 20)
      ],
    );
  }
}

class _Image extends StatelessWidget {
  final String image;

  const _Image({required this.image});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        image,
        width: size.width * 0.5,
        height: 150,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;

          return Container(
            width: size.width * 0.5,
            height: 150,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: const Text('Recibiendo imagen...'),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: size.width * 0.5,
            height: 150,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Colors.grey[300],
            child: Center(
              child: Icon(Icons.error),
            ),
          );
        },
      ),
    );
  }
}
