import 'dart:convert';

class Product {
  final int id;
  final String name;
  final List<String> images;

  const Product({
    required this.id,
    required this.name,
    required this.images,
  });

  String getFirstImage() {
    return images.isNotEmpty ? images[0] : '';
  }

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        images =
            json["carousel_images"].map<String>((e) => e.toString()).toList();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'carousel_images': getFirstImage(),
    };
  }

  Product.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        images = [(map['carousel_images'] ?? '')];
  
}
