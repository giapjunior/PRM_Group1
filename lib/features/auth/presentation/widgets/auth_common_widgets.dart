import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../app/theme.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Stack(
      children: [
        const Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0, -0.65),
                radius: 1.05,
                colors: [Color(0x1FFFC174), AppColors.background],
                stops: [0, 1],
              ),
            ),
          ),
        ),
        SafeArea(
          child: Column(
            children: [
              const AuthTopBar(),
              Expanded(child: SingleChildScrollView(child: child)),
            ],
          ),
        ),
      ],
    ),
  );
}

class AuthTopBar extends StatelessWidget {
  const AuthTopBar({super.key});
  @override
  Widget build(BuildContext context) => Container(
    height: 56,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    color: AppColors.input.withValues(alpha: .4),
    child: Row(
      children: [
        const Icon(Icons.verified, size: 18, color: AppColors.primary),
        const SizedBox(width: 4),
        const Text(
          'VIP MACAU SALON',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        const Spacer(),
        _roundHeaderButton(
          Icons.language,
          'VI/EN',
          onTap: () => showDemoMessage(
            context,
            'Giao diện hiện đang hiển thị tiếng Việt.',
          ),
        ),
        const SizedBox(width: 6),
        _roundHeaderButton(
          Icons.volume_up,
          null,
          onTap: () => showDemoMessage(
            context,
            'Âm thanh sẽ khả dụng khi tích hợp trò chơi.',
          ),
        ),
        const SizedBox(width: 6),
        _roundHeaderButton(
          Icons.support_agent,
          null,
          color: AppColors.primary,
          onTap: () => showDemoMessage(
            context,
            'CSKH Live Chat sẽ được kết nối ở giai đoạn sau.',
          ),
        ),
      ],
    ),
  );

  Widget _roundHeaderButton(
    IconData icon,
    String? label, {
    Color color = AppColors.textMuted,
    required VoidCallback onTap,
  }) => Material(
    color: AppColors.surfaceHigh.withValues(alpha: .7),
    borderRadius: BorderRadius.circular(20),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 32,
        width: label == null ? 32 : null,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: label == null ? 0 : 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: label == null ? 16 : 14, color: color),
              if (label != null) ...[
                const SizedBox(width: 4),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.text,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    ),
  );
}

class AuthTabs extends StatelessWidget {
  const AuthTabs({super.key, required this.registerSelected});
  final bool registerSelected;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: AppColors.input,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        _tab(
          context,
          'Đăng Nhập',
          Icons.login,
          !registerSelected,
          AppRoutes.login,
        ),
        _tab(
          context,
          'Đăng Ký',
          Icons.how_to_reg,
          registerSelected,
          AppRoutes.register,
        ),
      ],
    ),
  );

  Widget _tab(
    BuildContext context,
    String label,
    IconData icon,
    bool selected,
    String route,
  ) => Expanded(
    child: InkWell(
      onTap: () => context.go(route),
      borderRadius: BorderRadius.circular(9),
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          color: selected ? AppColors.surfaceHigh : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
          boxShadow: selected
              ? const [BoxShadow(color: Color(0x33000000), blurRadius: 5)]
              : null,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: selected ? AppColors.primary : AppColors.textMuted,
                ),
                const SizedBox(width: 5),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: selected ? AppColors.primary : AppColors.textMuted,
                  ),
                ),
              ],
            ),
            if (selected)
              Positioned(
                left: 16,
                right: 16,
                bottom: 0,
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}

Widget brandLogo({double size = 80}) => SizedBox(
  width: size,
  height: size,
  child: Image.asset(
    'assets/images/taixiu_vip_logo.jpg',
    fit: BoxFit.contain,
    errorBuilder: (_, _, _) =>
        Icon(Icons.casino, size: size * .7, color: AppColors.primary),
  ),
);

class FieldLabel extends StatelessWidget {
  const FieldLabel(this.label, {super.key, this.trailing});
  final String label;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          label,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: .8,
          ),
        ),
      ),
      ?trailing,
    ],
  );
}

class AuthInput extends StatelessWidget {
  const AuthInput({
    super.key,
    required this.controller,
    required this.icon,
    required this.hint,
    this.obscure = false,
    this.keyboardType,
    this.trailing,
    this.validator,
    this.onChanged,
    this.textCapitalization = TextCapitalization.none,
  });
  final TextEditingController controller;
  final IconData icon;
  final String hint;
  final bool obscure;
  final TextInputType? keyboardType;
  final Widget? trailing;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: AppColors.input,
      borderRadius: BorderRadius.circular(8),
      boxShadow: const [
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 3,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        const SizedBox(width: 12),
        Icon(icon, color: AppColors.outline, size: 20),
        Expanded(
          child: TextFormField(
            controller: controller,
            obscureText: obscure,
            keyboardType: keyboardType,
            textCapitalization: textCapitalization,
            validator: validator,
            onChanged: onChanged,
            style: const TextStyle(color: AppColors.text, fontSize: 14),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: AppColors.outlineVariant,
                fontSize: 14,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 13,
              ),
              isDense: true,
            ),
          ),
        ),
        ?trailing,
        const SizedBox(width: 8),
      ],
    ),
  );
}

Widget formCard({
  required Widget child,
  EdgeInsets padding = const EdgeInsets.all(16),
  Color color = AppColors.surfaceLow,
}) => Container(
  width: double.infinity,
  padding: padding,
  decoration: BoxDecoration(
    color: color.withValues(alpha: .95),
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(color: Color(0x55000000), blurRadius: 18, offset: Offset(0, 8)),
    ],
  ),
  child: child,
);

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
