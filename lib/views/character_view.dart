import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/character_controller.dart';
import '../controllers/auth_controller.dart';
import '../routes/app_routes.dart';

class CharacterView extends StatelessWidget {
  const CharacterView({super.key});

  @override
  Widget build(BuildContext context) {
    final characterController = Get.find<CharacterController>();
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
        backgroundColor: const Color.fromARGB(255, 27, 133, 22),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _showLogoutDialog(context, authController);
            },
          ),
        ],
      ),
      body: Obx(() {
        if (characterController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (characterController.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'Error Loading Characters',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    characterController.errorMessage.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: characterController.fetchCharacters,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (characterController.characters.isEmpty) {
          return const Center(
            child: Text('No characters found'),
          );
        }

        return ListView.builder(
          itemCount: characterController.characters.length,
          itemBuilder: (context, index) {
            final character = characterController.characters[index];
            return ListTile(
              leading: character.image != null
                  ? Image.network(
                      character.image!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.person),
              title: Text(character.fullName ?? 'Unknown'),
              subtitle: Text(character.hogwartsHouse ?? 'No house'),
              onTap: () {
                characterController.selectCharacter(character);
                Get.toNamed(AppRoutes.characterDetail);
              },
            );
          },
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Characters',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome),
            label: 'Spells',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Get.toNamed(AppRoutes.spell);
          }
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AuthController authController) {
    Get.dialog(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Get.back();
              await authController.logout();
              Get.snackbar(
                'Success',
                'Logout successful',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: const Color.fromARGB(255, 76, 175, 80),
              );
              Get.offAllNamed(AppRoutes.login);
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
