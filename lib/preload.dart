import 'package:flutter/material.dart';

class PreloadWidget extends StatefulWidget {
  @override
  _PreloadWidgetState createState() => _PreloadWidgetState();
}

class _PreloadWidgetState extends State<PreloadWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.circular(16.0),
        color: Color.fromARGB(255, 236, 236, 236),
      ),
    );

  }
}
