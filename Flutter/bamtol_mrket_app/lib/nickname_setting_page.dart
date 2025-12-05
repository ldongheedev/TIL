import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class NicknameSettingPage extends StatefulWidget {
  const NicknameSettingPage({super.key});

  @override
  State<NicknameSettingPage> createState() => _NicknameSettingPageState();
}

class _NicknameSettingPageState extends State<NicknameSettingPage> {
  final TextEditingController _nicknameController = TextEditingController();
  bool _isValid = false;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadSavedNickname();
  }

  Future<void> _loadSavedNickname() async {
    final prefs = await SharedPreferences.getInstance();
    final savedNickname = prefs.getString('user_nickname');
    if (savedNickname != null && savedNickname.isNotEmpty) {
      setState(() {
        _nicknameController.text = savedNickname;
        _isValid = true;
      });
    }
  }

  void _validateNickname(String value) {
    setState(() {
      if (value.isEmpty) {
        _isValid = false;
        _errorMessage = null;
      } else if (value.length < 2) {
        _isValid = false;
        _errorMessage = '닉네임은 2자 이상이어야 합니다';
      } else if (value.length > 10) {
        _isValid = false;
        _errorMessage = '닉네임은 10자 이하여야 합니다';
      } else if (!RegExp(r'^[a-zA-Z0-9가-힣_]+$').hasMatch(value)) {
        _isValid = false;
        _errorMessage = '한글, 영문, 숫자, 밑줄(_)만 사용 가능합니다';
      } else {
        _isValid = true;
        _errorMessage = null;
      }
    });
  }

  Future<void> _saveNickname() async {
    if (!_isValid) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_nickname', _nicknameController.text.trim());

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('환영합니다, ${_nicknameController.text}님!'),
            backgroundColor: const Color(0xFFFF6F00),
            duration: const Duration(seconds: 2),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('닉네임 저장 실패: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        title: const Text(
          '닉네임 설정',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // 환영 메시지
            const Center(
              child: Icon(
                Icons.person_outline,
                size: 80,
                color: Color(0xFFFF6F00),
              ),
            ),
            const SizedBox(height: 24),

            const Center(
              child: Text(
                '닉네임을 설정해주세요',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),

            const Center(
              child: Text(
                '다른 사용자들에게 보여질 이름입니다',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            const SizedBox(height: 40),

            // 닉네임 입력 필드
            const Text(
              '닉네임',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),

            TextField(
              controller: _nicknameController,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              maxLength: 10,
              decoration: InputDecoration(
                hintText: '닉네임을 입력하세요',
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFF2C2C2C),
                counterStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.person, color: Colors.grey),
                suffixIcon: _nicknameController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _nicknameController.clear();
                          _validateNickname('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFFFF6F00),
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.red, width: 1),
                ),
                errorText: _errorMessage,
                errorStyle: const TextStyle(color: Colors.red),
              ),
              onChanged: _validateNickname,
            ),

            const SizedBox(height: 12),

            // 안내 메시지
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2C),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.grey, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '2~10자, 한글/영문/숫자/밑줄(_) 사용 가능',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // 완료 버튼
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _isValid && !_isLoading ? _saveNickname : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6F00),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        '시작하기',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
