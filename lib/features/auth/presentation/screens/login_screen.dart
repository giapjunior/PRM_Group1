import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../app/routes.dart';
import '../../../../app/theme.dart';
import '../providers/auth_ui_provider.dart';
import '../widgets/auth_common_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();
  bool _showPassword = false;
  bool _remember = true;

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final submitting = context.watch<AuthUiProvider>().submitting;
    return AuthPage(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _welcomeHeader(),
            const SizedBox(height: 16),
            _welcomeBonus(context),
            const SizedBox(height: 16),
            const AuthTabs(registerSelected: false),
            const SizedBox(height: 16),
            _loginForm(context, submitting),
            const SizedBox(height: 16),
            _jackpotTicker(),
            const SizedBox(height: 10),
            _loginFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _welcomeHeader() => Column(
    children: [
      const SizedBox(height: 4),
      Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Color(0x55FFC174), blurRadius: 24)],
            ),
          ),
          brandLogo(size: 80),
          Positioned(
            bottom: -1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.red,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(color: Colors.black38, blurRadius: 5),
                ],
              ),
              child: const Row(
                children: [
                  Icon(Icons.stars, color: AppColors.primary, size: 12),
                  SizedBox(width: 4),
                  Text(
                    'VIP MACAU',
                    style: TextStyle(
                      color: AppColors.pink,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      const Text(
        'TÀI XỈU HOÀNG GIA',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
          shadows: [Shadow(color: Color(0x55FFC174), blurRadius: 8)],
        ),
      ),
      const SizedBox(height: 2),
      const Text(
        'CỔNG GAME QUỐC TẾ',
        style: TextStyle(
          color: AppColors.textMuted,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.5,
        ),
      ),
      const SizedBox(height: 7),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.surfaceHigh.withValues(alpha: .8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.circle, size: 7, color: AppColors.green),
            SizedBox(width: 7),
            Text(
              'Đẳng Cấp Thượng Lưu • Thắng Lớn Mỗi Giây',
              style: TextStyle(color: Color(0xFF6FFBBE), fontSize: 11),
            ),
          ],
        ),
      ),
    ],
  );

  Widget _welcomeBonus(BuildContext context) => Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xDDA40217), AppColors.surfaceHigh, AppColors.surface],
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [BoxShadow(color: Color(0x33000000), blurRadius: 12)],
    ),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: .18),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.redeem, color: AppColors.primary, size: 24),
        ),
        const SizedBox(width: 9),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'QUÀ KHỞI NGHIỆP',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: .5,
                    ),
                  ),
                  SizedBox(width: 6),
                  _BonusChip(),
                ],
              ),
              SizedBox(height: 3),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Đăng nhập nhận ngay ',
                      style: TextStyle(color: AppColors.text, fontSize: 11),
                    ),
                    TextSpan(
                      text: '88.000 Xu',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: ' tân thủ!',
                      style: TextStyle(color: AppColors.text, fontSize: 11),
                    ),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        _smallAction(
          'NHẬN',
          () => showDemoMessage(context, 'Đăng nhập để nhận quà khởi nghiệp.'),
        ),
      ],
    ),
  );

  Widget _loginForm(BuildContext context, bool submitting) => formCard(
    child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FieldLabel(
            'TÀI KHOẢN / SĐT',
            trailing: const Text(
              'yêu cầu VIP ID',
              style: TextStyle(color: AppColors.primary, fontSize: 11),
            ),
          ),
          const SizedBox(height: 6),
          AuthInput(
            controller: _username,
            icon: Icons.account_circle,
            hint: 'Tên tài khoản hoặc 09x...',
            keyboardType: TextInputType.text,
            onChanged: (_) => setState(() {}),
            validator: (v) => v == null || v.trim().isEmpty
                ? 'Vui lòng nhập tài khoản'
                : null,
            trailing: _username.text.isEmpty
                ? null
                : IconButton(
                    onPressed: () {
                      _username.clear();
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.cancel,
                      color: AppColors.outlineVariant,
                      size: 18,
                    ),
                    visualDensity: VisualDensity.compact,
                  ),
          ),
          const SizedBox(height: 16),
          const FieldLabel(
            'MẬT KHẨU BẢO MẬT',
            trailing: Icon(
              Icons.verified_user,
              size: 16,
              color: AppColors.green,
            ),
          ),
          const SizedBox(height: 6),
          AuthInput(
            controller: _password,
            icon: Icons.lock,
            hint: '••••••••••••',
            obscure: !_showPassword,
            validator: (v) =>
                v == null || v.isEmpty ? 'Vui lòng nhập mật khẩu' : null,
            trailing: IconButton(
              onPressed: () => setState(() => _showPassword = !_showPassword),
              icon: Icon(
                _showPassword ? Icons.visibility_off : Icons.visibility,
                color: _showPassword ? AppColors.primary : AppColors.textMuted,
                size: 20,
              ),
              visualDensity: VisualDensity.compact,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => setState(() => _remember = !_remember),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: _remember,
                          onChanged: (v) =>
                              setState(() => _remember = v ?? false),
                          activeColor: AppColors.primary,
                          checkColor: AppColors.onPrimary,
                          side: const BorderSide(
                            color: AppColors.outlineVariant,
                          ),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                      const SizedBox(width: 7),
                      const Flexible(
                        child: Text(
                          'Ghi nhớ phiên đăng nhập',
                          style: TextStyle(color: AppColors.text, fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () => context.go(AppRoutes.passwordRecovery),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Quên mật khẩu?',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 11,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColors.primaryContainer,
                  AppColors.primary,
                  AppColors.primaryContainer,
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x66F59E0B),
                  blurRadius: 18,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: submitting
                  ? null
                  : () async {
                      if (_formKey.currentState!.validate()) {
                        await context.read<AuthUiProvider>().submitMockAction();
                        if (context.mounted) {
                          showDemoMessage(
                            context,
                            'Giao diện mẫu: xác thực sẽ được kết nối ở giai đoạn sau.',
                          );
                        }
                      }
                    },
              icon: submitting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.onPrimaryContainer,
                      ),
                    )
                  : const Icon(Icons.bolt, size: 24),
              label: Text(
                submitting ? 'ĐANG XỬ LÝ...' : 'ĐĂNG NHẬP NGAY',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: AppColors.onPrimaryContainer,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              const Expanded(child: Divider(color: AppColors.surfaceHighest)),
              Container(
                color: AppColors.surfaceLow,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const Text(
                  'HOẶC KẾT NỐI SIÊU TỐC',
                  style: TextStyle(
                    color: AppColors.outline,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: .8,
                  ),
                ),
              ),
              const Expanded(child: Divider(color: AppColors.surfaceHighest)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _social(
                  context,
                  'Facebook',
                  'assets/icons/facebook.svg',
                  AppColors.primary,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _social(
                  context,
                  'Telegram',
                  'assets/icons/telegram.svg',
                  AppColors.green,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _social(
                  context,
                  'Google',
                  'assets/icons/google.svg',
                  const Color(0xFFFFB4AB),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  Widget _social(
    BuildContext context,
    String name,
    String iconAsset,
    Color color,
  ) => OutlinedButton.icon(
    onPressed: () =>
        showDemoMessage(context, '$name sẽ khả dụng khi tích hợp đăng nhập.'),
    icon: SvgPicture.asset(
      iconAsset,
      width: 18,
      height: 18,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    ),
    label: Text(
      name,
      style: const TextStyle(fontSize: 10, color: AppColors.text),
    ),
    style: OutlinedButton.styleFrom(
      backgroundColor: AppColors.surfaceHigh,
      side: BorderSide.none,
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

  Widget _jackpotTicker() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: AppColors.input.withValues(alpha: .8),
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Row(
      children: [
        Icon(Icons.military_tech, size: 18, color: AppColors.primary),
        SizedBox(width: 4),
        Text(
          'NỔ HŨ:',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            'User vip_88*** vừa rút +145.000.000 VNĐ (Bão Tam 6)',
            style: TextStyle(
              color: AppColors.green,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: .3,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );

  Widget _loginFooter(BuildContext context) => Column(
    children: [
      Row(
        children: [
          Expanded(
            child: _supportButton(
              Icons.phone_in_talk,
              'Hotline 24/7 VIP',
              AppColors.primary,
              context,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _supportButton(
              Icons.forum,
              'CSKH Live Chat',
              AppColors.green,
              context,
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      const Wrap(
        alignment: WrapAlignment.center,
        spacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            '🔒 MÃ HÓA SSL 256-BIT',
            style: TextStyle(
              color: AppColors.outline,
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text('•', style: TextStyle(color: AppColors.outline)),
          Text(
            '✓ PAGCOR LICENSED',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text('•', style: TextStyle(color: AppColors.outline)),
          Text(
            '🛡 BẢO MẬT 100%',
            style: TextStyle(
              color: AppColors.pink,
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      const SizedBox(height: 5),
      const Text(
        'Bản quyền © 2025 Tài Xỉu Hoàng Gia VIP Salon. Nghiêm cấm mọi hành vi gian lận.',
        textAlign: TextAlign.center,
        style: TextStyle(color: AppColors.outlineVariant, fontSize: 10),
      ),
    ],
  );

  Widget _supportButton(
    IconData icon,
    String text,
    Color color,
    BuildContext context,
  ) => TextButton.icon(
    onPressed: () =>
        showDemoMessage(context, 'Kênh hỗ trợ sẽ được cấu hình sau.'),
    icon: Icon(icon, size: 17, color: color),
    label: Text(
      text,
      style: const TextStyle(color: AppColors.text, fontSize: 11),
    ),
    style: TextButton.styleFrom(
      backgroundColor: AppColors.surfaceHigh.withValues(alpha: .9),
      padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

  Widget _smallAction(String text, VoidCallback action) => ElevatedButton(
    onPressed: action,
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      minimumSize: Size.zero,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    child: Text(
      text,
      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
    ),
  );
}

class _BonusChip extends StatelessWidget {
  const _BonusChip();
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
    decoration: BoxDecoration(
      color: AppColors.greenDark,
      borderRadius: BorderRadius.circular(3),
    ),
    child: const Text(
      '+88K XU',
      style: TextStyle(
        color: Color(0xFF003824),
        fontSize: 9,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}
