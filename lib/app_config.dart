import 'package:login_provider/screens/screens.dart';

class AppConfig {
  static String initialRoute = 'login';

  static routes() {
    return {
      'login': ((context) => const LoginScreen()),
      'register': ((context) => const RegisterScreen()),
      'home': ((context) => const HomeScreen()),
      'perfil': ((context) => const ProfileScreen()),
      'Acerca': ((context) => const AcercaScreen()),
    };
  }
}
