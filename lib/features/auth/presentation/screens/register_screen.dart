import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../app/theme.dart';
import '../../../../app/routes.dart';
import '../widgets/auth_common_widgets.dart';
import '../providers/auth_ui_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController(text: 'hoangtutaixiu99');
  final _password = TextEditingController(text: 'HoangGiaVIP@2025');
  final _confirmPassword = TextEditingController(text: 'HoangGiaVIP@2025');
  final _phone = TextEditingController();
  final _giftCode = TextEditingController(text: 'VIPTAIXIU100K');
  bool _showPassword = false;
  bool _showConfirm = false;
  bool _acceptedTerms = true;
  bool _codeApplied = true;

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _phone.dispose();
    _giftCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final submitting = context.watch<AuthUiProvider>().submitting;
    return AuthPage(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _brandPresentation(),
            const SizedBox(height: 16),
            const AuthTabs(registerSelected: true),
            const SizedBox(height: 16),
            _registrationForm(context, submitting),
            const SizedBox(height: 16),
            _benefits(),
            const SizedBox(height: 14),
            _bottomSupport(context),
          ],
        ),
      ),
    );
  }

  Widget _brandPresentation() => Column(
    children: [
      Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Color(0x55FFC174), blurRadius: 22)],
            ),
          ),
          brandLogo(size: 80),
        ],
      ),
      const SizedBox(height: 7),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.red.withValues(alpha: .9),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [BoxShadow(color: Color(0x33000000), blurRadius: 6)],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.stars, size: 15, color: AppColors.primary),
            SizedBox(width: 5),
            Text(
              'TẶNG CODE 100K CHO TÂN THỦ',
              style: TextStyle(
                color: AppColors.pink,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: .8,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 8),
      const Text(
        'TẠO TÀI KHOẢN MỚI',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: .7,
        ),
      ),
      const SizedBox(height: 3),
      const Text(
        'Gia nhập sảnh thượng lưu • Khởi nghiệp rực rỡ',
        style: TextStyle(color: AppColors.textMuted, fontSize: 12),
      ),
    ],
  );

  Widget _registrationForm(BuildContext context, bool submitting) => formCard(
    color: AppColors.surface,
    padding: const EdgeInsets.all(14),
    child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FieldLabel(
            'TÊN ĐĂNG NHẬP (NICKNAME)',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  size: 14,
                  color: _username.text.length >= 6
                      ? AppColors.green
                      : AppColors.pink,
                ),
                const SizedBox(width: 3),
                Text(
                  _username.text.length >= 6 ? 'Hợp lệ' : 'Từ 6 ký tự',
                  style: TextStyle(
                    color: _username.text.length >= 6
                        ? AppColors.green
                        : AppColors.pink,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          AuthInput(
            controller: _username,
            icon: Icons.person,
            hint: 'Từ 6 - 16 ký tự viết liền',
            textCapitalization: TextCapitalization.none,
            onChanged: (_) => setState(() {}),
            validator: (v) =>
                v == null || v.trim().length < 6 || v.trim().length > 16
                ? 'Tên đăng nhập cần từ 6 đến 16 ký tự'
                : null,
            trailing: const Padding(
              padding: EdgeInsets.only(right: 4),
              child: Icon(Icons.verified, size: 20, color: AppColors.green),
            ),
          ),
          const SizedBox(height: 12),
          FieldLabel(
            'MẬT KHẨU',
            trailing: const Text(
              'Tối thiểu 6 ký tự',
              style: TextStyle(color: AppColors.textMuted, fontSize: 11),
            ),
          ),
          const SizedBox(height: 5),
          AuthInput(
            controller: _password,
            icon: Icons.lock,
            hint: 'Nhập mật khẩu an toàn',
            obscure: !_showPassword,
            onChanged: (_) => setState(() {}),
            validator: (v) => v == null || v.length < 6
                ? 'Mật khẩu cần tối thiểu 6 ký tự'
                : null,
            trailing: IconButton(
              onPressed: () => setState(() => _showPassword = !_showPassword),
              icon: Icon(
                _showPassword ? Icons.visibility_off : Icons.visibility,
                color: AppColors.outline,
                size: 20,
              ),
              visualDensity: VisualDensity.compact,
            ),
          ),
          const SizedBox(height: 6),
          _passwordStrength(),
          const SizedBox(height: 12),
          const FieldLabel('XÁC NHẬN MẬT KHẨU'),
          const SizedBox(height: 5),
          AuthInput(
            controller: _confirmPassword,
            icon: Icons.lock_reset,
            hint: 'Nhập lại mật khẩu',
            obscure: !_showConfirm,
            validator: (v) =>
                v != _password.text ? 'Mật khẩu xác nhận chưa khớp' : null,
            trailing: IconButton(
              onPressed: () => setState(() => _showConfirm = !_showConfirm),
              icon: Icon(
                _showConfirm ? Icons.visibility_off : Icons.visibility,
                color: AppColors.outline,
                size: 20,
              ),
              visualDensity: VisualDensity.compact,
            ),
          ),
          const SizedBox(height: 12),
          FieldLabel(
            'SỐ ĐIỆN THOẠI / ZALO',
            trailing: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.shield, size: 13, color: Color(0xFF4EDEA3)),
                SizedBox(width: 3),
                Text(
                  'Bảo mật rút tiền',
                  style: TextStyle(color: Color(0xFF4EDEA3), fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          AuthInput(
            controller: _phone,
            icon: Icons.phone_iphone,
            hint: 'Nhập số nhận OTP kích hoạt',
            keyboardType: TextInputType.phone,
            validator: (v) => v == null || v.trim().length < 9
                ? 'Vui lòng nhập số điện thoại hợp lệ'
                : null,
            trailing: Container(
              margin: const EdgeInsets.only(right: 5),
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.surfaceHigh,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'OTP SMS',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          FieldLabel(
            'MÃ GIỚI THIỆU / GIFTCODE',
            trailing: const Text(
              '+100.000 VNĐ',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: AuthInput(
                  controller: _giftCode,
                  icon: Icons.card_giftcard,
                  hint: 'Nhập mã quà tặng',
                  textCapitalization: TextCapitalization.characters,
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() => _codeApplied = true);
                  showDemoMessage(context, 'Giftcode đã được áp dụng.');
                },
                icon: const Icon(Icons.check, size: 16),
                label: Text(_codeApplied ? 'Đã Áp Dụng' : 'Áp Dụng'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryContainer,
                  foregroundColor: AppColors.onPrimaryContainer,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  value: _acceptedTerms,
                  onChanged: (v) => setState(() => _acceptedTerms = v ?? false),
                  activeColor: AppColors.primary,
                  checkColor: AppColors.onPrimary,
                  side: const BorderSide(color: AppColors.outlineVariant),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Text(
                      'Tôi xác nhận đủ ',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 11,
                        height: 1.55,
                      ),
                    ),
                    const Text(
                      '18 tuổi',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                      ),
                    ),
                    const Text(
                      ' và hoàn toàn đồng ý với ',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 11,
                        height: 1.55,
                      ),
                    ),
                    _inlineLink(context, 'Điều khoản dịch vụ'),
                    const Text(
                      ' & ',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 11,
                      ),
                    ),
                    _inlineLink(context, 'Quy tắc cược công bằng'),
                    const Text(
                      '.',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColors.primary,
                  Color(0xFFFFB95F),
                  AppColors.primary,
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x66F59E0B),
                  blurRadius: 18,
                  offset: Offset(0, 7),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: submitting
                  ? null
                  : () async {
                      final valid = _formKey.currentState!.validate();
                      if (!_acceptedTerms) {
                        showDemoMessage(
                          context,
                          'Vui lòng xác nhận điều khoản để tiếp tục.',
                        );
                      } else if (valid) {
                        await context.read<AuthUiProvider>().submitMockAction();
                        if (context.mounted) {
                          showDemoMessage(
                            context,
                            'Giao diện mẫu: đăng ký sẽ được kết nối ở giai đoạn sau.',
                          );
                        }
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: AppColors.onPrimary,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (submitting)
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.onPrimary,
                      ),
                    )
                  else
                    const Icon(Icons.redeem, size: 24),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      submitting ? 'ĐANG XỬ LÝ...' : 'ĐĂNG KÝ NHẬN THƯỞNG 100K',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: .6,
                      ),
                    ),
                  ),
                  const SizedBox(width: 7),
                  const Icon(Icons.arrow_forward, size: 22),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _passwordStrength() {
    final value = _password.text;
    final score = [
      value.length >= 6,
      RegExp(r'[A-Z]').hasMatch(value) && RegExp(r'[a-z]').hasMatch(value),
      RegExp(r'[0-9]').hasMatch(value) ||
          RegExp(r'[^A-Za-z0-9]').hasMatch(value),
    ].where((e) => e).length;
    final color = score <= 1
        ? AppColors.pink
        : score == 2
        ? AppColors.primary
        : AppColors.green;
    final label = score <= 1
        ? 'Yếu'
        : score == 2
        ? 'Vừa'
        : 'Mạnh';
    return Row(
      children: [
        for (var i = 0; i < 3; i++)
          Expanded(
            child: Container(
              height: 6,
              margin: EdgeInsets.only(right: i == 2 ? 0 : 5),
              decoration: BoxDecoration(
                color: i < score ? color : AppColors.surfaceHighest,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        const SizedBox(width: 7),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _inlineLink(BuildContext context, String text) => GestureDetector(
    onTap: () => showDemoMessage(
      context,
      '$text sẽ được cung cấp ở giai đoạn tiếp theo.',
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: AppColors.primary,
        fontSize: 11,
        decoration: TextDecoration.underline,
      ),
    ),
  );

  Widget _benefits() => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: AppColors.surfaceLow,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [BoxShadow(color: Color(0x33000000), blurRadius: 12)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Row(
          children: [
            Icon(Icons.military_tech, size: 20, color: AppColors.primary),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'ĐẶC QUYỀN HỘI VIÊN HOÀNG GIA',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 11),
        _benefit(
          Icons.bolt,
          AppColors.primary,
          'Nạp Rút Siêu Tốc 1:1',
          'Khớp lệnh tự động 30 giây không phụ phí',
        ),
        const SizedBox(height: 9),
        _benefit(
          Icons.enhanced_encryption,
          AppColors.green,
          'Bảo Mật OTP Chuẩn Quốc Tế',
          'Mã hóa Telegram & SMS ngăn ngừa rủi ro 100%',
        ),
        const SizedBox(height: 9),
        _benefit(
          Icons.casino,
          AppColors.pink,
          'Minh Bạch Thuật Toán MD5',
          'Cân cửa tự do, kiểm tra chuỗi Hash xanh chín',
        ),
      ],
    ),
  );

  Widget _benefit(IconData icon, Color color, String title, String subtitle) =>
      Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.surfaceHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.text,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _bottomSupport(BuildContext context) => Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Đã có tài khoản VIP? ',
            style: TextStyle(color: AppColors.textMuted, fontSize: 14),
          ),
          TextButton.icon(
            onPressed: () => context.go(AppRoutes.login),
            iconAlignment: IconAlignment.end,
            icon: const Icon(Icons.chevron_right, size: 16),
            label: const Text('Đăng nhập ngay'),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
              padding: EdgeInsets.zero,
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 7),
      const Wrap(
        alignment: WrapAlignment.center,
        spacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(Icons.support_agent, size: 16, color: AppColors.green),
          Text(
            'HỖ TRỢ CSKH 24/7',
            style: TextStyle(
              color: AppColors.outline,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text('•', style: TextStyle(color: AppColors.outline)),
          Icon(Icons.verified_user, size: 16, color: AppColors.primary),
          Text(
            'SSL 256-BIT',
            style: TextStyle(
              color: AppColors.outline,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ],
  );
}
