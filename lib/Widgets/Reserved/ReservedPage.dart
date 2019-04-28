import 'package:flutter/material.dart';
import 'package:myservices/model/service.dart';
import 'package:myservices/Widgets/Reserved/plannet_summary_reserved.dart';

class ReservedPage extends StatefulWidget {
  ReservedPage({Key key, this.userId, this.services})
      : super(key: key);

  final String userId;
  final List<Service> services;

  @override
  State<StatefulWidget> createState() => new _ReservedPageState();
}

class _ReservedPageState extends State<ReservedPage> {
  @override
  Widget build(BuildContext context) {
    if(widget.services.isEmpty) {
      return new Expanded(
      child: new Container(
        decoration: BoxDecoration(
          color: Color(0xFF302f33),
        ),
        child: Center(
          child: Text("You have not booked any services", style: TextStyle(fontFamily: 'Satisfy', color: Colors.white, fontSize: 27)),
        )
      ),
    );
    }
    else {
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
}
