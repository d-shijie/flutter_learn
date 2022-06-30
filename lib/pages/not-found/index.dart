import 'package:flutter/material.dart';

class NotFound extends StatefulWidget {
  NotFound({Key? key}) : super(key: key);

  @override
  State<NotFound> createState() => _NotFoundState();
}

class _NotFoundState extends State<NotFound> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '404',
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
      ),
    );
  }
}
