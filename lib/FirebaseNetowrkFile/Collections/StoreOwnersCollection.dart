class StoreOwnersCollection {
  String? firstname;
  String? email;
  String? lastname;
  String? password;
  String? userType;
  String? uId;
  bool? storeOwnerGranted = false;
  String? storeType;
  String? storeName;
  String? phoneNumber;
  String? supportEmail;
  Map? categories;

  StoreOwnersCollection({
    this.firstname,
    this.email,
    this.lastname,
    this.password,
    this.userType,
    this.uId,
    this.storeOwnerGranted,
    this.storeType,
    this.storeName,
    this.phoneNumber,
    this.supportEmail,
    this.categories,
  });

  factory StoreOwnersCollection.fromMap(Map<String, dynamic> Map) {
    return StoreOwnersCollection(
      firstname: Map['firstname'],
      email: Map['email'],
      lastname: Map['Lastname'],
      password: Map['password'],
      userType: Map['userType'],
      uId: Map['uId'],
      storeOwnerGranted: Map['storeOwnerGranted'],
      storeType: Map['storeType'],
      storeName: Map['storeName'],
      phoneNumber: Map['phoneNumber'],
      supportEmail: Map['supportEmail'],
      categories: Map['categories'],
      //store owner granted = false by default
      //aftr storeowner gets granted = true from admin , the store owner will be allowed to enter the store information
      // he will be able to manage the store
      // if the user entered his info he will be able to enter the store page
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
      'storeOwnerGranted': storeOwnerGranted,
      'storeType': storeType,
      'storeName': storeName,
      'phoneNumber': phoneNumber,
      'supportEmail': supportEmail,
      'categories': categories,
    };
  }
}
