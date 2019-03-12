import 'package:flutter/material.dart';
import 'package:myservices/services/authentication.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myservices/Widgets/Profile/ProfilMain.dart';
import 'package:myservices/Widgets/OpenPack/OpenPackPage.dart';
import 'package:myservices/Widgets/Reserved/ReservedPage.dart';
import 'package:myservices/Widgets/YourPack/YourPackPage.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

        final drawerItems = [
    new DrawerItem("Profile",  FontAwesomeIcons.userAlt),
    new DrawerItem("Your pack",  FontAwesomeIcons.suitcase),
    new DrawerItem("Open pack",  FontAwesomeIcons.bookOpen),
    new DrawerItem("Reserved services",  FontAwesomeIcons.solidCalendar),
  ];

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  bool _isEmailVerified = false;

  @override
  void initState() {
    super.initState();
    _checkEmailVerification();
  }

  void _checkEmailVerification() async {
    _isEmailVerified = await widget.auth.isEmailVerified();
    if (!_isEmailVerified) {
      _showVerifyEmailDialog();
    }
  }

  void _resentVerifyEmail(){
    widget.auth.sendEmailVerification();
  }

  void _showVerifyEmailDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content: new Text("Please verify account in the link sent to email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Resent link"),
              onPressed: () {
                Navigator.of(context).pop();
                _resentVerifyEmail();
              },
            ),
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

  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new ProfilPage();
      case 1:
        return new YourPackPage();
      case 2:
        return new OpenPackPage();
      case 3:
        return new ReservedPage();

      default:
        return new Center(
              child: new Text(
                widget.drawerItems[_selectedDrawerIndex].title,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Error',
                    fontWeight: FontWeight.w600,
                    fontSize: 36.0),
              ),
            );
    }
  }
  
  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
         ListTile(
              leading: new Icon(
                d.icon,
                color: Colors.redAccent,
              ),
              title: new Text(d.title,
                    style: new TextStyle(fontSize: 17.0, fontFamily: 'Poppins')),
              selected: i == _selectedDrawerIndex,
          onTap: () => _onSelectItem(i),
            ),
      );
    }

    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return new Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
            new FlatButton(
                child: new Text('Logout',
                    style: new TextStyle(fontSize: 17.0, color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
                onPressed: _signOut)
          ],
        flexibleSpace: 
          new Container(
            padding: new EdgeInsets.only(top: statusBarHeight),
            height: statusBarHeight + 66.0,
            child: new Center(
              child: new Text(
                widget.drawerItems[_selectedDrawerIndex].title,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Satisfy',
                    fontWeight: FontWeight.w600,
                    fontSize: 36.0),
              ),
            ),
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [const Color(0xFFff1b0a), const Color(0xFFff968e)],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
      ),
     drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: new Column(
                children: <Widget>[
                   new Container(
            child: Center(
              child: new Icon(
                FontAwesomeIcons.handshake,
                color: Colors.white,
                size: 60.0,
              ),
            ),
          ),
                   new Center(
              child: new Text(
                'MyServices',
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Satisfy',
                    fontWeight: FontWeight.w600,
                    fontSize: 36.0),
              ),
            ),
                ],
              ),
              decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [const Color(0xFFff1b0a), const Color(0xFFff968e)],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            ),
            new Column(children: drawerOptions)
          ],
        ),
      ),
      body: new Column(
        children: <Widget>[
          _getDrawerItemWidget(_selectedDrawerIndex),
        ],
      ),
    );
  }
}

/*class GradientAppBar extends StatefulWidget {

  final String title;
  final double barHeight = 66.0;

  GradientAppBar(this.title);

  @override
  State<StatefulWidget> createState() => new _GradientAppBarState();
}

class _GradientAppBarState extends State<GradientAppBar> {

  _signOut() async {
    try {
      await HomePage.auth.signOut();
      HomePage().onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery
      .of(context)
      .padding
      .top;

    return new Container(
      padding: new EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + widget.barHeight,
      child: new Row(
  children: [
    new Center(
        child: new Text(widget.title,
          style:const TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 36.0
          ),
        ),
      ),
      new Container(
       child: new FlatButton(
                child: new Text('Logout',
                    style: new TextStyle(fontSize: 17.0, color: Colors.white)),
                onPressed: _signOut), 
      )
  ]
),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [
            const Color(0xFF3366FF),
            const Color(0xFF00CCFF)
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp
        ),
      ),
    );
  }
}*/
