import 'package:get/get.dart';
import '../models/character_model.dart';
import '../services/api_service.dart';

class CharacterController extends GetxController {
  var characters = <Character>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var selectedCharacter = Rxn<Character>();

  @override
  void onInit() {
    super.onInit();
    fetchCharacters();
  }

  Future<void> fetchCharacters() async {
    try {
      errorMessage.value = '';
      isLoading.value = true;
      final result = await ApiService.getCharacters();
      characters.value = result;
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', 'Failed to load characters: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  void selectCharacter(Character character) {
    selectedCharacter.value = character;
  }
}
