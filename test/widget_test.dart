import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myservices/Widgets/OpenPack/OpenPackPage.dart';
import 'package:myservices/model/service.dart';
import 'package:image_test_utils/image_test_utils.dart';

List<Service> services = [
  const Service(
    name: "Daycare",
    location: "Lannion",
    description: "A coupon for 2 hours",
    image:
        "https://raw.githubusercontent.com/PierreLeBrun22/MyServices/master/assets/img/baby.png",
    partners: ["Daycare Lannion", "Baby Way"],
  ),
];

void main() {
  //Test functionnal
  testWidgets('Succes if the services are displayed', (WidgetTester tester) async {
    provideMockedNetworkImages(() async {
      
      Widget testWidget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(
              home: new Scaffold(
                  body: new Stack(
            children: <Widget>[
              new Container(
                padding: EdgeInsets.only(top: 60.0),
                child: new Column(children: <Widget>[
                  new OpenPackPage(
                    userId: 'CCZxC15nWMa4hWoK1r2susTbkUK2',
                    services: services,
                  )
                ]),
              ),
            ],
          ))));

      await tester.pumpWidget(testWidget);

      /// Now we can pump NetworkImages without crashing our tests. Yay
      expect(find.text('Daycare'), findsOneWidget);

      /// No crashes.
    });
  });
}
