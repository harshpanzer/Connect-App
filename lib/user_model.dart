class UserModel {
  String? uid;
  String? email;
  String? userName;
  String? phoneno;
  String? organisation;
  String? bio;
  UserModel(
      {this.uid,
      this.email,
      this.userName,
      this.phoneno,
      this.organisation,
      this.bio});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        userName: map['userName'],
        phoneno: map['phoneno'],
        organisation: map['organisation'],
        bio: map['bio']);
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
    };
  }
}
