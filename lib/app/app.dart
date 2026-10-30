import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'routes.dart';
import 'theme.dart';
import '../features/auth/presentation/providers/auth_ui_provider.dart';

class TaiXiuApp extends StatelessWidget {
  const TaiXiuApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (_) => AuthUiProvider(),
    child: MaterialApp.router(
      title: 'Tài Xỉu Hoàng Gia',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      routerConfig: AppRoutes.router,
    ),
  );
}
