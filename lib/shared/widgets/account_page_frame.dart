import 'package:flutter/material.dart';

import '../../app/theme.dart';

class AccountPageFrame extends StatelessWidget {
  const AccountPageFrame({
    super.key,
    required this.title,
    required this.child,
    required this.onBack,
    this.horizontalPadding = 12,
  });

  final String title;
  final Widget child;
  final VoidCallback onBack;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.background,
    body: Stack(
      children: [
        const Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0, -.8),
                radius: 1.5,
                colors: [Color(0x14F59E0B), AppColors.background],
              ),
            ),
          ),
        ),
        SafeArea(
          child: Column(
            children: [
              Container(
                height: 56,
                color: AppColors.input.withValues(alpha: .8),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: onBack,
                      icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                      color: AppColors.text,
                      tooltip: 'Quay lại',
                    ),
                    Expanded(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          letterSpacing: .3,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => showDemoMessage(
                        context,
                        'CSKH VIP sẽ được kết nối ở giai đoạn sau.',
                      ),
                      icon: const Icon(Icons.support_agent, size: 20),
                      color: AppColors.primary,
                      tooltip: 'CSKH 24/7',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    12,
                    horizontalPadding,
                    28,
                  ),
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

void showDemoMessage(BuildContext context, String message) =>
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.surfaceHigh,
        ),
      );

class ProfilePanel extends StatelessWidget {
  const ProfilePanel({super.key, required this.child, this.color});
  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color ?? AppColors.surface,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 12,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: child,
  );
}

class ProfileSectionTitle extends StatelessWidget {
  const ProfileSectionTitle(
    this.title, {
    super.key,
    required this.icon,
    this.color = AppColors.primary,
  });
  final String title;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, size: 20, color: color),
      const SizedBox(width: 7),
      Expanded(
        child: Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ],
  );
}
