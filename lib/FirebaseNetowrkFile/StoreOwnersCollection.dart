// import  'dart:ffi';

class StoreOwnersCollection {
  String? firstname;
  String? email;
  String? lastname;
  String? password;
  String? userType;
  String? uId;

  StoreOwnersCollection(
      {this.firstname,
      this.email,
      this.lastname,
      this.password,
      this.userType,
      this.uId});

  factory StoreOwnersCollection.fromMap(Map<String, dynamic> Map) {
    return StoreOwnersCollection(
      firstname: Map['firstname'],
      email: Map['email'],
      lastname: Map['Lastname'],
      password: Map['password'],
      userType: Map['userType'],
      uId: Map['uId'],

      // selectedItem: Map['selectedItem'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'email': email,
      'Lastname': lastname,
      'password': password,
      'userType': userType,
      'uId': uId,

      // 'selectedItem': selectedItem,
    };
  }
}
