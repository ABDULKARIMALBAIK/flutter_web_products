import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
// ignore: must_be_immutable
class User extends HiveObject implements Equatable {
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.token,
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  String username;
  @HiveField(2)
  String email;
  @HiveField(3)
  String firstName;
  @HiveField(4)
  String lastName;
  @HiveField(5)
  String gender;
  @HiveField(6)
  String image;
  @HiveField(7)
  String token;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"],
        image: json["image"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "image": image,
        "token": token,
      };

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, username, firstName, lastName, email, gender, image, token];

  @override
  // TODO: implement stringify
  bool? get stringify => true;
}
