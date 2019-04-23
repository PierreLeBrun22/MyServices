import 'package:flutter/material.dart';
import 'package:myservices/model/service.dart';
import 'package:myservices/Widgets/SameListView/plannet_summary.dart';
import 'package:myservices/Widgets/SameListView/separator.dart';
import 'package:myservices/text_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class DetailPage extends StatefulWidget {
  final Service planet;
  final String userId;

  DetailPage(this.planet, this.userId);

  State<StatefulWidget> createState() => new _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  int userAvailableServices;
  int _state = 0;
  Animation _animation;
  AnimationController _controller;
  GlobalKey _globalKey = GlobalKey();
  double _width = double.maxFinite;

  List<NewItem> items = <NewItem>[
    new NewItem(
      false,
      'OUR PARTNERS',
      new Icon(FontAwesomeIcons.building, color: Color(0xFF43e97b)),
      //give all your items here
    )
  ];

  void _getUserAvailableServices() async {
    CollectionReference ref = Firestore.instance.collection('user');
    QuerySnapshot eventsQuery = await ref.getDocuments();
    eventsQuery.documents.forEach((document) {
      if (document.data.containsKey(widget.userId)) {
        setState(() {
          userAvailableServices =
              document.data[widget.userId]['availableServices'];
        });
      }
    });
  }

  void _getDisponibility() async {
    CollectionReference ref = Firestore.instance.collection('userServices');
    QuerySnapshot eventsQuery = await ref.getDocuments();
    eventsQuery.documents.forEach((document) {
      if (document.data.containsValue(widget.userId) && document.data.containsValue(widget.planet.serviceId)) {
        setState(() {
          _state = 2;
        });
      }
    });
  }

  void _pushUserData() {
    if (userAvailableServices > 0) {
      Firestore.instance
          .collection('userServices')
          .add({"userId": widget.userId, "serviceId": widget.planet.serviceId});
    }
  }

  @override
  void initState() {
    _getUserAvailableServices();
    _getDisponibility();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        constraints: new BoxConstraints.expand(),
        color: Colors.white,
        child: new Stack(
          children: <Widget>[
            _getBackground(),
            _getGradient(),
            _getContent(),
            _getToolbar(context),
          ],
        ),
      ),
    );
  }

  Container _getBackground() {
    return new Container(
      color: Color(0xFF4B4954),
      constraints: new BoxConstraints.expand(height: 295.0),
    );
  }

  Container _getGradient() {
    return new Container(
      margin: new EdgeInsets.only(top: 190.0),
      height: 110.0,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: <Color>[new Color(0x00ffffff), new Color(0xFFffffff)],
          stops: [0.0, 0.9],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  Container _getContent() {
    final _overviewTitle = "Overview".toUpperCase();
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
                new Text(
                  _overviewTitle,
                  style: Style.headerTextStyle,
                ),
                new Separator(),
                new Text(widget.planet.description,
                    style: Style.commonTextStyle),
              ],
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
          _buttonReserve(context)
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
      child: new BackButton(color: Colors.white),
    );
  }

  Center _buttonReserve(BuildContext context) {
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
                      animateButton();
                      _pushUserData();
                    }
                  });
                },
                elevation: 4,
                color: Color(0xFF43e97b),
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
        "Reserve",
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
      return SizedBox(
        height: 36,
        width: 36,
        child: Icon(Icons.check, color: Colors.white)
      );
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

    Timer(Duration(milliseconds: 3300), () {
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
