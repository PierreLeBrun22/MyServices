import 'package:flutter/material.dart';
import 'package:myservices/model/planets.dart';
import 'package:myservices/Widgets/Reserved/plannet_summary_reserved.dart';

class ReservedPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ReservedPageState();
}

class _ReservedPageState extends State<ReservedPage> {
  @override
  Widget build(BuildContext context) {
    return new Expanded(
      /*child: new Container(
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
      ),*/
    );
  }
}
