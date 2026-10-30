import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../app/theme.dart';
import '../../../../shared/widgets/account_page_frame.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) => AccountPageFrame(
    title: 'Giới Thiệu Ứng Dụng',
    onBack: () => context.go(AppRoutes.appSettings),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _hero(),
        const SizedBox(height: 18),
        const ProfileSectionTitle(
          'Sứ Mệnh & Cam Kết',
          icon: Icons.verified_user,
        ),
        const SizedBox(height: 8),
        _mission(),
        const SizedBox(height: 18),
        const ProfileSectionTitle('Đặc Quyền Vượt Trội', icon: Icons.diamond),
        const SizedBox(height: 8),
        _benefits(),
        const SizedBox(height: 18),
        const ProfileSectionTitle(
          'Chứng Nhận & Pháp Lý Quốc Tế',
          icon: Icons.verified,
        ),
        const SizedBox(height: 8),
        _certifications(),
        const SizedBox(height: 18),
        const ProfileSectionTitle(
          'Kênh Thông Tin & Tiếp Nhận',
          icon: Icons.public,
        ),
        const SizedBox(height: 8),
        _contactChannels(context),
        const SizedBox(height: 12),
        _appActions(context),
        const SizedBox(height: 15),
        const Text(
          '© 2024 Macau VIP Entertainment Group Ltd.\nChỉ dành cho hội viên đủ 18 tuổi trở lên. Chơi có trách nhiệm.',
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

  Widget _hero() => ProfilePanel(
    color: AppColors.surfaceLow,
    child: Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFFD98A),
                AppColors.primaryContainer,
                AppColors.surfaceHighest,
              ],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x66F59E0B),
                blurRadius: 22,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(Icons.casino, size: 54, color: AppColors.onPrimary),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.surfaceHigh,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'VIP CLUB  •  v3.8.2 Pro Edition',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 9,
              fontWeight: FontWeight.w700,
              letterSpacing: .6,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'TÀI XỈU HOÀNG GIA\nMACAU VIP CASINO',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 22,
            height: 1.15,
            fontWeight: FontWeight.w700,
            letterSpacing: .4,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          '“Đỉnh Cao Giải Trí - Uy Tín Tuyệt Đối”',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  Widget _mission() => ProfilePanel(
    color: AppColors.surface,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.verified_user, color: AppColors.primary, size: 21),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Minh bạch chuẩn mực quốc tế',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Kiến tạo không gian sòng bài Macau đẳng cấp hoàng gia ngay trong tầm tay. Hệ thống áp dụng thuật toán kiểm tra chuỗi băm mã hóa MD5 độc lập, công khai kết quả mỗi lượt lắc xúc xắc trước phiên cược.',
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 11,
            height: 1.5,
          ),
        ),
      ],
    ),
  );

  Widget _benefits() => Column(
    children: [
      _benefitCard(
        Icons.bolt,
        'Nạp Rút Siêu Tốc 30s',
        'Tỉ lệ 1:1',
        'Ngân hàng và ví số đa kênh, không thu phụ phí trung gian.',
        AppColors.primary,
      ),
      const SizedBox(height: 8),
      _benefitCard(
        Icons.groups,
        'Cộng Đồng Hùng Mạnh',
        '50.000+ Online',
        'Bàn chơi cập nhật biến động dòng tiền theo thời gian thực.',
        AppColors.green,
      ),
      const SizedBox(height: 8),
      _benefitCard(
        Icons.diamond,
        'Trợ Lý VIP Riêng Biệt',
        '24/7/365',
        'Chăm sóc riêng dành cho hội viên, hỗ trợ mọi lúc.',
        AppColors.pink,
      ),
    ],
  );

  Widget _benefitCard(
    IconData icon,
    String title,
    String metric,
    String body,
    Color color,
  ) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(11),
    ),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: .15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 21),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.text,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    metric,
                    style: TextStyle(
                      color: color,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 10,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _certifications() => Column(
    children: [
      _certification(
        Icons.verified,
        'PAGCOR Philippines',
        'Hợp pháp',
        'Cơ quan quản lý giải trí và trò chơi Philippines cấp phép giám sát quốc tế. Mã định danh: #GL-88291',
      ),
      const SizedBox(height: 8),
      _certification(
        Icons.fact_check,
        'iTech Labs & GA Testing',
        null,
        'Kiểm định máy tạo số ngẫu nhiên (RNG) và thuật toán xúc xắc.',
      ),
      const SizedBox(height: 8),
      _certification(
        Icons.lock,
        'Bảo Mật SSL 256-Bit & Cloudflare',
        null,
        'Tường lửa phòng thủ DDoS và mã hóa dữ liệu theo thiết kế giao diện.',
      ),
    ],
  );

  Widget _certification(
    IconData icon,
    String title,
    String? badge,
    String body,
  ) => ProfilePanel(
    color: AppColors.surface,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 22, color: AppColors.green),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.text,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (badge != null)
                    Text(
                      badge,
                      style: const TextStyle(
                        color: AppColors.green,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 10,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _contactChannels(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        _contactRow(
          context,
          Icons.public,
          'Fanpage Facebook',
          'Tài Xỉu Hoàng Gia - VIP Official',
        ),
        const Divider(height: 1, color: AppColors.surfaceHigh),
        _contactRow(
          context,
          Icons.send,
          'Kênh Telegram Thông Báo',
          '@TaiXiuHoangGia_Channel',
        ),
        const Divider(height: 1, color: AppColors.surfaceHigh),
        _contactRow(
          context,
          Icons.report,
          'Hỗ Trợ & Khiếu Nại',
          'Hotline ưu tiên tiếp nhận 24/7',
        ),
        const Divider(height: 1, color: AppColors.surfaceHigh),
        _contactRow(
          context,
          Icons.mail,
          'Email Pháp Lý & Hợp Tác',
          'legal@hoanggia-vipcasino.com',
        ),
      ],
    ),
  );

  Widget _contactRow(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
  ) => InkWell(
    onTap: () =>
        showDemoMessage(context, '$title sẽ được mở khi kết nối dịch vụ.'),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
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
          const Icon(Icons.chevron_right, color: AppColors.textMuted, size: 20),
        ],
      ),
    ),
  );

  Widget _appActions(BuildContext context) => Row(
    children: [
      Expanded(
        child: OutlinedButton.icon(
          onPressed: () => showDemoMessage(
            context,
            'Liên kết chia sẻ sẽ khả dụng khi ứng dụng được cấu hình phát hành.',
          ),
          icon: const Icon(Icons.share, size: 17),
          label: const Text('Chia Sẻ Ứng Dụng'),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            backgroundColor: AppColors.surface,
            side: BorderSide.none,
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: OutlinedButton.icon(
          onPressed: () =>
              showDemoMessage(context, 'Cảm ơn bạn đã đánh giá 5 sao!'),
          icon: const Icon(Icons.star, size: 17),
          label: const Text('Đánh Giá 5 Sao'),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            backgroundColor: AppColors.surface,
            side: BorderSide.none,
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    ],
  );
}
