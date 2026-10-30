import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../app/theme.dart';
import '../../../../shared/widgets/account_page_frame.dart';

class AppSettingsScreen extends StatefulWidget {
  const AppSettingsScreen({super.key});

  @override
  State<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  final Map<String, bool> _switches = {
    'vibration': true,
    'event': true,
    'payments': true,
    'redEnvelope': true,
  };
  double _musicVolume = 75;
  double _diceVolume = 90;
  int _dealer = 0;
  int _fps = 0;
  int _roadStyle = 0;
  int _language = 0;
  bool _clearingCache = false;
  bool _checkingUpdate = false;
  bool _cacheCleared = false;
  bool _isLatest = false;

  @override
  Widget build(BuildContext context) => AccountPageFrame(
    title: 'Cài Đặt Ứng Dụng',
    onBack: () => context.go(AppRoutes.profile),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _hero(),
        const SizedBox(height: 18),
        _sectionHeader('Âm Thanh & Phản Hồi', Icons.volume_up),
        const SizedBox(height: 8),
        _audioSettings(),
        const SizedBox(height: 18),
        _sectionHeader('Đồ Họa & Bàn Chơi', Icons.display_settings),
        const SizedBox(height: 8),
        _graphicsSettings(),
        const SizedBox(height: 18),
        _sectionHeader('Thông Báo Đẩy', Icons.notifications_active),
        const SizedBox(height: 8),
        _notifications(),
        const SizedBox(height: 18),
        _maintenance(),
        const SizedBox(height: 14),
        _securityFooter(),
      ],
    ),
  );

  Widget _hero() => ProfilePanel(
    color: AppColors.surfaceLow,
    child: Row(
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primaryContainer, AppColors.surfaceHighest],
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [
              BoxShadow(color: Color(0x44F59E0B), blurRadius: 14),
            ],
          ),
          child: const Icon(Icons.tune, color: AppColors.primary, size: 30),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tùy Chỉnh Hoàng Gia VIP Saloon',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Tối ưu trải nghiệm âm thanh, đồ họa và nhịp cược đỉnh cao.',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 11,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _sectionHeader(String title, IconData icon) =>
      ProfileSectionTitle(title, icon: icon);

  Widget _audioSettings() => _panel(
    children: [
      _sliderSetting(
        icon: Icons.music_note,
        title: 'Nhạc Nền Macau Lounge (BGM)',
        subtitle: 'Giai điệu jazz sòng bạc thư giãn',
        value: _musicVolume,
        onChanged: (value) => setState(() => _musicVolume = value),
      ),
      const Divider(height: 8, color: AppColors.surfaceHigh),
      _sliderSetting(
        icon: Icons.casino,
        title: 'Hiệu Ứng Lắc Xúc Xắc 3D (SFX)',
        subtitle: 'Va chạm bát sứ ngọc & xí ngầu thật',
        value: _diceVolume,
        onChanged: (value) => setState(() => _diceVolume = value),
      ),
      const Divider(height: 8, color: AppColors.surfaceHigh),
      _toggleSetting(
        keyName: 'vibration',
        icon: Icons.vibration,
        title: 'Rung Phản Hồi Mở Bát',
        subtitle: 'Nhịp rung haptic khi công bố kết quả Tài/Xỉu',
      ),
      const Divider(height: 8, color: AppColors.surfaceHigh),
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 11, 12, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.record_voice_over,
                  size: 19,
                  color: AppColors.primary,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Giọng Đọc MC Dealer Trực Tiếp',
                    style: TextStyle(
                      color: AppColors.text,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Padding(
              padding: EdgeInsets.only(left: 27),
              child: Text(
                'Xướng đếm giây & đọc cầu thời gian thực',
                style: TextStyle(color: AppColors.textMuted, fontSize: 10),
              ),
            ),
            const SizedBox(height: 9),
            _choiceButton(
              title: 'MC Miền Nam (Ngọt Ngào)',
              selected: _dealer == 0,
              onTap: () => setState(() => _dealer = 0),
            ),
            const SizedBox(height: 6),
            _choiceButton(
              title: 'MC Miền Bắc (Chuẩn Sang)',
              selected: _dealer == 1,
              onTap: () => setState(() => _dealer = 1),
            ),
          ],
        ),
      ),
    ],
  );

  Widget _graphicsSettings() => _panel(
    children: [
      _settingLabel(
        Icons.speed,
        'Chất Lượng Đồ Họa 3D Xúc Xắc HDR',
        'ACTIVE',
        AppColors.green,
      ),
      const SizedBox(height: 9),
      Row(
        children: [
          Expanded(
            child: _selectionTile(
              title: '60 FPS',
              subtitle: 'Tiết kiệm pin & mượt mà',
              selected: _fps == 0,
              onTap: () => setState(() => _fps = 0),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _selectionTile(
              title: '120 FPS HDR',
              subtitle: 'Siêu nét sòng bạc VIP',
              selected: _fps == 1,
              onTap: () => setState(() => _fps = 1),
            ),
          ),
        ],
      ),
      const SizedBox(height: 15),
      _settingLabel(Icons.analytics, 'Kiểu Hiển Thị Bảng Soi Cầu', null, null),
      const SizedBox(height: 8),
      Row(
        children: [
          _roadChoice(0, Icons.grid_view, 'Cầu Bàn Cờ'),
          const SizedBox(width: 6),
          _roadChoice(1, Icons.analytics, 'Cầu Tóm Tắt'),
          const SizedBox(width: 6),
          _roadChoice(2, Icons.water_drop, 'Cầu Giọt Nước'),
        ],
      ),
      const SizedBox(height: 15),
      _settingLabel(Icons.language, 'Ngôn Ngữ Ứng Dụng', null, null),
      const SizedBox(height: 4),
      const Padding(
        padding: EdgeInsets.only(left: 27),
        child: Text(
          'Mặc định: Tiếng Việt',
          style: TextStyle(color: AppColors.textMuted, fontSize: 10),
        ),
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          _languageChoice(0, 'Tiếng Việt'),
          const SizedBox(width: 6),
          _languageChoice(1, 'English'),
          const SizedBox(width: 6),
          _languageChoice(2, '中文 (繁體)'),
        ],
      ),
    ],
  );

  Widget _notifications() => _panel(
    children: [
      _toggleSetting(
        keyName: 'event',
        icon: Icons.military_tech,
        title: 'Sự Kiện Đua Top Hũ Tài Xỉu',
        subtitle: 'Nhận tin khi hũ rồng chạm mốc tỷ đồng',
      ),
      const Divider(height: 8, color: AppColors.surfaceHigh),
      _toggleSetting(
        keyName: 'payments',
        icon: Icons.payments,
        title: 'Biến Động Nạp / Rút Tức Thì',
        subtitle: 'Cảnh báo giao dịch ngân hàng khớp lệnh ngay',
      ),
      const Divider(height: 8, color: AppColors.surfaceHigh),
      _toggleSetting(
        keyName: 'redEnvelope',
        icon: Icons.redeem,
        title: 'Mưa Lì Xì Phòng Chat Hàng Giờ',
        subtitle: 'Thông báo giật phong bao đỏ VIP mỗi 60 phút',
      ),
    ],
  );

  Widget _maintenance() => _panel(
    children: [
      Row(
        children: [
          const Icon(
            Icons.cleaning_services,
            size: 20,
            color: AppColors.primary,
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dọn Dẹp Bộ Nhớ Đệm',
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Tối ưu dung lượng ứng dụng',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 10),
                ),
              ],
            ),
          ),
          Text(
            _cacheCleared ? '0.0 MB (Đã sạch)' : '48.2 MB',
            style: const TextStyle(
              color: AppColors.green,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: _clearingCache ? null : _clearCache,
          icon: _clearingCache
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Icon(_cacheCleared ? Icons.check : Icons.cleaning_services),
          label: Text(
            _clearingCache
                ? 'Đang dọn...'
                : _cacheCleared
                ? 'Xong'
                : 'Xóa Ngay',
          ),
          style: OutlinedButton.styleFrom(
            foregroundColor: _cacheCleared
                ? AppColors.green
                : AppColors.primary,
            side: BorderSide.none,
            backgroundColor: AppColors.surfaceHigh,
          ),
        ),
      ),
      const Divider(height: 18, color: AppColors.surfaceHigh),
      Row(
        children: [
          const Icon(Icons.verified, size: 20, color: AppColors.primary),
          const SizedBox(width: 8),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Version 3.8.2',
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Bản dựng VIP mới nhất (Macau Engine)',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 10),
                ),
              ],
            ),
          ),
          TextButton.icon(
            onPressed: _checkingUpdate ? null : _checkUpdate,
            icon: _checkingUpdate
                ? const SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Icon(_isLatest ? Icons.check : Icons.sync, size: 16),
            label: Text(
              _checkingUpdate
                  ? 'Đang kiểm tra...'
                  : _isLatest
                  ? 'Mới Nhất'
                  : 'Kiểm Tra',
            ),
            style: TextButton.styleFrom(
              foregroundColor: _isLatest ? AppColors.green : AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              minimumSize: Size.zero,
            ),
          ),
        ],
      ),
    ],
  );

  Widget _securityFooter() => InkWell(
    onTap: () => context.go(AppRoutes.about),
    borderRadius: BorderRadius.circular(12),
    child: ProfilePanel(
      color: AppColors.surfaceLow,
      child: const Row(
        children: [
          Icon(Icons.shield, color: AppColors.primary, size: 25),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bảo Mật Máy Chủ Macau High-Roller',
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Chứng nhận RNG Quốc Tế • Mã hóa bàn cược 256-bit SSL',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 9),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: AppColors.textMuted),
        ],
      ),
    ),
  );

  Widget _panel({required List<Widget> children}) => Container(
    padding: const EdgeInsets.symmetric(vertical: 3),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [BoxShadow(color: Color(0x22000000), blurRadius: 9)],
    ),
    child: Column(children: children),
  );

  Widget _sliderSetting({
    required IconData icon,
    required String title,
    required String subtitle,
    required double value,
    required ValueChanged<double> onChanged,
  }) => Padding(
    padding: const EdgeInsets.fromLTRB(12, 10, 12, 7),
    child: Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 19, color: AppColors.primary),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: _titleStyle),
                  const SizedBox(height: 3),
                  Text(subtitle, style: _subtitleStyle),
                ],
              ),
            ),
            Text(
              '${value.round()}%',
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Slider(value: value, min: 0, max: 100, onChanged: onChanged),
      ],
    ),
  );

  Widget _toggleSetting({
    required String keyName,
    required IconData icon,
    required String title,
    required String subtitle,
  }) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    child: Row(
      children: [
        Icon(icon, size: 19, color: AppColors.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: _titleStyle),
              const SizedBox(height: 3),
              Text(subtitle, style: _subtitleStyle),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Switch.adaptive(
          value: _switches[keyName] ?? false,
          onChanged: (value) => setState(() => _switches[keyName] = value),
          activeThumbColor: AppColors.onPrimary,
          activeTrackColor: AppColors.primary,
          inactiveTrackColor: AppColors.surfaceHighest,
        ),
      ],
    ),
  );

  Widget _settingLabel(
    IconData icon,
    String title,
    String? badge,
    Color? badgeColor,
  ) => Row(
    children: [
      Icon(icon, size: 19, color: AppColors.primary),
      const SizedBox(width: 8),
      Expanded(child: Text(title, style: _titleStyle)),
      if (badge != null)
        Text(
          badge,
          style: TextStyle(
            color: badgeColor ?? AppColors.textMuted,
            fontSize: 9,
            fontWeight: FontWeight.w700,
            letterSpacing: .6,
          ),
        ),
    ],
  );

  Widget _choiceButton({
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(9),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : AppColors.surfaceHigh,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: selected ? AppColors.onPrimary : AppColors.text,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Icon(
            selected ? Icons.check_circle : Icons.circle_outlined,
            size: 16,
            color: selected ? AppColors.onPrimary : AppColors.textMuted,
          ),
        ],
      ),
    ),
  );

  Widget _selectionTile({
    required String title,
    required String subtitle,
    required bool selected,
    required VoidCallback onTap,
  }) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(9),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : AppColors.surfaceHigh,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected ? AppColors.onPrimary : AppColors.text,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected
                  ? AppColors.onPrimaryContainer
                  : AppColors.textMuted,
              fontSize: 9,
            ),
          ),
        ],
      ),
    ),
  );

  Widget _roadChoice(int index, IconData icon, String title) => Expanded(
    child: InkWell(
      onTap: () => setState(() => _roadStyle = index),
      borderRadius: BorderRadius.circular(9),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        height: 68,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: _roadStyle == index
              ? AppColors.primary
              : AppColors.surfaceHigh,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 19,
              color: _roadStyle == index ? AppColors.onPrimary : AppColors.text,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _roadStyle == index
                    ? AppColors.onPrimary
                    : AppColors.text,
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _languageChoice(int index, String title) => Expanded(
    child: _choiceButton(
      title: title,
      selected: _language == index,
      onTap: () {
        setState(() => _language = index);
        if (index != 0) {
          showDemoMessage(
            context,
            'Ngôn ngữ sẽ được bổ sung trong bản cập nhật sau.',
          );
        }
      },
    ),
  );

  TextStyle get _titleStyle => const TextStyle(
    color: AppColors.text,
    fontSize: 11,
    fontWeight: FontWeight.w600,
  );

  TextStyle get _subtitleStyle =>
      const TextStyle(color: AppColors.textMuted, fontSize: 9, height: 1.3);

  void _clearCache() {
    setState(() => _clearingCache = true);
    Timer(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      setState(() {
        _clearingCache = false;
        _cacheCleared = true;
      });
    });
  }

  void _checkUpdate() {
    setState(() => _checkingUpdate = true);
    Timer(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      setState(() {
        _checkingUpdate = false;
        _isLatest = true;
      });
    });
  }
}
