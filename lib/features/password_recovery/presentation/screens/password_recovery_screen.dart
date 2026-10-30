import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../app/theme.dart';
import '../../../../features/auth/presentation/widgets/auth_common_widgets.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  State<PasswordRecoveryScreen> createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController(text: 'hoangde_macau88');
  final _phone = TextEditingController(text: '+84 ••• ••• 889');
  final _newPassword = TextEditingController(text: 'VipMacau2025!');
  final _confirmPassword = TextEditingController(text: 'VipMacau2025!');
  final _otpControllers = [
    '7',
    '8',
    '9',
    '2',
    '',
    '',
  ].map((digit) => TextEditingController(text: digit)).toList();
  final _otpFocus = List.generate(6, (_) => FocusNode());
  int _selectedMethod = 0;
  int _otpCountdown = 58;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_otpCountdown <= 1) {
        timer.cancel();
        if (mounted) setState(() => _otpCountdown = 0);
      } else if (mounted) {
        setState(() => _otpCountdown--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _username.dispose();
    _phone.dispose();
    _newPassword.dispose();
    _confirmPassword.dispose();
    for (final controller in _otpControllers) {
      controller.dispose();
    }
    for (final focus in _otpFocus) {
      focus.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AuthPage(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _subHeader(context),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _securityIntro(),
              const SizedBox(height: 20),
              _methodTabs(),
              const SizedBox(height: 16),
              _recoveryForm(context),
              const SizedBox(height: 16),
              _securityWarning(),
              const SizedBox(height: 12),
              _supportCard(context),
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: () => context.go(AppRoutes.login),
                iconAlignment: IconAlignment.end,
                icon: const Icon(Icons.chevron_right, size: 18),
                label: const Text('Đăng nhập ngay vào sảnh chơi'),
                style: TextButton.styleFrom(foregroundColor: AppColors.primary),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _subHeader(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    color: AppColors.input.withValues(alpha: .8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _roundAction(
          Icons.arrow_back,
          'Quay lại đăng nhập',
          () => context.go(AppRoutes.login),
        ),
        const Expanded(
          child: Column(
            children: [
              Text(
                'KHÔI PHỤC MẬT KHẨU',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  letterSpacing: .6,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'HỆ THỐNG VIP MACAU 256-BIT',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
        _roundAction(
          Icons.headset_mic,
          'CSKH VIP Khẩn Cấp',
          () => showDemoMessage(
            context,
            'CSKH VIP sẽ được kết nối ở giai đoạn sau.',
          ),
          color: AppColors.primary,
        ),
      ],
    ),
  );

  Widget _roundAction(
    IconData icon,
    String label,
    VoidCallback onPressed, {
    Color color = AppColors.text,
  }) => IconButton.filledTonal(
    onPressed: onPressed,
    tooltip: label,
    style: IconButton.styleFrom(
      backgroundColor: AppColors.surface,
      foregroundColor: color,
      fixedSize: const Size(40, 40),
    ),
    icon: Icon(icon, size: 20),
  );

  Widget _securityIntro() => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: AppColors.surfaceLow,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 16,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.surfaceHighest,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Icon(Icons.security, size: 38, color: AppColors.primary),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.vpn_key,
                    size: 14,
                    color: AppColors.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'LẤY LẠI MẬT KHẨU BẢO MẬT',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: -.3,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Vui lòng nhập số điện thoại hoặc Tên tài khoản liên kết để nhận mã xác thực OTP khôi phục mã PIN & mật khẩu độc quyền.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 12,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.input.withValues(alpha: .7),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.lock, size: 14, color: AppColors.green),
              SizedBox(width: 7),
              Text(
                'END-TO-END RSA 4096 MULTI-LAYER',
                style: TextStyle(
                  color: AppColors.green,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  letterSpacing: .6,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _methodTabs() {
    const labels = ['SMS / Telegram', 'Email VIP', 'CSKH Trực Tiếp'];
    const icons = [Icons.sms, Icons.mark_email_read, Icons.support_agent];
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.input,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: List.generate(
          labels.length,
          (index) => Expanded(
            child: InkWell(
              onTap: () => setState(() => _selectedMethod = index),
              borderRadius: BorderRadius.circular(9),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: _selectedMethod == index
                      ? AppColors.surfaceHigh
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: _selectedMethod == index
                      ? const [
                          BoxShadow(color: Color(0x22000000), blurRadius: 4),
                        ]
                      : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icons[index],
                      color: _selectedMethod == index
                          ? AppColors.primary
                          : AppColors.textMuted,
                      size: 20,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      labels[index],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: _selectedMethod == index
                            ? AppColors.primary
                            : AppColors.textMuted,
                        fontSize: 10,
                        fontWeight: _selectedMethod == index
                            ? FontWeight.w700
                            : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _recoveryForm(BuildContext context) => Form(
    key: _formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _labelRow(
          'TÊN ĐĂNG NHẬP / NICKNAME HOÀNG GIA',
          trailing: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, size: 13, color: AppColors.green),
              SizedBox(width: 3),
              Text(
                'ĐÃ XÁC MINH',
                style: TextStyle(
                  color: AppColors.green,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        _inputField(
          controller: _username,
          icon: Icons.account_circle,
          hint: 'Nhập tên tài khoản',
          validator: (value) =>
              value == null || value.isEmpty ? 'Nhập tên tài khoản' : null,
          verified: true,
        ),
        const SizedBox(height: 14),
        _labelRow('SỐ ĐIỆN THOẠI HOẶC TELEGRAM LIÊN KẾT'),
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: _inputField(
                controller: _phone,
                icon: Icons.phone_iphone,
                hint: 'Số điện thoại nhận mã',
              ),
            ),
            const SizedBox(width: 6),
            ElevatedButton.icon(
              onPressed: _sendOtp,
              icon: const Icon(Icons.send, size: 16),
              label: Text(
                _otpCountdown > 0
                    ? 'GỬI MÃ OTP (${_otpCountdown}s)'
                    : 'GỬI LẠI MÃ',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.surfaceHigh,
                foregroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 13,
                ),
                textStyle: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _labelRow(
          'MÃ XÁC THỰC BẢO MẬT OTP (6 CHỮ SỐ)',
          trailing: const Text(
            'HẾT HẠN TRONG 04:52',
            style: TextStyle(
              color: AppColors.pink,
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: List.generate(
            6,
            (index) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: index == 5 ? 0 : 6),
                child: _otpCell(index),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        _labelRow('MẬT KHẨU MỚI (TỐI THIỂU 8 KÝ TỰ)'),
        const SizedBox(height: 5),
        _inputField(
          controller: _newPassword,
          icon: Icons.lock_reset,
          hint: '',
          obscure: !_showNewPassword,
          validator: (value) => value == null || value.length < 8
              ? 'Mật khẩu cần tối thiểu 8 ký tự'
              : null,
          trailing: IconButton(
            onPressed: () =>
                setState(() => _showNewPassword = !_showNewPassword),
            icon: Icon(
              _showNewPassword ? Icons.visibility_off : Icons.visibility,
              size: 18,
              color: AppColors.textMuted,
            ),
          ),
        ),
        const SizedBox(height: 8),
        _strengthMeter(),
        const SizedBox(height: 14),
        _labelRow('XÁC NHẬN MẬT KHẨU MỚI'),
        const SizedBox(height: 5),
        _inputField(
          controller: _confirmPassword,
          icon: Icons.lock,
          hint: '',
          obscure: !_showConfirmPassword,
          validator: (value) =>
              value != _newPassword.text ? 'Mật khẩu xác nhận chưa khớp' : null,
          verified: _confirmPassword.text == _newPassword.text,
          trailing: IconButton(
            onPressed: () =>
                setState(() => _showConfirmPassword = !_showConfirmPassword),
            icon: Icon(
              _showConfirmPassword ? Icons.visibility_off : Icons.visibility,
              size: 18,
              color: AppColors.textMuted,
            ),
          ),
        ),
        const SizedBox(height: 16),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppColors.primaryContainer,
                AppColors.primary,
                Color(0xFFFFDDB8),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0x44F59E0B),
                blurRadius: 16,
                offset: Offset(0, 7),
              ),
            ],
          ),
          child: ElevatedButton.icon(
            onPressed: _submit,
            icon: const Icon(Icons.key, size: 23),
            label: const Text(
              'XÁC NHẬN ĐỔI MẬT KHẨU',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: AppColors.onPrimary,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _otpCell(int index) => Focus(
    onKeyEvent: (node, event) {
      if (event is KeyDownEvent &&
          event.logicalKey == LogicalKeyboardKey.backspace &&
          _otpControllers[index].text.isEmpty &&
          index > 0) {
        _otpFocus[index - 1].requestFocus();
      }
      return KeyEventResult.ignored;
    },
    child: TextField(
      controller: _otpControllers[index],
      focusNode: _otpFocus[index],
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      maxLength: 1,
      style: const TextStyle(
        color: AppColors.primary,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
      decoration: InputDecoration(
        counterText: '',
        hintText: '•',
        hintStyle: const TextStyle(color: AppColors.textMuted),
        filled: true,
        fillColor: index < 4 ? AppColors.input : AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
      onChanged: (value) {
        if (value.isNotEmpty && index < 5) _otpFocus[index + 1].requestFocus();
      },
    ),
  );

  Widget _inputField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    bool obscure = false,
    bool verified = false,
    Widget? trailing,
    String? Function(String?)? validator,
  }) => Container(
    decoration: BoxDecoration(
      color: AppColors.input,
      borderRadius: BorderRadius.circular(11),
      boxShadow: const [BoxShadow(color: Color(0x22000000), blurRadius: 4)],
    ),
    child: Row(
      children: [
        const SizedBox(width: 12),
        Icon(icon, size: 20, color: AppColors.primary),
        Expanded(
          child: TextFormField(
            controller: controller,
            obscureText: obscure,
            validator: validator,
            style: const TextStyle(color: AppColors.text, fontSize: 14),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: AppColors.outlineVariant,
                fontSize: 13,
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
        if (verified) ...[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Icons.verified, color: AppColors.green, size: 18),
          ),
        ],
        const SizedBox(width: 6),
      ],
    ),
  );

  Widget _labelRow(String label, {Widget? trailing}) => Row(
    children: [
      Expanded(
        child: Text(
          label,
          style: const TextStyle(
            color: AppColors.textMuted,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: .4,
          ),
        ),
      ),
      ?trailing,
    ],
  );

  Widget _strengthMeter() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'ĐỘ MẠNH MẬT KHẨU:',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'RẤT AN TOÀN (CỰC MẠNH)',
            style: TextStyle(
              color: AppColors.green,
              fontSize: 9,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      const SizedBox(height: 5),
      Row(
        children: List.generate(
          4,
          (_) => Expanded(
            child: Container(
              height: 5,
              margin: const EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 4),
      const Text(
        'Bao gồm chữ hoa, chữ thường, chữ số và ký tự đặc biệt (!@#\$).',
        style: TextStyle(color: AppColors.textMuted, fontSize: 10),
      ),
    ],
  );

  Widget _securityWarning() => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppColors.surfaceLow,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.red.withValues(alpha: .3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.gpp_maybe, color: AppColors.pink, size: 18),
        ),
        const SizedBox(width: 9),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CẢNH BÁO BẢO MẬT VIP',
                style: TextStyle(
                  color: AppColors.pink,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: .7,
                ),
              ),
              SizedBox(height: 4),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Tuyệt đối '),
                    TextSpan(
                      text: 'không chia sẻ mã OTP',
                      style: TextStyle(
                        color: AppColors.text,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: ' cho bất kỳ ai kể cả chuyên viên hỗ trợ VIP. Hệ thống CSKH không bao giờ yêu cầu cung cấp mật khẩu cá nhân của quý khách.',
                    ),
                  ],
                ),
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 11,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _supportCard(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: AppColors.input,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Gặp sự cố số điện thoại / SIM?',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.green.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Trực Tuyến',
                style: TextStyle(color: AppColors.green, fontSize: 9),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        const Text(
          'Tài khoản bị khóa hoặc mất số điện thoại đăng ký? Hãy liên hệ ngay trợ lý VIP độc quyền qua kênh mã hóa an toàn.',
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 11,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 9),
        Row(
          children: [
            Expanded(
              child: _supportButton(
                context,
                Icons.phone_in_talk,
                'Hotline 24/7 VIP',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _supportButton(context, Icons.send, 'Telegram VIP Desk'),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _supportButton(BuildContext context, IconData icon, String label) =>
      TextButton.icon(
        onPressed: () =>
            showDemoMessage(context, '$label sẽ được kết nối ở giai đoạn sau.'),
        icon: Icon(icon, color: AppColors.primary, size: 17),
        label: Text(
          label,
          style: const TextStyle(color: AppColors.text, fontSize: 10),
        ),
        style: TextButton.styleFrom(
          backgroundColor: AppColors.surface,
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );

  void _sendOtp() {
    if (_otpCountdown > 0) return;
    setState(() => _otpCountdown = 58);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_otpCountdown <= 1) {
        timer.cancel();
        if (mounted) setState(() => _otpCountdown = 0);
      } else if (mounted) {
        setState(() => _otpCountdown--);
      }
    });
    showDemoMessage(context, 'Đã gửi yêu cầu mã OTP mẫu.');
  }

  void _submit() {
    final otp = _otpControllers.map((controller) => controller.text).join();
    if (!_formKey.currentState!.validate()) return;
    if (otp.length < 6) {
      showDemoMessage(context, 'Vui lòng nhập đủ mã OTP 6 số.');
      return;
    }
    showDemoMessage(
      context,
      'Giao diện mẫu: khôi phục mật khẩu sẽ được kết nối ở giai đoạn sau.',
    );
  }
}
