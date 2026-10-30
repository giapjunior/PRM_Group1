import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../app/theme.dart';
import '../../../../shared/widgets/account_page_frame.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPassword = TextEditingController();
  final _newPassword = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _otp = TextEditingController();
  bool _showCurrent = false;
  bool _showNew = false;
  bool _showConfirm = false;
  bool _match = false;
  int _score = 0;
  int _otpCountdown = 0;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    _currentPassword.dispose();
    _newPassword.dispose();
    _confirmPassword.dispose();
    _otp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AccountPageFrame(
    title: 'Đổi Mật Khẩu',
    onBack: () => context.go(AppRoutes.profile),
    child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProfilePanel(
            color: AppColors.surfaceLow,
            child: Column(
              children: [
                const Icon(Icons.security, size: 38, color: AppColors.primary),
                const SizedBox(height: 8),
                const Text(
                  'Bảo Vệ Két Sắt & Số Dư Hoàng Gia',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Cập nhật mật khẩu định kỳ để bảo vệ tài khoản và số dư của bạn.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textMuted, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _passwordField(
            label: 'MẬT KHẨU HIỆN TẠI',
            controller: _currentPassword,
            hint: 'Nhập mật khẩu đang dùng',
            visible: _showCurrent,
            onVisibilityChanged: () =>
                setState(() => _showCurrent = !_showCurrent),
            validator: (v) => v == null || v.isEmpty
                ? 'Vui lòng nhập mật khẩu hiện tại'
                : null,
          ),
          const SizedBox(height: 12),
          _passwordField(
            label: 'MẬT KHẨU MỚI',
            controller: _newPassword,
            hint: 'Tối thiểu 8 ký tự hoàng gia',
            visible: _showNew,
            onVisibilityChanged: () => setState(() => _showNew = !_showNew),
            onChanged: _evaluatePassword,
            validator: (v) => v == null || v.length < 8
                ? 'Mật khẩu mới cần tối thiểu 8 ký tự'
                : null,
          ),
          const SizedBox(height: 8),
          _strengthPanel(),
          const SizedBox(height: 12),
          _passwordField(
            label: 'XÁC NHẬN MẬT KHẨU MỚI',
            controller: _confirmPassword,
            hint: 'Nhập lại mật khẩu mới vừa đặt',
            visible: _showConfirm,
            onVisibilityChanged: () =>
                setState(() => _showConfirm = !_showConfirm),
            onChanged: (_) => setState(_updateMatch),
            validator: (v) => v != _newPassword.text
                ? 'Mật khẩu mới và xác nhận chưa khớp'
                : null,
          ),
          if (_match) ...[
            const SizedBox(height: 6),
            const Row(
              children: [
                Icon(Icons.check_circle, size: 15, color: AppColors.green),
                SizedBox(width: 5),
                Text(
                  'Mật khẩu đã khớp',
                  style: TextStyle(color: AppColors.green, fontSize: 11),
                ),
              ],
            ),
          ],
          const SizedBox(height: 14),
          _otpPanel(context),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => context.go(AppRoutes.passwordRecovery),
              child: const Text('Quên mật khẩu?'),
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
              icon: const Icon(Icons.lock_clock, size: 22),
              label: const Text(
                'CẬP NHẬT MẬT KHẨU MỚI',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
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
          const SizedBox(height: 14),
          ProfilePanel(
            color: AppColors.surfaceLow,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileSectionTitle(
                  'Bảo Vệ Tài Khoản',
                  icon: Icons.verified_user,
                ),
                SizedBox(height: 6),
                Text(
                  'Không chia sẻ mật khẩu hoặc mã OTP với bất kỳ ai. Nhân viên hỗ trợ sẽ không bao giờ yêu cầu mật khẩu cá nhân.',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 11,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _passwordField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required bool visible,
    required VoidCallback onVisibilityChanged,
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        label,
        style: const TextStyle(
          color: AppColors.textMuted,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: .5,
        ),
      ),
      const SizedBox(height: 5),
      Container(
        decoration: BoxDecoration(
          color: AppColors.input,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const SizedBox(width: 12),
            const Icon(Icons.lock, size: 19, color: AppColors.primary),
            Expanded(
              child: TextFormField(
                controller: controller,
                obscureText: !visible,
                onChanged: onChanged,
                validator: validator,
                style: const TextStyle(color: AppColors.text, fontSize: 14),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: const TextStyle(
                    color: AppColors.outlineVariant,
                    fontSize: 12,
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
            IconButton(
              onPressed: onVisibilityChanged,
              icon: Icon(
                visible ? Icons.visibility_off : Icons.visibility,
                size: 18,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    ],
  );

  Widget _strengthPanel() {
    final label = _score == 0
        ? 'CHƯA NHẬP'
        : _score <= 1
        ? 'YẾU'
        : _score == 2
        ? 'TRUNG BÌNH'
        : _score == 3
        ? 'KHÁ'
        : 'CỰC MẠNH';
    final color = _score <= 1
        ? const Color(0xFFFFB4AB)
        : _score == 2
        ? AppColors.primary
        : AppColors.green;
    final value = _newPassword.text;
    final checks = [
      ('Tối thiểu 8 ký tự', value.length >= 8),
      ('Có chữ in hoa', RegExp('[A-Z]').hasMatch(value)),
      ('Có chữ số', RegExp('[0-9]').hasMatch(value)),
      ('Có ký tự đặc biệt', RegExp('[^A-Za-z0-9]').hasMatch(value)),
    ];
    return ProfilePanel(
      color: AppColors.surfaceLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'ĐỘ MẠNH MẬT KHẨU',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Row(
            children: List.generate(
              4,
              (index) => Expanded(
                child: Container(
                  height: 5,
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    color: index < _score ? color : AppColors.surfaceHighest,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 9),
          Wrap(
            spacing: 12,
            runSpacing: 7,
            children: checks
                .map(
                  (item) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item.$2
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        size: 14,
                        color: item.$2 ? AppColors.green : AppColors.textMuted,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item.$1,
                        style: TextStyle(
                          color: item.$2
                              ? AppColors.green
                              : AppColors.textMuted,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _otpPanel(BuildContext context) => ProfilePanel(
    color: AppColors.surfaceLow,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ProfileSectionTitle(
          'Mã Xác Thực 2 Lớp (OTP)',
          icon: Icons.phonelink_lock,
        ),
        const SizedBox(height: 5),
        const Text(
          'Nhập mã 6 số được gửi đến phương thức bảo mật đã liên kết.',
          style: TextStyle(color: AppColors.textMuted, fontSize: 11),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.input,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: TextFormField(
                  controller: _otp,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  validator: (v) =>
                      v == null || v.length < 6 ? 'Nhập mã OTP 6 số' : null,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 18,
                    letterSpacing: 5,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: const InputDecoration(
                    counterText: '',
                    hintText: 'Nhập 6 số OTP',
                    hintStyle: TextStyle(
                      color: AppColors.outlineVariant,
                      fontSize: 12,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 13,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: _otpCountdown > 0 ? null : _sendOtp,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.surfaceHigh,
                foregroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              child: Text(
                _otpCountdown > 0 ? '${_otpCountdown}s gửi lại' : 'Nhận mã OTP',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  void _evaluatePassword(String value) {
    final checks = [
      value.length >= 8,
      RegExp('[A-Z]').hasMatch(value),
      RegExp('[0-9]').hasMatch(value),
      RegExp('[^A-Za-z0-9]').hasMatch(value),
    ];
    setState(() {
      _score = checks.where((valid) => valid).length;
      _updateMatch();
    });
  }

  void _updateMatch() => _match =
      _newPassword.text.isNotEmpty &&
      _confirmPassword.text.isNotEmpty &&
      _newPassword.text == _confirmPassword.text;

  void _sendOtp() {
    setState(() => _otpCountdown = 60);
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
    if (!_formKey.currentState!.validate()) return;
    showDemoMessage(
      context,
      'Giao diện mẫu: cập nhật mật khẩu sẽ được kết nối ở giai đoạn sau.',
    );
  }
}
