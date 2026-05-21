import 'package:flutter/foundation.dart';

class Character {
  final int? index;
  final String? fullName;
  final String? nickname;
  final String? hogwartsHouse;
  final String? interpretedBy;
  final List<String>? children;
  final String? image;
  final String? birthdate;

  Character({
    this.index,
    this.fullName,
    this.nickname,
    this.hogwartsHouse,
    this.interpretedBy,
    this.children,
    this.image,
    this.birthdate,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    // Debug: Log raw JSON
    debugPrint('Character JSON keys: ${json.keys.toList()}');
    
    return Character(
      index: json['index'] as int?,
      fullName: json['fullName'] as String?,
      nickname: json['nickname'] as String?,
      hogwartsHouse: json['hogwartsHouse'] as String?,
      interpretedBy: json['interpretedBy'] as String?,
      children: json['children'] != null
          ? List<String>.from(json['children'] as List)
          : null,
      image: json['image'] as String?,
      birthdate: json['birthdate'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'fullName': fullName,
      'nickname': nickname,
      'hogwartsHouse': hogwartsHouse,
      'interpretedBy': interpretedBy,
      'children': children,
      'image': image,
      'birthdate': birthdate,
    };
  }
}
