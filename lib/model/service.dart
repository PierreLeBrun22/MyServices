import 'package:cloud_firestore/cloud_firestore.dart';

class Service {
  final String name;
  final String location;
  final String description;
  final String image;
  final List<dynamic> partners;
  final String serviceId;

  const Service({this.name, this.location,
    this.description, this.image, this.partners, this.serviceId});

  Service.fromSnapshot(DocumentSnapshot  snapshot) :
    name = snapshot.data["name"],
    location = snapshot.data["location"],
    description = snapshot.data["description"],
    image = snapshot.data["image"],
    partners = snapshot.data["partners"],
    serviceId = snapshot.documentID;

}