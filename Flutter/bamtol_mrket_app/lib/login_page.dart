import 'package:flutter/material.dart';
import 'app_font.dart';
import 'location_setting_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Widget _logoView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 99,
          height: 116,
          child: Image.asset('assets/images/logo_simbol.png'),
        ),
        const SizedBox(height: 40),
        AppFont(
          '당신 근처의밤톨 마켓',
          fontWeight: FontWeight.bold,
          size: 20,
          color: Colors.white,
        ),

        const SizedBox(height: 15),
        AppFont(
          '중고거래는 가까운 동네에서, \n직접 만나서 안전하게 거래하세요!',
          align: TextAlign.center,
          size: 18,
          color: Colors.white.withOpacity(0.6),
        ),
      ],
    );
  }

  void _showDropdownNotification(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _DropdownNotification(
        message: message,
        onDismiss: () {
          overlayEntry.remove();
        },
      ),
    );

    overlay.insert(overlayEntry);
  }

  void _handleKakaoLogin(BuildContext context) {
    _showDropdownNotification(context, '카카오 로그인은 현재 연동되어 있지 않습니다.');
  }

  void _handleGoogleLogin(BuildContext context) {
    // 구글 로그인 시 위치 설정 페이지로 이동
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LocationSettingPage()),
    );
  }

  void _handleAppleLogin(BuildContext context) {
    _showDropdownNotification(context, 'Apple 로그인은 현재 연동되어 있지 않습니다.');
  }

  Widget _buildLoginButton({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
    Widget? icon,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[icon, const SizedBox(width: 12)],
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              _logoView(),
              const Spacer(),
              // 카카오 로그인 버튼
              _buildLoginButton(
                text: '카카오로 계속하기',
                backgroundColor: const Color(0xFFFEE500),
                textColor: Colors.black87,
                onPressed: () => _handleKakaoLogin(context),
                icon: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Colors.black87,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      'K',
                      style: TextStyle(
                        color: Color(0xFFFEE500),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // 구글 로그인 버튼
              _buildLoginButton(
                text: 'Google로 계속하기',
                backgroundColor: Colors.white,
                textColor: Colors.black87,
                onPressed: () => _handleGoogleLogin(context),
                icon: Image.asset(
                  'assets/images/google.png',
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(height: 12),
              // 애플 로그인 버튼
              _buildLoginButton(
                text: 'Apple로 계속하기',
                backgroundColor: Colors.black,
                textColor: Colors.white,
                onPressed: () => _handleAppleLogin(context),
                icon: Image.asset(
                  'assets/images/apple.png',
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _DropdownNotification extends StatefulWidget {
  final String message;
  final VoidCallback onDismiss;

  const _DropdownNotification({required this.message, required this.onDismiss});

  @override
  State<_DropdownNotification> createState() => _DropdownNotificationState();
}

class _DropdownNotificationState extends State<_DropdownNotification>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    // 2초 후 자동으로 사라짐
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _controller.reverse().then((_) {
          widget.onDismiss();
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SlideTransition(
        position: _slideAnimation,
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFFF6F00),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.white, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.message,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
