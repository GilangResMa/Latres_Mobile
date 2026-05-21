import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get existing controller or create new one
    AuthController authController;
    try {
      authController = Get.find<AuthController>();
    } catch (e) {
      authController = Get.put(AuthController());
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 76, 175, 80), Color.fromARGB(255, 57, 131, 59)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo/Title
                  const SizedBox(height: 40),
                  const Text(
                    'Harry Potter',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Character & Spells',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 60),

                  // Username field
                  CustomTextField(
                    label: 'Username',
                    controller: authController.usernameController,
                  ),
                  const SizedBox(height: 16),

                  // Password field
                  CustomTextField(
                    label: 'Password',
                    controller: authController.passwordController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 32),

                  // Login button
                  Obx(() {
                    return CustomButton(
                      text: 'Login',
                      isLoading: authController.isLoading.value,
                      onPressed: () async {
                        final username = authController.usernameController.text;
                        final password = authController.passwordController.text;

                        if (username.isEmpty || password.isEmpty) {
                          Get.snackbar(
                            'Error',
                            'Username and password cannot be empty',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: const Color.fromARGB(255, 255, 102, 102),
                          );
                          return;
                        }

                        final isSuccess = await authController.login(username, password);

                        if (isSuccess) {
                          Get.snackbar(
                            'Success',
                            'Login successful!',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: const Color.fromARGB(255, 76, 175, 80),
                          );
                          Get.offAllNamed(AppRoutes.character);
                        } else {
                          Get.snackbar(
                            'Error',
                            'Invalid username or password',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: const Color.fromARGB(255, 255, 102, 102),
                          );
                        }
                      },
                    );
                  }),
                  const SizedBox(height: 24),

                  // Demo credentials info
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white30),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kalo mau coba pake akun ini bang',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Username: harrypotter',
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          'Password: haripoah',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
