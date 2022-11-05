class UserModel {
  String? uid;
  String? email;
  String? userName;
  String? phoneno;
  String? organisation;
  String? bio;
  String? imageurl;
  String? imageurl1;
  UserModel({
    this.uid,
    this.email,
    this.userName,
    this.phoneno,
    this.organisation,
    this.bio,
    this.imageurl,
    this.imageurl1,
  });

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      userName: map['userName'],
      phoneno: map['phoneno'],
      organisation: map['organisation'],
      bio: map['bio'],
      imageurl: map['imageurl'],
      imageurl1: map['imageurl1'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'userName': userName,
      'phoneno': phoneno,
      'organisation': organisation,
      'bio': bio,
      'imageurl': imageurl,
      'imageurl1': imageurl1,
    };
  }
}
