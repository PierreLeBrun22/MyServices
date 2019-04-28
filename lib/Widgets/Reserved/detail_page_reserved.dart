import 'package:flutter/material.dart';
import 'package:myservices/model/service.dart';
import 'package:myservices/Widgets/SameListView/plannet_summary.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myservices/Widgets/SameListView/separator.dart';
import 'dart:async';
import 'package:myservices/services/fetch_data.dart' as dataFetch;

class DetailPage extends StatefulWidget {
  final Service planet;
  final String userId;

  DetailPage(this.planet, this.userId);

  State<StatefulWidget> createState() => new _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  int _state = 0;
  Animation _animation;
  AnimationController _controller;
  GlobalKey _globalKey = GlobalKey();
  double _width = double.maxFinite;

  List<NewItem> items = <NewItem>[
    new NewItem(
      false,
      'WHERE TO USE IT',
      new Icon(FontAwesomeIcons.questionCircle, color: Color(0xFF43e97b)),
    )
  ];

  void _serviceUsed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("You have used this service"),
          content: new Text(
              "You cannot cancel this booking, go back to the previous page"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        constraints: new BoxConstraints.expand(),
        color: Color(0xFF4B4954),
        child: new Stack(
          children: <Widget>[
            _getContent(),
            _getToolbar(context),
          ],
        ),
      ),
    );
  }

  Container _getContent() {
    final _overviewTitle = "How to use it ?".toUpperCase();
    return new Container(
      child: new ListView(
        padding: new EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 32.0),
        children: <Widget>[
          new PlanetSummary(
            widget.planet,
            widget.userId,
            horizontal: false,
          ),
          new Container(
            padding: new EdgeInsets.symmetric(horizontal: 32.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(_overviewTitle,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontFamily: 'Poppins')),
                new Separator(),
                new Text(
                    "This QR code works as a payment method, visit one of our partner companies and use it as a payment method. Simple, right? Once the QR code has been scanned, it will be impossible for you to cancel this service and this code will be unusable.",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontFamily: 'Poppins')),
              ],
            ),
          ),
          new Center(
            child: new Container(
              margin: EdgeInsets.all(10.0),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: new QrImage(
                  data: '["${widget.userId}", "${widget.planet.serviceId}"]',
                  size: 250.0,
                ),
              ),
              decoration: new BoxDecoration(
                  color: Color(0xFFffffff),
                  shape: BoxShape.rectangle,
                  boxShadow: <BoxShadow>[
                    new BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      offset: new Offset(0.0, 8.0),
                    ),
                  ],
                  borderRadius: new BorderRadius.circular(8.0)),
            ),
          ),
          new Padding(
            padding: new EdgeInsets.all(10.0),
            child: new ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  items[index].isExpanded = !items[index].isExpanded;
                });
              },
              children: items.map((NewItem item) {
                return new ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return new ListTile(
                        leading: item.iconpic,
                        title: new Text(
                          item.header,
                          textAlign: TextAlign.left,
                          style: new TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ));
                  },
                  isExpanded: item.isExpanded,
                  body: new Padding(
                      padding: new EdgeInsets.only(bottom: 20.0),
                      child: new Column(children: _panelList())),
                );
              }).toList(),
            ),
          ),
          _buttonCancel(context)
        ],
      ),
    );
  }

  List<Widget> _panelList() {
    List<Widget> panelList = [];
    for (var i = 0; i < widget.planet.partners.length; i++) {
      panelList.add(Text(widget.planet.partners[i].toUpperCase(),
          style: TextStyle(
              color: Color(0xFF4B4954),
              fontSize: 16.0,
              fontFamily: 'Poppins')));
      if (i != widget.planet.partners.length - 1) {
        panelList.add(Separator());
      }
    }
    return panelList;
  }

  Container _getToolbar(BuildContext context) {
    return new Container(
        margin: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: new BackButton(color: Colors.white));
  }

  Center _buttonCancel(BuildContext context) {
    return new Center(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 10,
        ),
        child: Align(
          alignment: Alignment.center,
          child: PhysicalModel(
            elevation: 8,
            shadowColor: Colors.black12,
            color: Color(0xFF43e97b),
            borderRadius: BorderRadius.circular(25),
            child: Container(
              key: _globalKey,
              height: 48,
              width: _width,
              child: RaisedButton(
                animationDuration: Duration(milliseconds: 1000),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: EdgeInsets.all(0),
                child: setUpButtonChild(),
                onPressed: () {
                  setState(() {
                    if (_state == 0) {
                      dataFetch.pushUserDataCancel(widget.userId,
                          widget.planet.serviceId, animateButton, _serviceUsed);
                    }
                  });
                },
                elevation: 4,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }

  setUpButtonChild() {
    if (_state == 0) {
      return Text(
        "Cancel the reservation",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          fontFamily: 'Satisfy',
        ),
      );
    } else if (_state == 1) {
      return SizedBox(
        height: 36,
        width: 36,
        child: CircularProgressIndicator(
          value: null,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      Navigator.maybePop(context);
    }
  }

  void animateButton() {
    double initialWidth = _globalKey.currentContext.size.width;

    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);

    _animation = Tween(begin: 0.0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {
          _width = initialWidth - ((initialWidth - 48) * _animation.value);
        });
      });
    _controller.forward();

    setState(() {
      _state = 1;
    });

    Timer(Duration(milliseconds: 1500), () {
      setState(() {
        _state = 2;
      });
    });
  }
}

class NewItem {
  bool isExpanded;
  final String header;
  final Icon iconpic;
  NewItem(this.isExpanded, this.header, this.iconpic);
}

double discretevalue = 2.0;
double hospitaldiscretevalue = 25.0;
