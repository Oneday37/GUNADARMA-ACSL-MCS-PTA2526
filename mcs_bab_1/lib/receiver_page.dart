import 'package:flutter/material.dart';

class ReceiverPage extends StatefulWidget {
  String message;

  ReceiverPage({super.key, required this.message});

  @override
  State<ReceiverPage> createState() => _ReceiverPageState();
}

class _ReceiverPageState extends State<ReceiverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Message Page"), centerTitle: true),
      body: Center(child: Text(widget.message, style: TextStyle(fontSize: 30))),
    );
  }
}
