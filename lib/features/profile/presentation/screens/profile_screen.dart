import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../app/theme.dart';
import '../../../../shared/widgets/account_page_frame.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _balanceHidden = false;
  bool _copied = false;
  Timer? _copyTimer;

  @override
  void dispose() {
    _copyTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AccountPageFrame(
    title: 'Hồ Sơ Cá Nhân',
    onBack: () =>
        showDemoMessage(context, 'Trang chủ sẽ được kết nối ở giai đoạn sau.'),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _profileHero(),
        const SizedBox(height: 14),
        _walletCard(context),
        const SizedBox(height: 14),
        _shortcuts(context),
        const SizedBox(height: 14),
        _performanceCard(),
        const SizedBox(height: 14),
        _vipBanner(),
        const SizedBox(height: 14),
        _profileMenu(context),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => showDemoMessage(
              context,
              'Đăng xuất sẽ được kết nối khi có backend.',
            ),
            icon: const Icon(Icons.logout, size: 20),
            label: const Text('ĐĂNG XUẤT TÀI KHOẢN'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFFFB4AB),
              backgroundColor: AppColors.surface,
              side: BorderSide.none,
              padding: const EdgeInsets.symmetric(vertical: 14),
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Tài Xỉu Hoàng Gia • Phiên bản VIP 3.8.2 (Macau Edition)\nGiấy phép sòng bạc trực tuyến số PAGCOR #88-HG-2024',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 9,
            height: 1.5,
          ),
        ),
      ],
    ),
  );

  Widget _profileHero() => ProfilePanel(
    color: AppColors.surface,
    child: Column(
      children: [
        Row(
          children: [
            Container(
              width: 76,
              height: 76,
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryContainer],
                ),
                boxShadow: [
                  BoxShadow(color: Color(0x55F59E0B), blurRadius: 14),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/profile_avatar.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Flexible(
                        child: Text(
                          'Đại Gia Macau',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.verified,
                        size: 17,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceHigh,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.diamond, size: 12, color: AppColors.primary),
                        SizedBox(width: 4),
                        Text(
                          'Hoàng Gia Diamond',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.input,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Row(
                          children: [
                            const Text(
                              '#889988',
                              style: TextStyle(
                                color: AppColors.text,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 3),
                            InkWell(
                              onTap: _copyMemberId,
                              child: Icon(
                                _copied ? Icons.check : Icons.content_copy,
                                size: 13,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 7),
                      const Flexible(
                        child: Text(
                          'Gia nhập: 18/03/2023',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 9,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 7),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'CẤP BẢO VỆ',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: .5,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.shield, color: AppColors.green, size: 17),
                    Text(
                      '98%',
                      style: TextStyle(
                        color: AppColors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.surfaceHigh.withValues(alpha: .55),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.stars, color: AppColors.primary, size: 15),
                  const SizedBox(width: 5),
                  const Expanded(
                    child: Text(
                      'Tiến độ lên VIP 8 (Hoàng Kim Vương)',
                      style: TextStyle(color: AppColors.textMuted, fontSize: 9),
                    ),
                  ),
                  const Text(
                    '82.500 / 100.000 EXP',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: const LinearProgressIndicator(
                  value: .825,
                  minHeight: 7,
                  backgroundColor: AppColors.input,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _walletCard(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [AppColors.surfaceHigh, AppColors.surface, AppColors.input],
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x44000000),
          blurRadius: 14,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.account_balance_wallet,
                        color: AppColors.primary,
                        size: 16,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'SỐ DƯ KHẢ DỤNG',
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: .6,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          _balanceHidden ? '••••••••••••' : '128.500.000',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'VNĐ',
                        style: TextStyle(
                          color: Color(0xFFFFDDB8),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      IconButton(
                        onPressed: () =>
                            setState(() => _balanceHidden = !_balanceHidden),
                        visualDensity: VisualDensity.compact,
                        icon: Icon(
                          _balanceHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 17,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Row(
                  children: [
                    Icon(Icons.military_tech, color: AppColors.green, size: 14),
                    SizedBox(width: 4),
                    Text(
                      'VIP POINT',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.input,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Text(
                        '14.250',
                        style: TextStyle(
                          color: AppColors.green,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 3),
                      Text(
                        'pts',
                        style: TextStyle(color: AppColors.green, fontSize: 9),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: AppColors.input.withValues(alpha: .9),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.surfaceHigh,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.lock,
                  color: AppColors.primary,
                  size: 17,
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Két Sắt Hoàng Gia',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      '500.000.000 VNĐ',
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton.icon(
                onPressed: () => showDemoMessage(
                  context,
                  'Két sắt sẽ được kết nối ở giai đoạn sau.',
                ),
                iconAlignment: IconAlignment.end,
                icon: const Icon(Icons.arrow_forward_ios, size: 12),
                label: const Text('Mở Két'),
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.surfaceHigh,
                  foregroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _cashierButton(
                context,
                Icons.add_circle,
                'Nạp Tiền Nhanh',
                highlighted: true,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _cashierButton(context, Icons.payments, 'Rút Siêu Tốc'),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _cashierButton(
    BuildContext context,
    IconData icon,
    String label, {
    bool highlighted = false,
  }) => ElevatedButton.icon(
    onPressed: () => context.go(
      label.startsWith('Nạp') ? AppRoutes.deposit : AppRoutes.withdraw,
    ),
    icon: Icon(icon, size: 19),
    label: Text(
      label,
      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: highlighted
          ? AppColors.primary
          : AppColors.surfaceHighest,
      foregroundColor: highlighted
          ? AppColors.onPrimaryContainer
          : AppColors.text,
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 6),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );

  Widget _shortcuts(BuildContext context) {
    final items = [
      (Icons.casino, 'Lịch Sử Cược', AppColors.pink),
      (Icons.lock, 'Két Sắt VIP', AppColors.primary),
      (Icons.account_balance, 'Ngân Hàng', AppColors.green),
      (Icons.assignment_turned_in, 'Nhiệm Vụ VIP', AppColors.primary),
    ];
    return Row(
      children: items
          .map(
            (item) => Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 7),
                child: InkWell(
                  onTap: () => showDemoMessage(
                    context,
                    '${item.$2} sẽ được kết nối ở giai đoạn sau.',
                  ),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 9,
                      horizontal: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: item.$3.withValues(alpha: .16),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(item.$1, color: item.$3, size: 21),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          item.$2,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: const TextStyle(
                            color: AppColors.text,
                            fontSize: 9,
                            height: 1.15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _performanceCard() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const Padding(
        padding: EdgeInsets.only(bottom: 7),
        child: Row(
          children: [
            Icon(Icons.equalizer, size: 20, color: AppColors.primary),
            SizedBox(width: 6),
            Expanded(
              child: Text(
                'Chiến Tích Tài Xỉu',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              'Tháng Này',
              style: TextStyle(color: AppColors.textMuted, fontSize: 10),
            ),
          ],
        ),
      ),
      Row(
        children: [
          Expanded(
            child: _statCard(
              'Tổng Ván Cược',
              '1.820',
              'Tài: 940  |  Xỉu: 880',
              Icons.history,
              AppColors.text,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _statCard(
              'Tỉ Lệ Thắng',
              '68.4%',
              'Đẳng cấp VIP',
              Icons.trending_up,
              AppColors.green,
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Container(
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0x44A40217), AppColors.surface],
          ),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.local_fire_department,
                color: AppColors.pink,
                size: 23,
              ),
            ),
            const SizedBox(width: 9),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'HŨ NỔ LỚN NHẤT',
                        style: TextStyle(
                          color: AppColors.pink,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        'TÀI BÃO',
                        style: TextStyle(
                          color: AppColors.pink,
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3),
                  Text(
                    '850.000.000 VNĐ',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Kỷ lục VIP',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 9),
                ),
                Text(
                  'Thắng 12 Ván Liên Tiếp',
                  style: TextStyle(
                    color: AppColors.green,
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );

  Widget _statCard(
    String title,
    String value,
    String detail,
    IconData icon,
    Color color,
  ) => Container(
    padding: const EdgeInsets.all(11),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(11),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 10,
                ),
              ),
            ),
            Icon(icon, size: 17, color: color),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          detail,
          style: TextStyle(
            color: color == AppColors.text ? AppColors.textMuted : color,
            fontSize: 9,
          ),
        ),
      ],
    ),
  );

  Widget _vipBanner() => ClipRRect(
    borderRadius: BorderRadius.circular(11),
    child: Container(
      height: 98,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/vip_vault_banner.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.input, Color(0xD90B0E14), Colors.transparent],
          ),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(Icons.shield, color: AppColors.primary, size: 15),
                SizedBox(width: 5),
                Text(
                  'ĐẶC QUYỀN HỘI VIÊN DIAMOND',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2),
            Text(
              'Hoàn Cược Mỗi Ngày 1.8%',
              style: TextStyle(
                color: AppColors.text,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Không giới hạn mức hoàn, tự động kết toán 12:00 trưa',
              style: TextStyle(color: AppColors.textMuted, fontSize: 9),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _profileMenu(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [BoxShadow(color: Color(0x33000000), blurRadius: 10)],
    ),
    child: Column(
      children: [
        _menuRow(
          context,
          Icons.manage_accounts,
          'Chỉnh Sửa Hồ Sơ',
          'Biệt danh, số điện thoại, avatar',
          onTap: () => showDemoMessage(
            context,
            'Form chỉnh sửa hồ sơ chưa có trong HTML được gửi.',
          ),
        ),
        _menuRow(
          context,
          Icons.lock_reset,
          'Đổi Mật Khẩu & Bảo Mật 2FA',
          'Mật khẩu cấp 2, mã OTP Telegram',
          onTap: () => context.go(AppRoutes.changePassword),
          shaded: true,
        ),
        _menuRow(
          context,
          Icons.settings,
          'Cài Đặt Bàn Cược',
          'Âm thanh xúc xắc, chế độ nặn xúc xắc 3D',
          onTap: () => context.go(AppRoutes.appSettings),
        ),
        _menuRow(
          context,
          Icons.info_outline,
          'Giới Thiệu Ứng Dụng',
          'Thông tin, cam kết và kênh hỗ trợ',
          onTap: () => context.go(AppRoutes.about),
          shaded: true,
        ),
        _menuRow(
          context,
          Icons.account_balance_wallet,
          'Tài Khoản & Thanh Toán',
          'Ngân hàng, ví điện tử và bảo mật tài khoản',
          onTap: () => context.go(AppRoutes.accountSettings),
        ),
        _menuRow(
          context,
          Icons.support_agent,
          'Quản Gia CSKH VIP 24/7',
          'Hỗ trợ riêng qua Hotline VIP & Telegram',
          onTap: () => showDemoMessage(
            context,
            'CSKH VIP sẽ được kết nối ở giai đoạn sau.',
          ),
          shaded: true,
          online: true,
        ),
      ],
    ),
  );

  Widget _menuRow(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle, {
    required VoidCallback onTap,
    bool shaded = false,
    bool online = false,
  }) => InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: shaded ? AppColors.surfaceLow.withValues(alpha: .4) : null,
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.surfaceHigh,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: AppColors.text,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (online) ...[
                      const SizedBox(width: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.green.withValues(alpha: .15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Trực tuyến',
                          style: TextStyle(color: AppColors.green, fontSize: 8),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.textMuted, size: 19),
        ],
      ),
    ),
  );

  Future<void> _copyMemberId() async {
    await Clipboard.setData(const ClipboardData(text: '889988'));
    if (!mounted) return;
    setState(() => _copied = true);
    showDemoMessage(context, 'Đã sao chép ID hội viên.');
    _copyTimer?.cancel();
    _copyTimer = Timer(const Duration(milliseconds: 1500), () {
      if (mounted) setState(() => _copied = false);
    });
  }
}
