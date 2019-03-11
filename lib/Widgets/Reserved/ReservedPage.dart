import 'package:flutter/material.dart';

class ReservedPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ReservedPageState();
}

class _ReservedPageState extends State<ReservedPage> {
  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.05), BlendMode.dstATop),
            image: AssetImage('assets/img/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
