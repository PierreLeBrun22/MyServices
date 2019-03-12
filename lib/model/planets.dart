class Planet {
  final String id;
  final String name;
  final String location;
  final String description;
  final String image;
  final String picture;

  const Planet({this.id, this.name, this.location,
    this.description, this.image, this.picture});
}

List<Planet> planets = [
  const Planet(
    id: "1",
    name: "Blancherisserie",
    location: "Lannion",
    description: "Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service.",
    image: "assets/img/blanchisserie.png",
    picture: "https://www.nasa.gov/sites/default/files/thumbnails/image/pia21723-16.jpg"
  ),
  const Planet(
    id: "2",
    name: "Cordonnerie",
    location: "Trégiuer",
    description: "Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service.",
    image: "assets/img/cordonnerie.png",
    picture: "https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/images/110411main_Voyager2_280_yshires.jpg"
  ),
  const Planet(
    id: "3",
    name: "Couture",
    location: "Perros-Guirec",
    description: "Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service.",
    image: "assets/img/couture.png",
    picture: "https://farm5.staticflickr.com/4086/5052125139_43c31b7012.jpg"
  ),
  const Planet(
    id: "4",
    name: "Pressing",
    location: "Lannion",
    description: "Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service.",
    image: "assets/img/pressing.png",
    picture: "https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/iss042e340851_1.jpg"
  ),
  const Planet(
    id: "5",
    name: "Repassage",
    location: "Lannion",
    description: "Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service. Ceci est la description du service.",
    image: "assets/img/repassage.png",
    picture: "https://c1.staticflickr.com/9/8105/8497927473_2845ae671e_b.jpg"
  ),
];