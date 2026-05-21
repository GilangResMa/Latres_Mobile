import 'package:flutter/foundation.dart';

class Spell {
  final int? index;
  final String? spell;
  final String? use;

  Spell({
    this.index,
    this.spell,
    this.use,
  });

  factory Spell.fromJson(Map<String, dynamic> json) {
    // Debug: Log raw JSON
    debugPrint('Spell JSON keys: ${json.keys.toList()}');
    
    return Spell(
      index: json['index'] as int?,
      spell: json['spell'] as String?,
      use: json['use'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'spell': spell,
      'use': use,
    };
  }
}
