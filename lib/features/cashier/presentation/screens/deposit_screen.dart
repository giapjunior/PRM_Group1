import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../app/theme.dart';
import '../../../../shared/widgets/account_page_frame.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final _amountController = TextEditingController(text: '1.000.000');
  int _channel = 0;
  int _bank = 0;
  bool _refreshing = false;

  static const _banks = ['Vietcombank', 'MB Bank', 'Techcombank'];
  static const _bankCodes = ['VCB', 'MB', 'TCB'];
  static const _amounts = [
    200000,
    500000,
    1000000,
    5000000,
    10000000,
    50000000,
  ];

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AccountPageFrame(
    title: 'Nạp Tiền',
    onBack: () => context.go(AppRoutes.profile),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _balanceCard(),
        const SizedBox(height: 12),
        _promotionCard(),
        const SizedBox(height: 18),
        const ProfileSectionTitle(
          'Kênh nạp tiền',
          icon: Icons.account_balance_wallet,
        ),
        const SizedBox(height: 8),
        _channels(),
        const SizedBox(height: 14),
        _bankDetails(),
        const SizedBox(height: 14),
        _amountPanel(),
        const SizedBox(height: 14),
        _submitButton(),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: () => showDemoMessage(
            context,
            'Lịch sử nạp tiền sẽ khả dụng khi có dữ liệu giao dịch.',
          ),
          icon: const Icon(Icons.receipt_long, size: 19),
          label: const Text('Xem Lịch Sử Nạp Tiền'),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.text,
            backgroundColor: AppColors.surfaceHigh,
            side: BorderSide.none,
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
        const SizedBox(height: 14),
        _trustRow(),
        const SizedBox(height: 10),
        const Text(
          'Giao dịch được quản lý bởi hệ thống đối soát VIP Macau. Quá 2 phút chưa lên điểm, vui lòng kết nối Chuyên Viên VIP 1-kèm-1.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 10,
            height: 1.4,
          ),
        ),
      ],
    ),
  );

  Widget _balanceCard() => ProfilePanel(
    color: AppColors.surfaceLow,
    child: Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: .14),
            borderRadius: BorderRadius.circular(11),
          ),
          child: const Icon(
            Icons.account_balance_wallet,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Số dư khả dụng',
                style: TextStyle(color: AppColors.textMuted, fontSize: 10),
              ),
              SizedBox(height: 3),
              Text(
                '128.500.000 VNĐ',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: _refreshBalance,
          tooltip: 'Làm mới số dư',
          icon: _refreshing
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.refresh, color: AppColors.textMuted),
        ),
        const SizedBox(width: 4),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'VIP 7',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 3),
            Text(
              'DIAMOND',
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 8,
                letterSpacing: .5,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _promotionCard() => Container(
    padding: const EdgeInsets.all(13),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF6B3800), AppColors.surfaceHigh, AppColors.surface],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.primary.withValues(alpha: .35)),
    ),
    child: Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: .18),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.stars, color: AppColors.primary),
        ),
        const SizedBox(width: 9),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SIÊU ƯU ĐÃI VIP +100%',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Nạp lần đầu tặng tới 20.000.000 VNĐ • Tự động kích hoạt',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 9,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
        const Icon(Icons.chevron_right, size: 19, color: AppColors.primary),
      ],
    ),
  );

  Widget _channels() {
    const items = [
      (
        Icons.account_balance,
        'Chuyển Ngân Hàng',
        'VietQR Tự Động 24/7',
        'SIÊU TỐC 30S',
      ),
      (
        Icons.currency_bitcoin,
        'Tiền Điện Tử',
        'USDT TRC20 / BEP20',
        'ẨN DANH +2%',
      ),
      (
        Icons.account_balance_wallet,
        'Ví Điện Tử',
        'MoMo, ZaloPay, Viettel',
        'TỰ ĐỘNG',
      ),
      (Icons.sim_card, 'Thẻ Cào Di Động', 'Viettel, Vina, Mobi', 'THẺ CÀO'),
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        mainAxisExtent: 92,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        final selected = _channel == index;
        return InkWell(
          onTap: () => setState(() => _channel = index),
          borderRadius: BorderRadius.circular(11),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: selected ? AppColors.surfaceHigh : AppColors.surface,
              borderRadius: BorderRadius.circular(11),
              border: Border.all(
                color: selected
                    ? AppColors.primary.withValues(alpha: .55)
                    : AppColors.surfaceHigh,
              ),
              boxShadow: selected
                  ? const [BoxShadow(color: Color(0x22000000), blurRadius: 7)]
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      item.$1,
                      size: 18,
                      color: selected ? AppColors.primary : AppColors.textMuted,
                    ),
                    const Spacer(),
                    Flexible(
                      child: Text(
                        item.$4,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: AppColors.green,
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.$2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: selected ? AppColors.primary : AppColors.text,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item.$3,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _bankDetails() => ProfilePanel(
    color: AppColors.surface,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Chọn ngân hàng thụ hưởng',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.green.withValues(alpha: .12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.verified, color: AppColors.green, size: 13),
                  SizedBox(width: 4),
                  Text(
                    'Khớp lệnh tức thì',
                    style: TextStyle(
                      color: AppColors.green,
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: List.generate(_banks.length, (index) {
            final selected = _bank == index;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index == _banks.length - 1 ? 0 : 7,
                ),
                child: InkWell(
                  onTap: () {
                    setState(() => _bank = index);
                    showDemoMessage(
                      context,
                      'Đã đổi tài khoản sang ${_bankCodes[index]}.',
                    );
                  },
                  borderRadius: BorderRadius.circular(9),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 4,
                    ),
                    decoration: BoxDecoration(
                      color: selected ? AppColors.surfaceHigh : AppColors.input,
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(
                        color: selected
                            ? AppColors.primary.withValues(alpha: .4)
                            : Colors.transparent,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          _bankCodes[index],
                          style: TextStyle(
                            color: selected
                                ? AppColors.primary
                                : AppColors.text,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          _banks[index],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 11),
        Container(
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            color: AppColors.input,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.qr_code_2,
                    size: 20,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 7),
                  const Expanded(
                    child: Text(
                      'VIETQR PRO • CHUẨN NAPAS',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: .4,
                      ),
                    ),
                  ),
                  const Text(
                    'Tự động 24/7',
                    style: TextStyle(color: AppColors.green, fontSize: 9),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Quét mã QR để nạp tự động. Không cần nhập số tiền và nội dung thủ công.',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 9,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _copyRow(
                'Ngân hàng thụ hưởng',
                _banks[_bank],
                Icons.account_balance,
                AppColors.textMuted,
              ),
              const Divider(height: 16, color: AppColors.surfaceHigh),
              _copyRow(
                'Số tài khoản VIP',
                '9988 7766 5522',
                Icons.account_balance_wallet,
                AppColors.primary,
              ),
              const Divider(height: 16, color: AppColors.surfaceHigh),
              _copyRow(
                'Chủ tài khoản',
                'CTY TNHH DICH VU MACAU VIP',
                Icons.person,
                AppColors.text,
              ),
              const Divider(height: 16, color: AppColors.surfaceHigh),
              _copyRow(
                'Nội dung chuyển khoản (MEMO BẮT BUỘC)',
                'NAP88 TX992',
                Icons.warning_amber,
                AppColors.primary,
                emphasized: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
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
                  'Bắt buộc điền đúng nội dung NAP88 TX992 để hệ thống lên điểm tự động. Không thêm bớt ký tự.',
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

  Widget _copyRow(
    String label,
    String value,
    IconData icon,
    Color color, {
    bool emphasized = false,
  }) => Row(
    children: [
      Icon(icon, size: 15, color: color),
      const SizedBox(width: 6),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(color: AppColors.textMuted, fontSize: 8),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color,
                fontSize: emphasized ? 14 : 10,
                fontWeight: emphasized ? FontWeight.w700 : FontWeight.w600,
                letterSpacing: emphasized ? .7 : 0,
              ),
            ),
          ],
        ),
      ),
      TextButton.icon(
        onPressed: () => _copy(value),
        icon: const Icon(Icons.content_copy, size: 13),
        label: const Text('Sao chép', style: TextStyle(fontSize: 9)),
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          minimumSize: Size.zero,
        ),
      ),
    ],
  );

  Widget _amountPanel() => ProfilePanel(
    color: AppColors.surfaceLow,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Chọn nhanh số tiền nạp',
          style: TextStyle(
            color: AppColors.text,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 3),
        const Text(
          'Tối thiểu: 100K - Tối đa: 500M',
          style: TextStyle(color: AppColors.textMuted, fontSize: 9),
        ),
        const SizedBox(height: 9),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _amounts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 7,
            crossAxisSpacing: 7,
            mainAxisExtent: 48,
          ),
          itemBuilder: (context, index) {
            final amount = _amounts[index];
            final selected = _digits(_amountController.text) == amount;
            return InkWell(
              onTap: () => _setAmount(amount),
              borderRadius: BorderRadius.circular(9),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.primaryContainer
                      : AppColors.surfaceHigh,
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(
                    color: selected ? AppColors.primary : Colors.transparent,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _formatAmount(amount),
                      style: TextStyle(
                        color: selected
                            ? AppColors.onPrimaryContainer
                            : AppColors.text,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      amount == 1000000 ? '(Khuyên dùng)' : 'VNĐ',
                      style: TextStyle(
                        color: selected
                            ? AppColors.onPrimaryContainer
                            : AppColors.textMuted,
                        fontSize: 8,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        const Text(
          'Hoặc nhập số tiền tùy chọn (VNĐ)',
          style: TextStyle(color: AppColors.textMuted, fontSize: 10),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 11),
          decoration: BoxDecoration(
            color: AppColors.input,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const Icon(Icons.payments, color: AppColors.primary, size: 19),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  onChanged: _formatAmountInput,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Ví dụ: 2.500.000',
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
                  Icons.close,
                  size: 17,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.bolt, size: 16, color: AppColors.primary),
            const SizedBox(width: 5),
            const Expanded(
              child: Text(
                'Điểm cược quy đổi nhận được',
                style: TextStyle(color: AppColors.textMuted, fontSize: 10),
              ),
            ),
            Text(
              '${_formatAmount(_digits(_amountController.text))} ĐIỂM',
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _submitButton() => SizedBox(
    height: 54,
    child: DecoratedBox(
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
            color: Color(0x33F59E0B),
            blurRadius: 13,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: _createDeposit,
        icon: const Icon(Icons.bolt, size: 23),
        label: const Text(
          'TẠO LỆNH NẠP TIỀN',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: .6,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.onPrimaryContainer,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ),
  );

  Widget _trustRow() => Row(
    children: [
      _trustBadge(Icons.percent, 'Tỷ lệ 1:1', 'Không trừ phí'),
      const SizedBox(width: 7),
      _trustBadge(Icons.lock, 'SSL 256-Bit', 'Bảo mật mã hóa'),
      const SizedBox(width: 7),
      _trustBadge(Icons.headset_mic, 'Hỗ trợ 24/7', 'Phản hồi 2 phút'),
    ],
  );

  Widget _trustBadge(IconData icon, String title, String subtitle) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 17),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 8,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.textMuted, fontSize: 7),
          ),
        ],
      ),
    ),
  );

  Future<void> _copy(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (mounted) showDemoMessage(context, 'Đã sao chép: $text');
  }

  void _refreshBalance() {
    if (_refreshing) return;
    setState(() => _refreshing = true);
    Timer(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() => _refreshing = false);
      showDemoMessage(context, 'Số dư đã được cập nhật.');
    });
  }

  void _setAmount(int amount) {
    _amountController.text = _formatAmount(amount);
    setState(() {});
  }

  void _formatAmountInput(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    final formatted = digits.isEmpty ? '' : _formatAmount(int.parse(digits));
    if (_amountController.text != formatted) {
      _amountController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
    setState(() {});
  }

  void _createDeposit() {
    final amount = _digits(_amountController.text);
    if (amount < 100000 || amount > 500000000) {
      showDemoMessage(
        context,
        'Số tiền nạp cần từ 100.000 đến 500.000.000 VNĐ.',
      );
      return;
    }
    showDemoMessage(
      context,
      'Đang khởi tạo lệnh nạp: ${_formatAmount(amount)} VNĐ.',
    );
  }

  int _digits(String value) =>
      int.tryParse(value.replaceAll(RegExp(r'\D'), '')) ?? 0;

  String _formatAmount(int amount) => amount.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (match) => '.',
  );
}
