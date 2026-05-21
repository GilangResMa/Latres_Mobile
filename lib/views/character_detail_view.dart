import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/character_controller.dart';

class CharacterDetailView extends StatelessWidget {
  const CharacterDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final characterController = Get.find<CharacterController>();
    final character = characterController.selectedCharacter.value;

    if (character == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Character Detail')),
        body: const Center(child: Text('No character selected')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(character.fullName ?? 'Character'),
        backgroundColor: const Color.fromARGB(255, 27, 133, 22),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Character Image
            if (character.image != null)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    character.image!,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 24),

            // Character Name
            Text(
              character.fullName ?? 'Unknown',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Character Details
            _buildDetailItem('Nickname', character.nickname),
            _buildDetailItem('House', character.hogwartsHouse),
            _buildDetailItem('Interpreted By', character.interpretedBy),
            _buildDetailItem('Birthdate', character.birthdate),

            // Children
            if (character.children != null && character.children!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Children',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    character.children!.join(', '),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value?.toString() ?? 'N/A',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
