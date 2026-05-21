import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/spell_model.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';
import '../services/notification_service.dart';

class SpellController extends GetxController {
  var spells = <Spell>[].obs;
  var favoriteSpells = <Spell>[].obs;
  var isLoading = false.obs;
  var isFavoritesLoading = false.obs;
  var favoriteIds = <String>{}.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSpells();
    loadFavoriteSpells();
  }

  Future<void> fetchSpells() async {
    try {
      errorMessage.value = '';
      isLoading.value = true;
      final result = await ApiService.getSpells();
      spells.value = result;
      
      // Load favorite status for each spell
      for (var spell in result) {
        final isFav = await LocalStorageService.isFavoriteSpell(spell.index?.toString() ?? '');
        if (isFav) {
          favoriteIds.add(spell.index?.toString() ?? '');
        }
      }
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', 'Failed to load spells: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadFavoriteSpells() async {
    try {
      isFavoritesLoading.value = true;
      final result = await LocalStorageService.getFavoriteSpells();
      favoriteSpells.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load favorites: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isFavoritesLoading.value = false;
    }
  }

  Future<void> toggleFavoriteSpell(Spell spell) async {
    try {
      final spellIndex = spell.index?.toString() ?? '';
      final isFav = favoriteIds.contains(spellIndex);
      
      if (isFav) {
        await LocalStorageService.removeFavoriteSpell(spellIndex);
        favoriteIds.remove(spellIndex);
        favoriteSpells.removeWhere((s) => s.index == spell.index);
        Get.snackbar(
          'Removed',
          '${spell.spell} removed from favorites',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color.fromARGB(255, 255, 102, 102),
          colorText: const Color.fromARGB(255, 255, 255, 255),
          duration: const Duration(seconds: 2),
        );
      } else {
        await LocalStorageService.addFavoriteSpell(spell);
        favoriteIds.add(spellIndex);
        favoriteSpells.add(spell);
        Get.snackbar(
          'Added',
          '${spell.spell} added to favorites',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color.fromARGB(255, 76, 175, 80),
          colorText: const Color.fromARGB(255, 255, 255, 255),
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update favorite: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> removeFavoriteSpell(Spell spell) async {
    try {
      final spellIndex = spell.index?.toString() ?? '';
      await LocalStorageService.removeFavoriteSpell(spellIndex);
      favoriteIds.remove(spellIndex);
      await loadFavoriteSpells();
      
      // Show immediate notification
      await NotificationService.showNotification(
        title: 'Spell Removed',
        body: 'You deleted ${spell.spell} from your favorites',
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to remove favorite: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  bool isFavorite(String spellId) {
    return favoriteIds.contains(spellId);
  }
}
