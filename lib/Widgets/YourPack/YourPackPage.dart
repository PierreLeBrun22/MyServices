import 'package:flutter/material.dart';
import 'package:myservices/model/service.dart';
import 'package:myservices/Widgets/SameListView/plannet_summary.dart';
import 'package:myservices/services/authentication.dart';

class YourPackPage extends StatefulWidget {
  YourPackPage({Key key, this.auth, this.userId, this.onSignedOut, this.userPack, this.services})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;
  final String userPack;
  final List<Service> services;

  @override
  State<StatefulWidget> createState() => new _YourPackPageState();
}

class _YourPackPageState extends State<YourPackPage> {
  
  @override
  void initState() {
    super.initState();
  }

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
                            (context, index) =>
                                new PlanetSummary(widget.services[index], widget.userId),
                            childCount: widget.services.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }
}
