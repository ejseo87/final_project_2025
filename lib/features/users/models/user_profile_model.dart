class UserProfileModel {
  final String uid;
  final String email;
  final int createAt;

  UserProfileModel({
    required this.uid,
    required this.email,
    required this.createAt,
  });

  UserProfileModel.empty() : uid = "", email = "", createAt = 0;

  Map<String, dynamic> toJson() {
    return {"uid": uid, "email": email, "createAt": createAt};
  }

  UserProfileModel.fromJson(Map<String, dynamic> json)
    : uid = json["uid"],
      email = json["email"],
      createAt = json["createAt"];
}
