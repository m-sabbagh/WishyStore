// import  'dart:ffi';

class StoreOwnersCollection {
  String? firstname;
  String? email;
  String? lastname;
  String? password;
  String? userType;
  String? uId;
  bool? infoFilled = false;
  bool? storeOwnerGranted = false;

  StoreOwnersCollection({
    this.firstname,
    this.email,
    this.lastname,
    this.password,
    this.userType,
    this.uId,
    this.infoFilled,
    this.storeOwnerGranted,
  });

  factory StoreOwnersCollection.fromMap(Map<String, dynamic> Map) {
    return StoreOwnersCollection(
      firstname: Map['firstname'],
      email: Map['email'],
      lastname: Map['Lastname'],
      password: Map['password'],
      userType: Map['userType'],
      uId: Map['uId'],
      infoFilled: Map['infoFilled'],
      storeOwnerGranted: Map['storeOwnerGranted'],

      //store owner granted = false by default
      //aftr storeowner gets granted = true from admin , the store owner will be allowed to enter the store information
      // he will be able to manage the store
      // if the user entered his info he will be able to enter the store page

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
      'infoFilled': infoFilled,

      'storeOwnerGranted': storeOwnerGranted,

      // 'selectedItem': selectedItem,
    };
  }
}
