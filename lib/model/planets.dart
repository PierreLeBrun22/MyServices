import 'package:cloud_firestore/cloud_firestore.dart';

class Planet {
  final int id;
  final String name;
  final String location;
  final String description;
  final String image;

  const Planet({this.id, this.name, this.location,
    this.description, this.image});

  Planet.fromSnapshot(DocumentSnapshot  snapshot) :
    id = snapshot.data["id"],
    name = snapshot.data["name"],
    location = snapshot.data["location"],
    description = snapshot.data["description"],
    image = snapshot.data["image"];

  toJson() {
    return {
      "id": id,
      "name": name,
      "location": location,
      "description": description,
      "image": image,
    };
  }
}