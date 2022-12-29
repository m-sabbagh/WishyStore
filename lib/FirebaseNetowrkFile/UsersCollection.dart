// import  'dart:ffi';

class UsersCollection {
  String? firstname;
  String? email;
  String? lastname;
  String? password;
  String? userType;
  String? uId;

  UsersCollection(
      {this.firstname,
      this.email,
      this.lastname,
      this.password,
      this.userType,
      this.uId});

  factory UsersCollection.fromMap(Map<String, dynamic> Map) {
    return UsersCollection(
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
      if (userType == 'Store Owner') 'infoFilled': false,
      if (userType == 'Store Owner') 'storeOwnerGranted': false,

      // 'selectedItem': selectedItem,
    };
  }
}
