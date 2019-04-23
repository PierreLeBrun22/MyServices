import 'package:flutter/material.dart';
import 'package:myservices/model/service.dart';
import 'package:myservices/Widgets/SameListView/plannet_summary.dart';

class OpenPackPage extends StatefulWidget {
  OpenPackPage({Key key, this.userId, this.services})
      : super(key: key);

  final String userId;
  final List<Service> services;

  @override
  State<StatefulWidget> createState() => new _OpenPackPageState();
}

class _OpenPackPageState extends State<OpenPackPage> {

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
                    (context, index) => new PlanetSummary(widget.services[index], widget.userId),
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
