import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/spell_controller.dart';

class FavoriteSpellView extends StatelessWidget {
  const FavoriteSpellView({super.key});

  @override
  Widget build(BuildContext context) {
    final spellController = Get.find<SpellController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Spells'),
        backgroundColor: const Color.fromARGB(255, 27, 133, 22),
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (spellController.isFavoritesLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (spellController.favoriteSpells.isEmpty) {
          return const Center(
            child: Text('No favorite spells yet'),
          );
        }

        return ListView.builder(
          itemCount: spellController.favoriteSpells.length,
          itemBuilder: (context, index) {
            final spell = spellController.favoriteSpells[index];

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
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    _showDeleteDialog(context, spell, spellController);
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void _showDeleteDialog(context, spell, SpellController spellController) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Favorite'),
        content: Text('Remove ${spell.spell} from favorites?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              spellController.removeFavoriteSpell(spell);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
