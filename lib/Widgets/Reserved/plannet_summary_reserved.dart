import 'package:flutter/material.dart';
import 'package:myservices/model/service.dart';
import 'package:myservices/Widgets/SameListView/separator.dart';
import 'package:myservices/Widgets/Reserved/detail_page_reserved.dart';
import 'package:myservices/text_style.dart';

class PlanetSummary extends StatefulWidget {

  final Service planet;
  final String userId;
  final bool horizontal;

  PlanetSummary(this.planet, this.userId, {this.horizontal = true});

  PlanetSummary.vertical(this.planet, this.userId): horizontal = false;

   @override
  State<StatefulWidget> createState() => new _PlanetSummaryState();
}

class _PlanetSummaryState extends State<PlanetSummary> {

  @override
  Widget build(BuildContext context) {

    final planetThumbnail = new Container(
      margin: new EdgeInsets.symmetric(
        vertical: 16.0
      ),
      alignment: widget.horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,
      child: new Hero(
          tag: "planet-hero-${widget.planet.name}",
          child: new Image.network(
          widget.planet.image,
          height: 92.0,
          width: 92.0,
        ),
      ),
    );


    final planetCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(widget.horizontal ? 76.0 : 16.0, widget.horizontal ? 16.0 : 42.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: widget.horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(widget.planet.name, style: Style.titleTextStyle),
          new Separator(),
          new Container(height: 10.0),
          new Text(widget.planet.location, style: Style.locationTextStyle),
        ],
      ),
    );


    final planetCard = new Container(
      child: planetCardContent,
      height: widget.horizontal ? 124.0 : 154.0,
      margin: widget.horizontal
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
      onTap: widget.horizontal
          ? () => Navigator.of(context).push(
            new PageRouteBuilder(
              pageBuilder: (_, __, ___) => new DetailPage(widget.planet, widget.userId),
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
