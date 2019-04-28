import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myservices/model/service.dart';

Future<List<Service>> getServices(String userPack) async {
  Future<List<Service>> _servicesList;
  CollectionReference ref = Firestore.instance.collection('packs');
  QuerySnapshot eventsQuery = await ref.getDocuments();
  eventsQuery.documents.forEach((document) {
    if (document['name'] == userPack) {
      _servicesList = getServicesPack(document['services']);
    }
  });
  return _servicesList;
}

Future<List<Service>> getServicesOpenPack() async {
  Future<List<Service>> _servicesList;
  CollectionReference ref = Firestore.instance.collection('packs');
  QuerySnapshot eventsQuery = await ref.getDocuments();
  eventsQuery.documents.forEach((document) {
    if (document['name'] == "Open") {
      _servicesList = getServicesPack(document['services']);
    }
  });
  return _servicesList;
}

Future<List<Service>> getServicesPack(dynamic doc) async {
  List<Service> _servicesList = [];
  for (var i = 0; i < doc.length; i++) {
    await Firestore.instance
        .collection('services')
        .document(doc[i])
        .get()
        .then((DocumentSnapshot ds) {
      Service service = new Service(
          name: ds.data['name'],
          location: ds.data['location'],
          description: ds.data['description'],
          image: ds.data['image'],
          partners: ds.data['partners'],
          serviceId: ds.documentID);
      _servicesList.add(service);
    });
  }
  return _servicesList;
}

Future<List<Service>> getUserReservedServices(String userId) async {
  Future<List<Service>> _servicesList;
  List servicesId = [];
  CollectionReference ref = Firestore.instance.collection('userServices');
  QuerySnapshot eventsQuery = await ref.getDocuments();
  eventsQuery.documents.forEach((document) {
    if (document['userId'] == userId && document['used'] == false) {
      servicesId.add(document['serviceId']);
    }
  });
  _servicesList = getServicesPack(servicesId);
  return _servicesList;
}

void pushUserDataReserve(
    int userUsedServices,
    int userAvailableServices,
    String userId,
    String serviceId,
    void animateButton(),
    void _noMoreServices()) async {
  if (userUsedServices < userAvailableServices) {
    animateButton();
    Firestore.instance
        .collection('userServices')
        .add({"userId": userId, "serviceId": serviceId, "used": false});

    CollectionReference ref1 = Firestore.instance.collection('user');
    QuerySnapshot eventsQuery = await ref1.getDocuments();
    eventsQuery.documents.forEach((document) {
      if (document.data.containsKey(userId)) {
        Firestore.instance
            .collection('user')
            .document(document.documentID)
            .updateData(
          {userId + '.usedServices': document.data[userId]['usedServices'] + 1},
        );
      }
    });
  } else {
    _noMoreServices();
  }
}

void pushUserDataCancel(String userId, String serviceId, void animateButton(),
    void _serviceUsed()) async {
  CollectionReference ref1 = Firestore.instance.collection('userServices');
  QuerySnapshot eventsQuery = await ref1.getDocuments();
  CollectionReference ref2 = Firestore.instance.collection('user');
  QuerySnapshot eventsQuery2 = await ref2.getDocuments();
  eventsQuery.documents.forEach((document) {
    if (document.data.containsValue(userId) &&
        document.data.containsValue(serviceId)) {
      if (!document.data['used']) {
        animateButton();
        Firestore.instance
            .collection('userServices')
            .document(document.documentID)
            .delete();
        eventsQuery2.documents.forEach((document) {
          if (document.data.containsKey(userId)) {
            Firestore.instance
                .collection('user')
                .document(document.documentID)
                .updateData(
              {
                userId + '.usedServices':
                    document.data[userId]['usedServices'] - 1
              },
            );
          }
        });
      } else {
        _serviceUsed();
      }
    }
  });
}

void pushUserDataSignupProfile(String userID, String email, String firstName,
    String name, String company, String status, String pack) {
  if (status == 'Executive') {
    Firestore.instance.collection('user').add({
      userID: {
        "mail": email,
        "firstName": firstName,
        "name": name,
        "company": company,
        "status": status,
        "pack": pack,
        "availableServices": 10,
        "usedServices": 0
      }
    });
  } else {
    Firestore.instance.collection('user').add({
      userID: {
        "mail": email,
        "firstName": firstName,
        "name": name,
        "company": company,
        "status": status,
        "pack": pack,
        "availableServices": 5,
        "usedServices": 0
      }
    });
  }
}

void changePack(String userPack, String newPack, String userId) async {
  CollectionReference ref1 = Firestore.instance.collection('user');
  QuerySnapshot eventsQuery = await ref1.getDocuments();
  CollectionReference ref2 = Firestore.instance.collection('userServices');
  QuerySnapshot eventsQuery2 = await ref2.getDocuments();
  CollectionReference ref3 = Firestore.instance.collection('packs');
  QuerySnapshot eventsQuery3 = await ref3.getDocuments();

  eventsQuery.documents.forEach((document) {
    if (document.data.containsKey(userId)) {
      Firestore.instance
          .collection('user')
          .document(document.documentID)
          .updateData(
        {userId + '.pack': newPack},
      );
    }
  });

  eventsQuery3.documents.forEach((pack) {
    if (pack['name'] == userPack) {
        for (var i = 0; i < pack['services'].length ; i++) {
           eventsQuery2.documents.forEach((userServices) {
          if (userServices.data.containsValue(userId) &&
            userServices.data.containsValue(pack['services'][i])) {
          Firestore.instance
              .collection('userServices')
              .document(userServices.documentID)
              .delete();
            eventsQuery.documents.forEach((user) {
          if (user.data.containsKey(userId)) {
            Firestore.instance
                .collection('user')
                .document(user.documentID)
                .updateData(
              {
                userId + '.usedServices':
                    user.data[userId]['usedServices'] - 1
              },
            );
          }
        });
        }
        });
        }
    }
  });
}
