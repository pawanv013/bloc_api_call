// To parse this JSON data, do
//
//     final selectedProductModel = selectedProductModelFromJson(jsonString);

import 'dart:convert';

List<SelectedProductModel> selectedProductModelFromJson(String str) =>
    List<SelectedProductModel>.from(
        json.decode(str).map((x) => SelectedProductModel.fromJson(x)));

String selectedProductModelToJson(List<SelectedProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SelectedProductModel {
  SelectedProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.isAdded,
    this.rating,
  });

  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  bool? isAdded;
  Rating? rating;

  factory SelectedProductModel.fromJson(Map<String, dynamic> json) =>
      SelectedProductModel(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
        isAdded: json["isAdded"],
        rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "isAdded": isAdded,
        "rating": rating?.toJson(),
      };
}

class Rating {
  Rating({
    this.rate,
    this.count,
  });

  double? rate;
  int? count;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json["rate"]?.toDouble(),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };
}
