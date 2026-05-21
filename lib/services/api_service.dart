import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';
import '../models/character_model.dart';
import '../models/spell_model.dart';

class ApiService {
  static const String _baseUrl = 'https://potterapi-fedeperin.vercel.app/en';

  // Get all characters
  static Future<List<Character>> getCharacters() async {
    try {
      debugPrint('Fetching characters from $_baseUrl/characters');
      final response = await http.get(Uri.parse('$_baseUrl/characters'))
          .timeout(const Duration(seconds: 10));

      debugPrint('Characters response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body.substring(0, 500)}'); // First 500 chars
      
      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        
        // Handle both array and object response
        List<dynamic> characterList;
        if (data is List) {
          characterList = data;
        } else if (data is Map && data.containsKey('characters')) {
          characterList = data['characters'] as List;
        } else {
          characterList = [];
        }
        
        debugPrint('Loaded ${characterList.length} characters');
        if (characterList.isNotEmpty) {
          debugPrint('First character raw JSON: ${jsonEncode(characterList[0])}');
        }
        return characterList.map((json) => Character.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Failed to load characters: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching characters: $e');
      throw Exception('Error loading characters: $e');
    }
  }

  // Get all spells
  static Future<List<Spell>> getSpells() async {
    try {
      debugPrint('Fetching spells from $_baseUrl/spells');
      final response = await http.get(Uri.parse('$_baseUrl/spells'))
          .timeout(const Duration(seconds: 10));

      debugPrint('Spells response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body.substring(0, 500)}'); // First 500 chars
      
      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        
        // Handle both array and object response
        List<dynamic> spellList;
        if (data is List) {
          spellList = data;
        } else if (data is Map && data.containsKey('spells')) {
          spellList = data['spells'] as List;
        } else {
          spellList = [];
        }
        
        debugPrint('Loaded ${spellList.length} spells');
        if (spellList.isNotEmpty) {
          debugPrint('First spell raw JSON: ${jsonEncode(spellList[0])}');
        }
        return spellList.map((json) => Spell.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Failed to load spells: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching spells: $e');
      throw Exception('Error loading spells: $e');
    }
  }
}
