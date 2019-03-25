import 'package:flutter/material.dart';
import 'package:myservices/services/authentication.dart';

const String SignOut = 'LOGOUT';

const List<String> choices = <String>[SignOut];

class ProfilPage extends StatefulWidget {
  ProfilPage({Key key, this.auth, this.onSignedOut}) : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;

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
    return new Expanded(
        child: new Container(
            color: Color(0xFF4B4954),
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
                    'Pierre Le Brun',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 20.0),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    'Cadre',
                    style: TextStyle(fontFamily: 'Poppins', color: Colors.grey,fontSize: 15.0),
                  ),
                  _userDetails()
                ],
              )
            ])));
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

  Widget _userDetails() {
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
                  '24K',
                  style: TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.0),
                Text(
                  'FOLLOWERS',
                  style: TextStyle(fontFamily: 'Poppins', color: Colors.grey),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '31',
                  style: TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.0),
                Text(
                  'TRIPS',
                  style: TextStyle(fontFamily: 'Poppins', color: Colors.grey),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '21',
                  style: TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.0),
                Text(
                  'BUCKET LIST',
                  style: TextStyle(fontFamily: 'Poppins', color: Colors.grey),
                )
              ],
            )
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
}
