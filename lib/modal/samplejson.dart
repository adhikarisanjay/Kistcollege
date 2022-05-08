import 'dart:convert';

class SampleJson {
  int? id;
  String? name;
  String? category;
  String? imageUrl;
  String? oldPrice;
  String? price;
  SampleJson({
    this.id,
    this.name,
    this.category,
    this.imageUrl,
    this.oldPrice,
    this.price,
  });

  factory SampleJson.fromMap(Map<String, dynamic> map) {
    return SampleJson(
      id: map['id']?.toInt(),
      name: map['name'],
      category: map['category'],
      imageUrl: map['imageUrl'],
      oldPrice: map['oldPrice'],
      price: map['price'],
    );
  }
}
