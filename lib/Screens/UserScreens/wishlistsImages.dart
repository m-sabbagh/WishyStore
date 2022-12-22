import 'package:flutter/material.dart';

Image? wishlistImages(String? wishlistType) {
  if (wishlistType == 'Birthday') {
    return Image.asset(
      'images/wishlistTypes/birthday.jpeg',
      fit: BoxFit.cover,
    );
  } else if (wishlistType == 'Wedding') {
    return Image.asset(
      'images/wishlistTypes/wedding.jpeg',
      fit: BoxFit.cover,
    );
  } else if (wishlistType == 'Baby Shower') {
    return Image.asset(
      'images/wishlistTypes/baby_shower.png',
      fit: BoxFit.cover,
    );
  } else if (wishlistType == 'Graduation') {
    return Image.asset(
      'images/wishlistTypes/graduation.jpeg',
      fit: BoxFit.cover,
    );
  } else if (wishlistType == 'House Warming') {
    return Image.asset(
      'images/wishlistTypes/house_warming.jpeg',
      fit: BoxFit.cover,
    );
  } else if (wishlistType == 'Other') {
    return Image.asset(
      'images/wishlistTypes/other.jpeg',
      fit: BoxFit.cover,
    );
  }
}
