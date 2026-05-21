import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/spell_controller.dart';
import '../controllers/auth_controller.dart';
import '../routes/app_routes.dart';

class SpellView extends StatelessWidget {
  const SpellView({super.key});

  @override
  Widget build(BuildContext context) {
    final spellController = Get.find<SpellController>();
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Spells'),
        backgroundColor: const Color.fromARGB(255, 27, 133, 22),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Get.toNamed(AppRoutes.favoriteSpell);
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _showLogoutDialog(context, authController);
            },
          ),
        ],
      ),
      body: Obx(() {
        if (spellController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (spellController.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'Error Loading Spells',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    spellController.errorMessage.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: spellController.fetchSpells,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (spellController.spells.isEmpty) {
          return const Center(
            child: Text('No spells found'),
          );
        }

        return ListView.builder(
          itemCount: spellController.spells.length,
          itemBuilder: (context, index) {
            final spell = spellController.spells[index];
            final isFavorite = spellController.isFavorite(spell.index?.toString() ?? '');

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                title: Text(spell.spell ?? 'Unknown'),
                subtitle: Text(
                  spell.use ?? 'No description',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    spellController.toggleFavoriteSpell(spell);
                  },
                ),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
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
          if (index == 0) {
            Get.toNamed(AppRoutes.character);
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
