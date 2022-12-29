import 'package:flutter/material.dart';

class StoreItems {
  final String image, title, description;
  final int price, size, id;
  final Color color;
  StoreItems({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    required this.size,
    required this.color,
  });
}

List<StoreItems> storeitems = [
  StoreItems(
    id: 1,
    title: " iPhone 12 Pro Max",
    price: 999,
    size: 12,
    description: dummyText,
    image: "images/test.jpeg",
    color: Color.fromARGB(255, 17, 14, 35),
  ),
  StoreItems(
      id: 1,
      title: " iPhone 14 Pro Max",
      price: 699,
      size: 12,
      description: dummyText,
      image: "images/test2.jpeg",
      color: Color.fromARGB(255, 17, 14, 35)),
  StoreItems(
      id: 1,
      title: " iPad mini",
      price: 499,
      size: 12,
      description: dummyText,
      image: "images/test3.jpeg",
      color: Color.fromARGB(255, 17, 14, 35)),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
