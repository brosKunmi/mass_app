import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mass_app/utilities/extensions/utility_strings.dart';

class Massian {
  final String name;
  final String id;
  String phoneNumber;
  final String email;
  bool volunteer;
  bool disciple;
  String state;
  String gender;
  String image;
  String age;
  String occupation;
  String school;
  String city;
  Massian({
    required this.name,
    required this.id,
    required this.email,
    this.phoneNumber = '',
    this.volunteer = false,
    this.disciple = false,
    this.state = '',
    this.gender = '',
    this.image = UtilityStrings.imageString,
    this.age = '',
    this.occupation = '',
    this.school = '',
    this.city = '',
  });

  Massian copyWith({
    String? name,
    String? id,
    String? phoneNumber,
    String? email,
    bool? volunteer,
    bool? disciple,
    String? city,
    String? state,
    String? gender,
    String? image,
    String? age,
    String? occupation,
    String? school,
  }) {
    return Massian(
      name: name ?? this.name,
      id: id ?? this.id,
      city: city ?? this.city,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      volunteer: volunteer ?? this.volunteer,
      disciple: disciple ?? this.disciple,
      state: state ?? this.state,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      age: age ?? this.age,
      occupation: occupation ?? this.occupation,
      school: school ?? this.school,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'city': city,
      'id': id,
      'phoneNumber': phoneNumber,
      'email': email,
      'volunteer': volunteer,
      'disciple': disciple,
      'state': state,
      'gender': gender,
      'image': image,
      'age': age,
      'occupation': occupation,
      'school': school,
    };
  }

  factory Massian.fromMap(DocumentSnapshot map) {
    return Massian(
      name: map['name'] ?? '',
      id: map['id'] ?? '',
      city: map['city'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      email: map['email'] ?? '',
      volunteer: map['volunteer'] ?? false,
      disciple: map['disciple'] ?? false,
      state: map['state'] ?? '',
      gender: map['gender'] ?? '',
      image: map['image'] ?? '',
      age: map['age'] ?? '',
      occupation: map['occupation'] ?? '',
      school: map['school'] ?? '',
    );
  }

  static Massian empty = Massian(name: '', id: '', phoneNumber: '', email: '');

  String toJson() => json.encode(toMap());

  factory Massian.fromJson(String source) =>
      Massian.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Massian(name: $name, id: $id, phoneNumber: $phoneNumber, email: $email, volunteer: $volunteer, disciple: $disciple, state: $state, gender: $gender, image: $image, age: $age, occupation: $occupation, school: $school, city: $city)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Massian &&
        other.name == name &&
        other.id == id &&
        other.phoneNumber == phoneNumber &&
        other.email == email &&
        other.volunteer == volunteer &&
        other.disciple == disciple &&
        other.state == state &&
        other.gender == gender &&
        other.image == image &&
        other.age == age &&
        other.city == city &&
        other.occupation == occupation &&
        other.school == school;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        phoneNumber.hashCode ^
        email.hashCode ^
        volunteer.hashCode ^
        disciple.hashCode ^
        state.hashCode ^
        gender.hashCode ^
        city.hashCode ^
        image.hashCode ^
        age.hashCode ^
        occupation.hashCode ^
        school.hashCode;
  }
}
