import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MessageDisplay extends StatelessWidget {
  final String message;

  const MessageDisplay({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Not Found'),
        leading: IconButton(
          color: Colors.blue,
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            GoRouter.of(context).goNamed('productList');
          },
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        child: Center(
          child: SingleChildScrollView(
            child: Text(
              message,
              style: const TextStyle(
                  fontSize: 16, decoration: TextDecoration.none),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
