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