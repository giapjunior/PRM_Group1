import 'package:go_router/go_router.dart';

import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';
import '../features/password_recovery/presentation/screens/password_recovery_screen.dart';
import '../features/change_password/presentation/screens/change_password_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/profile/presentation/screens/account_settings_screen.dart';
import '../features/app_settings/presentation/screens/app_settings_screen.dart';
import '../features/about/presentation/screens/about_screen.dart';
import '../features/cashier/presentation/screens/deposit_screen.dart';
import '../features/cashier/presentation/screens/withdraw_screen.dart';

abstract final class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const passwordRecovery = '/password/recovery';
  static const changePassword = '/password/change';
  static const profile = '/profile';
  static const accountSettings = '/account/settings';
  static const appSettings = '/settings/app';
  static const about = '/about';
  static const deposit = '/cashier/deposit';
  static const withdraw = '/cashier/withdraw';

  static final router = GoRouter(
    initialLocation: login,
    routes: [
      GoRoute(path: login, builder: (_, _) => const LoginScreen()),
      GoRoute(path: register, builder: (_, _) => const RegisterScreen()),
      GoRoute(
        path: passwordRecovery,
        builder: (_, _) => const PasswordRecoveryScreen(),
      ),
      GoRoute(
        path: changePassword,
        builder: (_, _) => const ChangePasswordScreen(),
      ),
      GoRoute(path: profile, builder: (_, _) => const ProfileScreen()),
      GoRoute(
        path: accountSettings,
        builder: (_, _) => const AccountSettingsScreen(),
      ),
      GoRoute(path: appSettings, builder: (_, _) => const AppSettingsScreen()),
      GoRoute(path: about, builder: (_, _) => const AboutScreen()),
      GoRoute(path: deposit, builder: (_, _) => const DepositScreen()),
      GoRoute(path: withdraw, builder: (_, _) => const WithdrawScreen()),
    ],
  );
}
