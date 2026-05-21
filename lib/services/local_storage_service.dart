import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/spell_model.dart';
import 'dart:convert';

class LocalStorageService {
  static const String _loginKey = 'is_logged_in';
  static const String _usernameKey = 'username';
  static const String _favoritesBoxName = 'favorite_spells';

  // Login session methods
  static Future<void> setLoginSession(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loginKey, true);
    await prefs.setString(_usernameKey, username);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loginKey) ?? false;
  }

  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loginKey, false);
    await prefs.remove(_usernameKey);
  }

  // Hive - Favorite spells methods
  static Future<void> initHive() async {
    await Hive.initFlutter();
    await Hive.openBox<String>(_favoritesBoxName);
  }

  static Future<void> addFavoriteSpell(Spell spell) async {
    final spellIndex = spell.index?.toString();
    if (spellIndex == null || spellIndex.isEmpty) {
      throw Exception('Spell index cannot be null or empty');
    }
    final box = Hive.box<String>(_favoritesBoxName);
    await box.put(spellIndex, jsonEncode(spell.toJson()));
  }

  static Future<void> removeFavoriteSpell(String spellId) async {
    final box = Hive.box<String>(_favoritesBoxName);
    await box.delete(spellId);
  }

  static Future<bool> isFavoriteSpell(String spellId) async {
    final box = Hive.box<String>(_favoritesBoxName);
    return box.containsKey(spellId);
  }

  static Future<List<Spell>> getFavoriteSpells() async {
    final box = Hive.box<String>(_favoritesBoxName);
    List<Spell> favorites = [];
    for (var value in box.values) {
      favorites.add(Spell.fromJson(jsonDecode(value)));
    }
    return favorites;
  }

  static Future<int> getFavoritesCount() async {
    final box = Hive.box<String>(_favoritesBoxName);
    return box.length;
  }
}
