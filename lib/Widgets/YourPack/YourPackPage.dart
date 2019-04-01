import 'package:flutter/material.dart';
import 'package:myservices/model/planets.dart';
import 'package:myservices/Widgets/SameListView/plannet_summary.dart';
import 'package:myservices/services/authentication.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:myservices/model/todo.dart';
import 'dart:async';

class YourPackPage extends StatefulWidget {
   YourPackPage({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _YourPackPageState();
}

class _YourPackPageState extends State<YourPackPage> {

   /*void initState() {
    super.initState();

    _todoList = new List();
    _todoQuery = _database
        .reference()
        .child("todo")
        .orderByChild("userId")
        .equalTo(widget.userId);
  }

   List<Todo> _todoList;

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  Query _todoQuery;*/

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Container(
        decoration: BoxDecoration(
          color: Color(0xFF302f33),
        ),
        child: new CustomScrollView(
          scrollDirection: Axis.vertical,
          shrinkWrap: false,
          slivers: <Widget>[
            new SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              sliver: new SliverList(
                delegate: new SliverChildBuilderDelegate(
                    (context, index) => new PlanetSummary(planets[index]),
                  childCount: planets.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}