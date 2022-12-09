import 'package:flutter/material.dart';

Image? wishlistImages(String wishlistType) {
  if (wishlistType == 'Birthday') {
    return Image.asset(
      'images/birthday.jpeg',
      fit: BoxFit.cover,
    );
  } else if (wishlistType == 'Wedding') {
    return Image.asset(
      'images/wedding.jpeg',
      fit: BoxFit.cover,
    );
  } else if (wishlistType == 'Baby Shower') {
    return Image.asset(
      'images/baby_shower.png',
      fit: BoxFit.cover,
    );
  } else if (wishlistType == 'Graduation') {
    return Image.asset(
      'images/graduation.jpeg',
      fit: BoxFit.cover,
    );
  } else if (wishlistType == 'House Warming') {
    return Image.asset(
      'images/house_warming.jpeg',
      fit: BoxFit.cover,
    );
  }
// else if(wishlistType == 'Other'){
//   return Image.asset('images/other.png',                      fit: BoxFit.cover,
// );

// }
}
