import 'package:flutter/material.dart';
import 'package:myservices/services/authentication.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String SignOut = 'LOGOUT';

const List<String> choices = <String>[SignOut];

class ProfilPage extends StatefulWidget {
  ProfilPage({Key key, this.auth, this.onSignedOut, this.userId})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  void choiceAction(String choice) {
    if (choice == SignOut) {
      _signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('user').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return new Expanded(
              child: new Container(
            decoration: BoxDecoration(
              color: Color(0xFF302f33),
            ),
            child: Center(child: CircularProgressIndicator()),
          ));
        final record = snapshot.data.documents
            .where((data) => data.data.containsKey(widget.userId))
            .single
            .data[widget.userId];
        return new Expanded(
            child: new Container(
                color: Color(0xFF302f33),
                child: new ListView(children: <Widget>[
                  _logout(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Hero(
                        tag: 'assets/img/user.png',
                        child: Container(
                          height: 125.0,
                          width: 125.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(62.5),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/img/user.png'))),
                        ),
                      ),
                      SizedBox(height: 25.0),
                      Text(
                        record['firstName'] + " " + record['name'],
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 20.0),
                      ),
                      Text(
                        record['status'],
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF43e97b),
                            fontSize: 18.0),
                      ),
                      _userDetails(
                          record['company'], record['mail'], record['pack']),
                      _circularProgress(
                          record['availableServices'], record['usedServices'])
                    ],
                  )
                ])));
      },
    );
  }

  Widget _logout() {
    return new Container(
        margin: const EdgeInsets.only(right: 20.0, top: 20.0),
        alignment: Alignment.topRight,
        child: PopupMenuButton<String>(
          icon: new Icon(
            Icons.settings,
            color: Colors.white,
            size: 35.0,
          ),
          onSelected: choiceAction,
          itemBuilder: (BuildContext context) {
            return choices.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(
                  choice,
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
              );
            }).toList();
          },
        ));
  }

  Widget _userDetails(String _company, String _mail, String _pack) {
    return new Container(
      margin: EdgeInsets.all(10.0),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'COMPANY',
                  style: TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.0),
                Text(
                  _company,
                  style: TextStyle(
                      fontFamily: 'Poppins', color: Color(0xFF43e97b)),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'MAIL',
                  style: TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.0),
                Text(
                  _mail,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: 'Poppins', color: Color(0xFF43e97b)),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'PACK',
                  style: TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.0),
                Text(
                  _pack,
                  style: TextStyle(
                      fontFamily: 'Poppins', color: Color(0xFF43e97b)),
                )
              ],
            ),
          ],
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
    );
  }

  Widget _circularProgress(int availableServices, int usedServices) {
    final remainingServices = availableServices - usedServices;
    double percentage = remainingServices / availableServices;
    return new CircularPercentIndicator(
      radius: 120.0,
      lineWidth: 10.0,
      animation: true,
      percent: percentage,
      center: new Text(
        remainingServices.toString() + " / " + availableServices.toString(),
        style: new TextStyle(
            fontFamily: 'Poppins', color: Colors.white, fontSize: 20.0),
      ),
      footer: new Text(
        "Remaining services",
        style: new TextStyle(
            fontFamily: 'Poppins', color: Colors.white, fontSize: 17.0),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: Color(0xFF43e97b),
      backgroundColor: Colors.white,
    );
  }
}
