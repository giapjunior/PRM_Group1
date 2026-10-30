import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../app/theme.dart';
import '../../../../shared/widgets/account_page_frame.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  final Map<String, bool> _switches = {
    '2fa': true,
    'vault': true,
    'biometric': true,
    'telegram': true,
    'hideBalance': true,
    'hideHistory': false,
    'blockInvites': false,
  };

  @override
  Widget build(BuildContext context) => AccountPageFrame(
    title: 'Cài Đặt Tài Khoản',
    onBack: () => context.go(AppRoutes.profile),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _profileHeader(),
        const SizedBox(height: 20),
        _paymentSection(context),
        const SizedBox(height: 18),
        _securitySection(context),
        const SizedBox(height: 18),
        _privacySection(),
        const SizedBox(height: 18),
        _dangerZone(context),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surfaceLow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            children: [
              Icon(Icons.verified_user, color: AppColors.primary, size: 27),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Hệ thống Tài Xỉu Hoàng Gia áp dụng mã hóa bảo mật SSL 256-bit chuẩn quốc tế và cam kết tiêu chuẩn chơi game có trách nhiệm 18+.',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 11,
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

  Widget _profileHeader() => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: AppColors.surfaceHigh,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [BoxShadow(color: Color(0x33000000), blurRadius: 12)],
    ),
    child: Row(
      children: [
        ClipOval(
          child: Image.asset(
            'assets/images/profile_avatar.jpg',
            width: 52,
            height: 52,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      'VươngGia_8888',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  _VipBadge(),
                ],
              ),
              SizedBox(height: 3),
              Text(
                'ID: 889218 • Hội viên Hoàng Gia',
                style: TextStyle(color: AppColors.textMuted, fontSize: 10),
              ),
            ],
          ),
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'CẤP BẢO VỆ',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 9,
                fontWeight: FontWeight.w600,
                letterSpacing: .5,
              ),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.shield, size: 16, color: AppColors.green),
                Text(
                  '98%',
                  style: TextStyle(
                    color: AppColors.green,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  Widget _paymentSection(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Row(
        children: [
          const Expanded(
            child: ProfileSectionTitle(
              'Tài Khoản & Thanh Toán',
              icon: Icons.account_balance,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.surfaceHigh,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Row(
              children: [
                Icon(Icons.circle, color: AppColors.green, size: 7),
                SizedBox(width: 4),
                Text(
                  '30s Cấp Tốc',
                  style: TextStyle(
                    color: AppColors.green,
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 9),
      _bankCard(
        'Vietcombank',
        '**** **** 9988',
        'NGUYEN VAN V***',
        Icons.account_balance_wallet,
        primary: true,
      ),
      const SizedBox(height: 8),
      _bankCard(
        'MB Bank',
        '**** **** 6622',
        'NGUYEN VAN V***',
        Icons.credit_card,
      ),
      const SizedBox(height: 8),
      _bankCard(
        'Techcombank',
        '**** **** 3311',
        'NGUYEN VAN V***',
        Icons.account_balance,
      ),
      const SizedBox(height: 8),
      _cryptoWallet(context),
      const SizedBox(height: 8),
      SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: () => showDemoMessage(
            context,
            'Thêm ngân hàng sẽ khả dụng khi có backend.',
          ),
          icon: const Icon(Icons.add_circle, size: 19),
          label: const Text('Thêm ngân hàng mới'),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            backgroundColor: AppColors.surfaceLow,
            side: BorderSide.none,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11),
            ),
          ),
        ),
      ),
    ],
  );

  Widget _bankCard(
    String bank,
    String number,
    String holder,
    IconData icon, {
    bool primary = false,
  }) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(11),
      boxShadow: const [BoxShadow(color: Color(0x22000000), blurRadius: 8)],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.surfaceHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: AppColors.primary, size: 22),
            ),
            const SizedBox(width: 9),
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
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (primary) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: .18),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: const Text(
                            'Chính',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  Text(
                    number,
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 10,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => showDemoMessage(
                context,
                'Tùy chọn $bank sẽ được kết nối sau.',
              ),
              icon: const Icon(
                Icons.more_vert,
                size: 18,
                color: AppColors.textMuted,
              ),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            const Icon(Icons.bolt, size: 13, color: AppColors.green),
            const SizedBox(width: 4),
            const Expanded(
              child: Text(
                'Đã kích hoạt rút siêu tốc 30s',
                style: TextStyle(color: AppColors.green, fontSize: 9),
              ),
            ),
            Text(
              holder,
              style: const TextStyle(color: AppColors.textMuted, fontSize: 9),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _cryptoWallet(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppColors.surfaceHigh,
      borderRadius: BorderRadius.circular(11),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.currency_bitcoin,
                color: AppColors.onPrimaryContainer,
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
                        'Ví Ẩn Danh USDT',
                        style: TextStyle(
                          color: AppColors.text,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 6),
                      _VipTag(),
                    ],
                  ),
                  SizedBox(height: 2),
                  Text(
                    'TRC20 & BEP20 • Không giới hạn',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 10),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.enhanced_encryption,
              color: AppColors.primary,
              size: 19,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: AppColors.input,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Địa chỉ ví mặc định',
                      style: TextStyle(color: AppColors.textMuted, fontSize: 9),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'TX89...kM92Laq (TRC20)',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () => showDemoMessage(
                  context,
                  'Chỉnh sửa ví sẽ được kết nối sau.',
                ),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  backgroundColor: AppColors.surfaceHigh,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  minimumSize: Size.zero,
                ),
                child: const Text('Sửa ví', style: TextStyle(fontSize: 10)),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _securitySection(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const ProfileSectionTitle('Bảo Mật Nâng Cao', icon: Icons.security),
      const SizedBox(height: 8),
      Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(11),
        ),
        child: Column(
          children: [
            _toggleRow(
              '2fa',
              Icons.phonelink_lock,
              'Xác thực 2 bước (2FA)',
              'Google Authenticator bảo vệ rút tiền',
            ),
            _switchDivider(),
            _settingAction(
              Icons.lock,
              'Khóa két sắt an toàn',
              'Mã PIN 6 số riêng biệt [Đã thiết lập]',
              'Đổi PIN',
              AppColors.green,
              context,
            ),
            _switchDivider(),
            _toggleRow(
              'biometric',
              Icons.fingerprint,
              'Face ID / Vân tay',
              'Đăng nhập nhanh không cần mật khẩu',
            ),
            _switchDivider(),
            _toggleRow(
              'telegram',
              Icons.send,
              'Cảnh báo thiết bị lạ',
              'Thông báo tức thời qua Telegram Bot VIP',
            ),
          ],
        ),
      ),
    ],
  );

  Widget _privacySection() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const ProfileSectionTitle(
        'Quyền Riêng Tư Sảnh Cược',
        icon: Icons.visibility_off,
      ),
      const SizedBox(height: 8),
      Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(11),
        ),
        child: Column(
          children: [
            _toggleRow(
              'hideBalance',
              Icons.account_balance_wallet,
              'Ẩn số dư trên bàn Tài Xỉu',
              "Chỉ hiển thị dấu '***' tránh soi cầu",
            ),
            _switchDivider(),
            _toggleRow(
              'hideHistory',
              Icons.leaderboard,
              'Ẩn lịch sử bảng đại gia',
              'Không công khai ván cược thắng lớn',
            ),
            _switchDivider(),
            _toggleRow(
              'blockInvites',
              Icons.do_not_disturb_on,
              'Chặn mời phòng cược riêng',
              'Tự động từ chối lời mời từ người lạ',
            ),
          ],
        ),
      ),
    ],
  );

  Widget _toggleRow(String key, IconData icon, String title, String subtitle) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: AppColors.surfaceHigh,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 19, color: AppColors.primary),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.text,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            _customSwitch(
              _switches[key] ?? false,
              () => setState(() => _switches[key] = !(_switches[key] ?? false)),
            ),
          ],
        ),
      );

  Widget _customSwitch(bool value, VoidCallback onTap) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(18),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 46,
      height: 26,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: value ? AppColors.primary : AppColors.surfaceHighest,
        borderRadius: BorderRadius.circular(18),
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 180),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: value ? AppColors.onPrimary : AppColors.textMuted,
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(color: Color(0x33000000), blurRadius: 3),
            ],
          ),
        ),
      ),
    ),
  );

  Widget _switchDivider() =>
      const Divider(height: 1, thickness: 1, color: AppColors.surfaceHigh);

  Widget _settingAction(
    IconData icon,
    String title,
    String subtitle,
    String action,
    Color color,
    BuildContext context,
  ) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    child: Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: AppColors.surfaceHigh,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 19, color: AppColors.primary),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.text,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(subtitle, style: TextStyle(color: color, fontSize: 10)),
            ],
          ),
        ),
        TextButton(
          onPressed: () =>
              showDemoMessage(context, '$action sẽ được kết nối sau.'),
          style: TextButton.styleFrom(
            foregroundColor: AppColors.text,
            backgroundColor: AppColors.surfaceHighest,
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
            minimumSize: Size.zero,
          ),
          child: Text(action, style: const TextStyle(fontSize: 10)),
        ),
      ],
    ),
  );

  Widget _dangerZone(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const ProfileSectionTitle(
        'Vùng Nguy Hiểm',
        icon: Icons.warning_amber,
        color: AppColors.pink,
      ),
      const SizedBox(height: 8),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.input,
          borderRadius: BorderRadius.circular(11),
          boxShadow: const [BoxShadow(color: Color(0x33000000), blurRadius: 8)],
        ),
        child: Column(
          children: [
            _dangerAction(
              'Tạm khóa tài khoản tự nguyện',
              'Nghỉ ngơi có trách nhiệm (7 đến 30 ngày)',
              'Khóa tạm thời',
              () => showDemoMessage(
                context,
                'Tạm khóa tài khoản sẽ được kết nối sau.',
              ),
              danger: false,
            ),
            const Divider(height: 18, color: AppColors.surfaceHigh),
            _dangerAction(
              'Đăng xuất mọi thiết bị khác',
              'Hủy 2 phiên đăng nhập đang hoạt động',
              'Đăng xuất',
              () => showDemoMessage(
                context,
                'Đăng xuất thiết bị khác sẽ được kết nối sau.',
              ),
              danger: true,
            ),
          ],
        ),
      ),
    ],
  );

  Widget _dangerAction(
    String title,
    String subtitle,
    String action,
    VoidCallback onTap, {
    required bool danger,
  }) => Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: danger ? const Color(0xFFFFB4AB) : AppColors.text,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              subtitle,
              style: const TextStyle(color: AppColors.textMuted, fontSize: 10),
            ),
          ],
        ),
      ),
      const SizedBox(width: 8),
      ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: danger ? AppColors.red : AppColors.surfaceHigh,
          foregroundColor: danger ? AppColors.pink : AppColors.pink,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700),
        ),
        child: Text(action),
      ),
    ],
  );
}

class _VipBadge extends StatelessWidget {
  const _VipBadge();
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
    decoration: BoxDecoration(
      color: AppColors.primaryContainer,
      borderRadius: BorderRadius.circular(14),
    ),
    child: const Text(
      'VIP 7',
      style: TextStyle(
        color: AppColors.onPrimaryContainer,
        fontSize: 9,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

class _VipTag extends StatelessWidget {
  const _VipTag();
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
    decoration: BoxDecoration(
      color: AppColors.input,
      borderRadius: BorderRadius.circular(4),
    ),
    child: const Text(
      'VIP',
      style: TextStyle(
        color: AppColors.primary,
        fontSize: 8,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
