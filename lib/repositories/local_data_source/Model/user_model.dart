class UserModel {
  int? id;
  String name;
  String password;
  String phoneNumber;
  String eMail;

  UserModel({
    this.id,
    required this.name,
    required this.password,
    required this.phoneNumber,
    required this.eMail,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["name"],
      password: json["password"],
      eMail: json["email"],
      phoneNumber: json["phonenumber"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['name'] = name;
    data['password'] = password;
    data['email'] = eMail;
    data['phonenumer'] = phoneNumber;

    return data;
  }

  // factory UserModel.fromMap(Map<String, dynamic> map) {
  //   return UserModel(
  //     id: map['Id'],
  //     usuario: map['Usuario'],
  //     senha: map['Senha'],
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'Usuario': usuario,
  //     'Senha': senha,
  //   };
  // }
}
