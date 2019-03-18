import 'package:flutter/material.dart';
import 'package:myservices/services/authentication.dart';

const String SignOut = 'LOGOUT';

const List<String> choices = <String>[
    SignOut
  ];
 
class ProfilPage extends StatefulWidget {
  ProfilPage({Key key, this.auth, this.onSignedOut})
      : super(key: key);

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

  void choiceAction(String choice){
    if(choice == SignOut){
      _signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Container(
        decoration: BoxDecoration(
          color: Color(0xFF302f33),
        ),
        child: new ListView(
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(right: 20.0, top: 20.0),
              alignment: Alignment.topRight,
              child: PopupMenuButton<String>(
                icon: new Icon(Icons.settings, color: Colors.white, size: 35.0,),
            onSelected: choiceAction,
            itemBuilder: (BuildContext context){
              return choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice, style: TextStyle(fontFamily: 'Poppins'),),
                );
              }).toList();
            },
          )
            ),
          ],
        )
      ),
    );
  }
}
