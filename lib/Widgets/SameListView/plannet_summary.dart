import 'package:flutter/material.dart';
import 'package:myservices/model/planets.dart';
import 'package:myservices/Widgets/SameListView/separator.dart';
import 'package:myservices/Widgets/SameListView/detail_page.dart';
import 'package:myservices/text_style.dart';

class PlanetSummary extends StatelessWidget {

  final Planet planet;
  final bool horizontal;

  PlanetSummary(this.planet, {this.horizontal = true});

  PlanetSummary.vertical(this.planet): horizontal = false;


  @override
  Widget build(BuildContext context) {

    final planetThumbnail = new Container(
      margin: new EdgeInsets.symmetric(
        vertical: 16.0
      ),
      alignment: horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,
      child: new Hero(
          tag: "planet-hero-${planet.id}",
          child: new Image.network(
          planet.image,
          height: 92.0,
          width: 92.0,
        ),
      ),
    );


    final planetCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(horizontal ? 76.0 : 16.0, horizontal ? 16.0 : 42.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(planet.name, style: Style.titleTextStyle),
          new Separator(),
          new Container(height: 10.0),
          new Text(planet.location, style: Style.locationTextStyle),
        ],
      ),
    );


    final planetCard = new Container(
      child: planetCardContent,
      height: horizontal ? 124.0 : 154.0,
      margin: horizontal
        ? new EdgeInsets.only(left: 46.0)
        : new EdgeInsets.only(top: 72.0),
      decoration: new BoxDecoration(
        color: Color(0xFF4B4954),
        border: Border.all(color: Color(0xFF43e97b), width: 0.3),
        shape: BoxShape.rectangle,
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 8.0),
          ),
        ],
        borderRadius: new BorderRadius.circular(8.0)
      ),
    );


    return new GestureDetector(
      onTap: horizontal
          ? () => Navigator.of(context).push(
            new PageRouteBuilder(
              pageBuilder: (_, __, ___) => new DetailPage(planet),
              transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                new FadeTransition(opacity: animation, child: child),
              ) ,
            )
          : null,
      child: new Container(
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[
            planetCard,
            planetThumbnail,
          ],
        ),
      )
    );
  }
}
