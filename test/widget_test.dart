import 'package:flutter_test/flutter_test.dart';
import 'package:taixiuversion1/app/app.dart';
import 'package:taixiuversion1/app/routes.dart';

void main() {
  testWidgets('login and registration screens are reachable', (tester) async {
    await tester.pumpWidget(const TaiXiuApp());
    await tester.pump();

    expect(find.text('TÀI XỈU HOÀNG GIA'), findsOneWidget);
    expect(find.text('ĐĂNG NHẬP NGAY'), findsOneWidget);

    await tester.tap(find.text('Đăng Ký'));
    await tester.pumpAndSettle(const Duration(milliseconds: 100));

    expect(find.text('TẠO TÀI KHOẢN MỚI'), findsOneWidget);
    expect(find.text('ĐĂNG KÝ NHẬN THƯỞNG 100K'), findsOneWidget);

    AppRoutes.router.go(AppRoutes.passwordRecovery);
    await tester.pump();
    expect(find.text('KHÔI PHỤC MẬT KHẨU'), findsOneWidget);
    expect(find.text('XÁC NHẬN ĐỔI MẬT KHẨU'), findsOneWidget);

    AppRoutes.router.go(AppRoutes.changePassword);
    await tester.pump();
    expect(find.text('Đổi Mật Khẩu'), findsOneWidget);
    expect(find.text('CẬP NHẬT MẬT KHẨU MỚI'), findsOneWidget);

    AppRoutes.router.go(AppRoutes.profile);
    await tester.pump();
    expect(find.text('Hồ Sơ Cá Nhân'), findsOneWidget);
    expect(find.text('Đại Gia Macau'), findsOneWidget);

    AppRoutes.router.go(AppRoutes.accountSettings);
    await tester.pump();
    expect(find.text('Cài Đặt Tài Khoản'), findsOneWidget);
    expect(find.text('Bảo Mật Nâng Cao'), findsOneWidget);

    AppRoutes.router.go(AppRoutes.appSettings);
    await tester.pump();
    expect(find.text('Cài Đặt Ứng Dụng'), findsOneWidget);
    expect(find.text('Âm Thanh & Phản Hồi'), findsOneWidget);
    expect(find.text('Đồ Họa & Bàn Chơi'), findsOneWidget);

    AppRoutes.router.go(AppRoutes.about);
    await tester.pump();
    expect(find.text('Giới Thiệu Ứng Dụng'), findsOneWidget);
    expect(find.text('Sứ Mệnh & Cam Kết'), findsOneWidget);

    AppRoutes.router.go(AppRoutes.deposit);
    await tester.pump();
    expect(find.text('Nạp Tiền'), findsOneWidget);
    expect(find.text('Kênh nạp tiền'), findsOneWidget);

    AppRoutes.router.go(AppRoutes.withdraw);
    await tester.pump();
    expect(find.text('Rút Tiền'), findsOneWidget);
    expect(find.text('Số Tiền Rút (VNĐ)'), findsOneWidget);
  });
}
