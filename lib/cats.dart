// To parse this JSON data, do
//
//     final cats = catsFromMap(jsonString);

import 'dart:convert';

List<Cats> catsFromMap(String str) => List<Cats>.from(json.decode(str).map((x) => Cats.fromMap(x)));

String catsToMap(List<Cats> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Cats {
  int id;
  String name;
  String origin;
  String temperament;
  List<String> colors;
  String description;
  String image;

  Cats({
    required this.id,
    required this.name,
    required this.origin,
    required this.temperament,
    required this.colors,
    required this.description,
    required this.image,
  });

  factory Cats.fromMap(Map<String, dynamic> json) => Cats(
    id: json["id"],
    name: json["name"],
    origin: json["origin"],
    temperament: json["temperament"],
    colors: List<String>.from(json["colors"].map((x) => x)),
    description: json["description"],
    image: json["image"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "origin": origin,
    "temperament": temperament,
    "colors": List<dynamic>.from(colors.map((x) => x)),
    "description": description,
    "image": image,
  };
}
