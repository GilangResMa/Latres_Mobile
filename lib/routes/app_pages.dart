import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/character_controller.dart';
import '../controllers/spell_controller.dart';
import '../views/login_view.dart';
import '../views/character_view.dart';
import '../views/character_detail_view.dart';
import '../views/spell_view.dart';
import '../views/favorite_spell_view.dart';
import 'app_routes.dart';

abstract class AppPages {
  static const String initial = AppRoutes.login;

  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: BindingsBuilder(() {
        // Always delete old instance and create new one
        Get.delete<AuthController>();
        Get.put(AuthController());
      }),
    ),
    GetPage(
      name: AppRoutes.character,
      page: () => const CharacterView(),
      binding: BindingsBuilder(() {
        Get.put(CharacterController());
        Get.put(SpellController());
      }),
    ),
    GetPage(
      name: AppRoutes.characterDetail,
      page: () => const CharacterDetailView(),
      binding: BindingsBuilder(() {
        Get.put(CharacterController());
      }),
    ),
    GetPage(
      name: AppRoutes.spell,
      page: () => const SpellView(),
      binding: BindingsBuilder(() {
        Get.put(AuthController());
        Get.put(SpellController());
      }),
    ),
    GetPage(
      name: AppRoutes.favoriteSpell,
      page: () => const FavoriteSpellView(),
      binding: BindingsBuilder(() {
        Get.put(AuthController());
        Get.put(SpellController());
      }),
    ),
  ];
}
