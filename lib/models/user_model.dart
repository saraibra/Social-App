class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uid;
  String? image;
  String? bio;
  String? cover;

  bool? isEmailVerified;
  UserModel(
      {this.name,
      this.email,
      this.phone,
      this.uid,
      this.isEmailVerified,
      this.image,
      this.cover,
      this.bio});
  UserModel.fromJson(Map<String, dynamic>? json) {
    email = json!['email'];
    name = json['name'];
    phone = json['phone'];
    uid = json['uid'];
    image = json['image'];
    cover = json['cover'];

    bio = json['bio'];

    isEmailVerified = json['isEmailVerified'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uid': uid,
      'image': image,
      'cover': cover,
      'bio': bio,
      'isEmailVerified': isEmailVerified
    };
  }
}
