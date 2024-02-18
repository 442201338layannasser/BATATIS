class UserModel {
  final String phonenumber;
  final String wallet = "0";

  UserModel({
    required this.phonenumber,
  });
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(phonenumber: map['phonenumber'],);
  }
  Map<String, dynamic> tomap() {
    return {
      "phonenumber": phonenumber,
      "wallet": wallet,
    };
  }
}
