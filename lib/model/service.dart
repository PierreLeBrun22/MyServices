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

/*List<Planet> planets = [
  const Planet(
    id: "1",
    name: "Daycare",
    location: "Lannion",
    description: "This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service.",
    image: "assets/img/baby.png",
    picture: "https://www.nasa.gov/sites/default/files/thumbnails/image/pia21723-16.jpg"
  ),
  const Planet(
    id: "2",
    name: "Bus",
    location: "Trégiuer",
    description: "This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service.",
    image: "assets/img/bus.png",
    picture: "https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/images/110411main_Voyager2_280_yshires.jpg"
  ),
  const Planet(
    id: "3",
    name: "Cinema",
    location: "Perros-Guirec",
    description: "This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service.",
    image: "assets/img/film.png",
    picture: "https://farm5.staticflickr.com/4086/5052125139_43c31b7012.jpg"
  ),
  const Planet(
    id: "4",
    name: "Restoration",
    location: "Lannion",
    description: "This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service.",
    image: "assets/img/manger.png",
    picture: "https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/iss042e340851_1.jpg"
  ),
  const Planet(
    id: "5",
    name: "Taxi",
    location: "Lannion",
    description: "This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service. This is a description of the service.",
    image: "assets/img/voiture.png",
    picture: "https://c1.staticflickr.com/9/8105/8497927473_2845ae671e_b.jpg"
  ),
]; */