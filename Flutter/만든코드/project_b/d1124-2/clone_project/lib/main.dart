import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'root.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Clone Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Clone Project'),
      getPages: [
        GetPage(name: '/', page: () => const Root()),
        GetPage(name: '/home', page: () => const Root()),
        GetPage(
          name: '/login',
          page: () => const LoginPage(),
          binding: BindingsBuilder(() {
            // Get.lazyPut<LoginController>(() => LoginController(Get.find<AuthenticationRepository>()));
          }),
        ),
        GetPage(
          name: '/signup',
          page: () => const SignupPage(),
          binding: BindingsBuilder(() {
            // Get.create<SignupController>(() => SignupController(Get.find<UserRepository>(),
            // Get.parameters['uid'] as String),
            // );
          }),
        ),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('isFirstTime') ?? true;
    
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
    });

    if (isFirstTime && mounted) {
      _showWelcomeDialog();
    }
  }

  void _showWelcomeDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('앱에 오신 것을 환영합니다!'),
          content: const SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '이 앱은 다음과 같은 기능을 제공합니다:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  '✓ 화면 중앙에 카운터 숫자 표시\n'
                  '✓ 앱 종료 후에도 마지막 값 저장\n'
                  '✓ 앱 재실행 시 저장된 값 복원',
                  style: TextStyle(fontSize: 14, height: 1.8),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isFirstTime', false);
                if (mounted) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('닫기'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/logo_simbol.png', width: 100, height: 100),
            const SizedBox(height: 20),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Image.asset('assets/images/default_profile.png', width: 80, height: 80),
          ],




        ),
      ),
    );
  }
}
