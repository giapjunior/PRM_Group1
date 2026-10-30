import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../app/theme.dart';
import '../../../../shared/widgets/account_page_frame.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final _amountController = TextEditingController(text: '50.000.000');
  final _pinController = TextEditingController();
  int _method = 0;
  int _selectedBank = 0;
  bool _faceId = false;
  bool _sending = false;
  bool _success = false;
  bool _showPin = false;
  Timer? _actionTimer;

  static const _banks = ['Vietcombank', 'MB Bank'];
  static const _amounts = [5000000, 10000000, 20000000, 50000000];

  @override
  void dispose() {
    _actionTimer?.cancel();
    _amountController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AccountPageFrame(
    title: 'Rút Tiền',
    onBack: () => context.go(AppRoutes.profile),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _summaryCard(),
        const SizedBox(height: 15),
        const ProfileSectionTitle(
          'Kênh Rút Tiền Bảo Mật',
          icon: Icons.account_balance,
        ),
        const SizedBox(height: 8),
        _methodSelector(),
        const SizedBox(height: 15),
        _beneficiarySection(),
        const SizedBox(height: 15),
        _amountSection(),
        const SizedBox(height: 14),
        _pinSection(),
        const SizedBox(height: 13),
        _submitButton(),
        const SizedBox(height: 9),
        Row(
          children: [
            Expanded(
              child: _secondaryButton(
                Icons.receipt_long,
                'Lịch Sử Rút',
                'Lịch sử rút tiền sẽ hiện tại đây sau khi có giao dịch.',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _secondaryButton(
                Icons.menu_book,
                'Quy Định VIP',
                'Vui lòng xác minh tên hồ sơ trùng với chủ tài khoản nhận tiền.',
              ),
            ),
          ],
        ),
        const SizedBox(height: 17),
        _assuranceCard(
          Icons.speed,
          'Giải Ngân Siêu Tốc 24/7 Trong 60 Giây',
          'Hệ thống trung chuyển tự động kết nối cổng Napas & FastPay',
        ),
        const SizedBox(height: 8),
        _assuranceCard(
          Icons.lock_clock,
          'Bảo Mật Tài Chính Chuẩn Quân Đội',
          'SSL 256-Bit • Bảo vệ thông tin giao dịch hội viên',
        ),
        const SizedBox(height: 8),
        _assuranceCard(
          Icons.support_agent,
          'Hotline Khiếu Nại VIP Macau Trực Tuyến',
          'Đảm bảo 100% hoàn tiền nếu lệnh chậm trễ quá 5 phút',
        ),
      ],
    ),
  );

  Widget _summaryCard() => ProfilePanel(
    color: AppColors.surfaceLow,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 19,
              backgroundColor: AppColors.surfaceHigh,
              child: Icon(Icons.person, color: AppColors.primary, size: 21),
            ),
            const SizedBox(width: 9),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tài Xỉu Hoàng Gia • VIP 7',
                    style: TextStyle(
                      color: AppColors.text,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Thành viên Diamond',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 9),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.green.withValues(alpha: .14),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                children: [
                  Icon(Icons.bolt, color: AppColors.green, size: 14),
                  SizedBox(width: 3),
                  Text(
                    'DUYỆT TỰ ĐỘNG < 60S',
                    style: TextStyle(
                      color: AppColors.green,
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 13),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.input,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Số Dư Khả Dụng',
                style: TextStyle(color: AppColors.textMuted, fontSize: 10),
              ),
              const SizedBox(height: 3),
              const Text(
                '128.500.000 VNĐ',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: AppColors.green,
                    size: 15,
                  ),
                  const SizedBox(width: 5),
                  const Expanded(
                    child: Text(
                      'Doanh thu cược: Đã hoàn tất 100%',
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.green.withValues(alpha: .12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Đủ điều kiện',
                      style: TextStyle(
                        color: AppColors.green,
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              const Row(
                children: [
                  Icon(Icons.verified_user, color: AppColors.primary, size: 15),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      'Hạn mức ngày: Không giới hạn',
                      style: TextStyle(color: AppColors.textMuted, fontSize: 9),
                    ),
                  ),
                  Text(
                    'Tối đa 1 Tỷ / lệnh',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 9),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _methodSelector() => Container(
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(11),
    ),
    child: Row(
      children: [
        _methodButton(
          0,
          Icons.account_balance,
          'Ngân Hàng 24/7',
          'Tỷ lệ 1:1 • Phí 0đ',
        ),
        _methodButton(
          1,
          Icons.currency_bitcoin,
          'Ví Crypto USDT',
          'TRC20 / BEP20',
        ),
      ],
    ),
  );

  Widget _methodButton(
    int index,
    IconData icon,
    String title,
    String subtitle,
  ) => Expanded(
    child: InkWell(
      onTap: () => setState(() => _method = index),
      borderRadius: BorderRadius.circular(9),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
          color: _method == index ? AppColors.surfaceHigh : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 17,
                  color: _method == index
                      ? AppColors.primary
                      : AppColors.textMuted,
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: _method == index
                          ? AppColors.primary
                          : AppColors.textMuted,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _method == index ? AppColors.green : AppColors.textMuted,
                fontSize: 8,
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _beneficiarySection() => ProfilePanel(
    color: AppColors.surface,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Tài Khoản Thụ Hưởng VIP',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () => showDemoMessage(
                context,
                'Thêm thẻ mới sẽ khả dụng khi có backend.',
              ),
              icon: const Icon(Icons.add_circle, size: 15),
              label: const Text('Thêm Thẻ Mới', style: TextStyle(fontSize: 9)),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
              ),
            ),
          ],
        ),
        const SizedBox(height: 9),
        _bankCard(0, _banks[0], '**** **** **** 9988', 'Ưu Tiên 30s'),
        const SizedBox(height: 7),
        _bankCard(1, _banks[1], '**** **** **** 6622', ''),
        const SizedBox(height: 9),
        Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: .08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, size: 15, color: AppColors.primary),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Tên tài khoản ngân hàng thụ hưởng phải trùng khớp 100% với tên hồ sơ VIP: NGUYEN VAN HOANG.',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 9,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _bankCard(int index, String bank, String number, String badge) {
    final selected = _selectedBank == index;
    return InkWell(
      onTap: () => setState(() => _selectedBank = index),
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: selected ? AppColors.surfaceHigh : AppColors.input,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected
                ? AppColors.primary.withValues(alpha: .5)
                : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: AppColors.surfaceHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.account_balance,
                color: selected ? AppColors.primary : AppColors.textMuted,
                size: 18,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        bank,
                        style: const TextStyle(
                          color: AppColors.text,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (badge.isNotEmpty) ...[
                        const SizedBox(width: 5),
                        Text(
                          badge,
                          style: const TextStyle(
                            color: AppColors.green,
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    number,
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 10,
                      letterSpacing: .5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Chủ tài khoản: NGUYEN VAN HOANG',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 8),
                  ),
                ],
              ),
            ),
            Icon(
              selected ? Icons.check_circle : Icons.circle_outlined,
              color: selected ? AppColors.green : AppColors.outline,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  Widget _amountSection() => ProfilePanel(
    color: AppColors.surfaceLow,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Số Tiền Rút (VNĐ)',
          style: TextStyle(
            color: AppColors.text,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 7),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.input,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const Icon(Icons.payments, color: AppColors.primary, size: 20),
              const SizedBox(width: 7),
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  onChanged: _formatAmountInput,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Nhập số tiền muốn rút',
                    hintStyle: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  _amountController.clear();
                  setState(() {});
                },
                tooltip: 'Xóa số tiền',
                icon: const Icon(
                  Icons.cancel,
                  color: AppColors.textMuted,
                  size: 19,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(_amounts.length + 1, (index) {
            final all = index == _amounts.length;
            final amount = all ? 128500000 : _amounts[index];
            final selected = _parse(_amountController.text) == amount;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index == _amounts.length ? 0 : 5,
                ),
                child: InkWell(
                  onTap: () => _setAmount(amount),
                  borderRadius: BorderRadius.circular(7),
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.primary
                          : AppColors.surfaceHigh,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: Text(
                        all ? 'TẤT CẢ' : '${amount ~/ 1000000} Triệu',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selected
                              ? AppColors.onPrimary
                              : AppColors.text,
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Expanded(
              child: Text(
                'Phí giao dịch',
                style: TextStyle(color: AppColors.textMuted, fontSize: 10),
              ),
            ),
            const Text(
              '0% (Miễn phí VIP)',
              style: TextStyle(
                color: AppColors.green,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            const Expanded(
              child: Text(
                'Thời gian dự kiến',
                style: TextStyle(color: AppColors.textMuted, fontSize: 10),
              ),
            ),
            const Text(
              '< 30 giây',
              style: TextStyle(color: AppColors.text, fontSize: 10),
            ),
          ],
        ),
        const Divider(height: 15, color: AppColors.surfaceHigh),
        Row(
          children: [
            const Expanded(
              child: Text(
                'Thực nhận',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              '${_format(_parse(_amountController.text))} đ',
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _pinSection() => ProfilePanel(
    color: AppColors.surface,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Icon(Icons.lock, size: 18, color: AppColors.primary),
            const SizedBox(width: 7),
            const Expanded(
              child: Text(
                'Mã PIN Két Sắt Rút Tiền',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            TextButton(
              onPressed: () => context.go(AppRoutes.passwordRecovery),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
              ),
              child: const Text('Quên mã PIN?', style: TextStyle(fontSize: 9)),
            ),
          ],
        ),
        const SizedBox(height: 7),
        Container(
          decoration: BoxDecoration(
            color: AppColors.input,
            borderRadius: BorderRadius.circular(9),
          ),
          child: TextField(
            controller: _pinController,
            keyboardType: TextInputType.number,
            maxLength: 6,
            obscureText: !_showPin,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 18,
              letterSpacing: 12,
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              counterText: '',
              hintText: '●  ●  ●  ●  ●  ●',
              hintStyle: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 11,
                letterSpacing: 4,
              ),
              border: InputBorder.none,
              suffixIcon: IconButton(
                onPressed: () => setState(() => _showPin = !_showPin),
                icon: Icon(
                  _showPin ? Icons.visibility_off : Icons.visibility,
                  size: 17,
                  color: AppColors.textMuted,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => setState(() => _faceId = !_faceId),
                child: Row(
                  children: [
                    Icon(
                      _faceId ? Icons.check_circle : Icons.fingerprint,
                      size: 18,
                      color: _faceId ? AppColors.green : AppColors.primary,
                    ),
                    const SizedBox(width: 5),
                    const Flexible(
                      child: Text(
                        'Xác thực Face ID / Sinh trắc học',
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () =>
                  showDemoMessage(context, 'Đã gửi yêu cầu OTP Telegram.'),
              icon: const Icon(Icons.send, size: 13),
              label: const Text('OTP Telegram', style: TextStyle(fontSize: 9)),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                backgroundColor: AppColors.surfaceHigh,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                minimumSize: Size.zero,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _submitButton() => SizedBox(
    height: 55,
    child: ElevatedButton.icon(
      onPressed: _sending ? null : _submit,
      icon: Icon(
        _sending
            ? Icons.hourglass_top
            : _success
            ? Icons.check_circle
            : Icons.verified,
        size: 22,
      ),
      label: Text(
        _sending
            ? 'Đang Kết Nối Cổng VIP...'
            : _success
            ? 'Lệnh Rút Đã Gửi Thành Công!'
            : 'XÁC NHẬN RÚT TIỀN 1:1',
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          letterSpacing: .4,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: _success ? AppColors.green : AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        disabledBackgroundColor: AppColors.surfaceHigh,
        disabledForegroundColor: AppColors.textMuted,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
      ),
    ),
  );

  Widget _secondaryButton(IconData icon, String title, String message) =>
      OutlinedButton.icon(
        onPressed: () => showDemoMessage(context, message),
        icon: Icon(icon, size: 17),
        label: Text(
          title,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.text,
          backgroundColor: AppColors.surfaceHigh,
          side: BorderSide.none,
          padding: const EdgeInsets.symmetric(vertical: 11),
        ),
      );

  Widget _assuranceCard(IconData icon, String title, String subtitle) =>
      Container(
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: .13),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 19, color: AppColors.primary),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.text,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  void _setAmount(int value) {
    _amountController.text = _format(value);
    setState(() {});
  }

  void _formatAmountInput(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    final formatted = digits.isEmpty ? '' : _format(int.parse(digits));
    if (_amountController.text != formatted) {
      _amountController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
    setState(() {});
  }

  void _submit() {
    final amount = _parse(_amountController.text);
    if (amount <= 0 || amount > 1000000000) {
      showDemoMessage(
        context,
        'Vui lòng nhập số tiền rút hợp lệ, tối đa 1 tỷ mỗi lệnh.',
      );
      return;
    }
    if (_pinController.text.length != 6) {
      showDemoMessage(context, 'Vui lòng nhập đủ mã PIN 6 số.');
      return;
    }
    setState(() {
      _sending = true;
      _success = false;
    });
    _actionTimer?.cancel();
    _actionTimer = Timer(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      setState(() {
        _sending = false;
        _success = true;
      });
      showDemoMessage(context, 'Giao diện mẫu: lệnh rút đã được gửi.');
      _actionTimer = Timer(const Duration(milliseconds: 2500), () {
        if (mounted) setState(() => _success = false);
      });
    });
  }

  int _parse(String value) =>
      int.tryParse(value.replaceAll(RegExp(r'\D'), '')) ?? 0;

  String _format(int value) => value.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (match) => '.',
  );
}
