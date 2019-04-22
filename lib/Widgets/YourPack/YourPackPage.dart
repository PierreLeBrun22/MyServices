import 'package:flutter/material.dart';
import 'package:myservices/model/planets.dart';
import 'package:myservices/Widgets/SameListView/plannet_summary.dart';
import 'package:myservices/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

/*final List<Planet> _planets = [
    const Planet(
      id: 1,
      name: "Mars",
      location: "Milkyway Galaxy",
      description: "Lorem ipsum...",
      image: "https://raw.githubusercontent.com/PierreLeBrun22/MyServices/master/assets/img/baby.png",
    ),
  ];*/

class _YourPackPageState extends State<YourPackPage> {
  List<Planet> _services;

  Future<String> _getData() async {
    CollectionReference ref = Firestore.instance.collection('user');
    QuerySnapshot eventsQuery = await ref.getDocuments();
    eventsQuery.documents.forEach((document) {
      if (document.data.containsKey(widget.userId)) {
        return document.data[widget.userId]['pack'];
      }
    });
  }

  void _getServices() async {
    List<Planet> _servicesList;
    CollectionReference ref = Firestore.instance.collection('packs');
    QuerySnapshot eventsQuery = await ref.getDocuments();
    eventsQuery.documents.forEach((document) {
      if (document['name'] == "Family") {
        for (var i = 0; i < document['services'].length; i++) {
          Firestore.instance
              .collection('services')
              .document(document['services'][i])
              .get()
              .then((DocumentSnapshot ds) {
            Planet service = new Planet(
                id: ds.data['id'],
                name: ds.data['name'],
                location: ds.data['location'],
                description: ds.data['description'],
                image: ds.data['image']);
            _servicesList.add(service);
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getServices();
  }

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Container(
        decoration: BoxDecoration(
          color: Color(0xFF302f33),
        ),
        /*child: new CustomScrollView(
          scrollDirection: Axis.vertical,
          shrinkWrap: false,
          slivers: <Widget>[
            new SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              sliver: new SliverList(
                delegate: new SliverChildBuilderDelegate(
                    (context, index) => new PlanetSummary(_services[index]),
                  childCount: _services.length,
                ),
              ),
            ),
          ],
        ),*/
      ),
    );
  }
}
