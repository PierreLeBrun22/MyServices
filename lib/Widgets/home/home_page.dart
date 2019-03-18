import 'package:flutter/material.dart';
import 'package:myservices/services/authentication.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myservices/Widgets/Profile/ProfilMain.dart';
import 'package:myservices/Widgets/OpenPack/OpenPackPage.dart';
import 'package:myservices/Widgets/Reserved/ReservedPage.dart';
import 'package:myservices/Widgets/YourPack/YourPackPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

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

  void _resentVerifyEmail() {
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

  TextEditingController controller = new TextEditingController();
  String _searchText = "";

  Container _getAppBar() {
    return new Container(
      height: 60.0,
      color: Color(0xFF43e97b),
    );
  }

  Container _getSearchBar() {
    return new Container(
      margin: const EdgeInsets.only(top: 21.0, right: 8.0, left: 8.0),
      child: new Card(
        child: new ListTile(
          leading: new Icon(Icons.search),
          title: new TextField(
            controller: controller,
            decoration: new InputDecoration(
                hintText: 'Search', border: InputBorder.none),
          ),
          trailing: new IconButton(
            icon: new Icon(Icons.cancel),
            onPressed: () {
              controller.clear();
            },
          ),
        ),
      ),
    );
  }

  int _currentIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new Column(
        children: <Widget>[
          new ProfilPage(
            auth: widget.auth, onSignedOut: widget.onSignedOut),
          ]
        );
      case 1:
        return new Stack(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(top: 60.0),
              child:  new Column(children: <Widget>[
              YourPackPage(auth: widget.auth, onSignedOut: widget.onSignedOut, userId: widget.userId)
              ]
              ),
            ),
            _getAppBar(),
            _getSearchBar()
          ],
        );
      case 2:
        return new Stack(
          children: <Widget>[
           new Container(
              padding: EdgeInsets.only(top: 60.0),
              child:  new Column(children: <Widget>[
              OpenPackPage()
              ]
              ),
            ),
            _getAppBar(),
            _getSearchBar()
          ],
        );
      case 3:
        return new Stack(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(top: 60.0),
              child:  new Column(children: <Widget>[
              ReservedPage()
              ]
              ),
            ),
            _getAppBar(),
            _getSearchBar()
          ],
        );

      default:
        return new Center(
          child: new Text(
            'Error',
            style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Satisfy',
                fontWeight: FontWeight.w600,
                fontSize: 36.0),
          ),
        );
    }
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _getDrawerItemWidget(_currentIndex),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Color(0xFF4B4954),
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
        ),
        child: new BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.userAlt, color: Color(0xFF43e97b)),
              title: Text(
                'Profile',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.suitcase, color: Color(0xFF43e97b)),
              title: Text(
                'Your pack',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
            ),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.bookOpen, color: Color(0xFF43e97b)),
                title: Text(
                  'Open pack',
                  style: TextStyle(fontFamily: 'Poppins'),
                )),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.solidCalendar,
                    color: Color(0xFF43e97b)),
                title: Text(
                  'Reserved services',
                  style: TextStyle(fontFamily: 'Poppins'),
                ))
          ],
        ),
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
