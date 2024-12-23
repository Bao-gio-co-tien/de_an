
class UserModel {
  final String? uid;
  final String fullName;
  final String userName;
  final String email;
  final String phoneNo;
  final String password;

  const UserModel({
    this.uid,
    required this.fullName,
    required this.email,
    required this.password,
    required this.userName,
    required this.phoneNo,
});

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'password': password,
      'userName': userName,
      'phoneNo': phoneNo,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String?,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      userName: json['userName'] as String,
      phoneNo: json['phoneNo'] as String,
    );
  }
}