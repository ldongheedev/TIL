바이브 코딩

Column, Row를 이용해서
상자 및 X를 플러터를 이용해 그려보기
※ Copilot을 적극적으로 이용하고 적용할 코드를 이해한 후 사용할 것

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'X Box Generator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '숫자 입력으로 X 그리기'),
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
  final TextEditingController _controller = TextEditingController();
  int? boxSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: '크기를 입력하세요 (홀수 권장)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    final input = int.tryParse(_controller.text);
                    if (input != null && input > 1) {
                      setState(() {
                        boxSize = input;
                      });
                    }
                  },
                  child: const Text('그리기'),
                ),
              ],
            ),
            const SizedBox(height: 30),
            if (boxSize != null) Expanded(child: createBoxWithX(boxSize!)),
          ],
        ),
      ),
    );
  }

  Widget createBoxWithX(int size) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(size, (y) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(size, (x) {
              bool isBorder = x == 0 || x == size - 1 || y == 0 || y == size - 1;
              bool isX = x == y || x + y == size - 1;

              if (isBorder || isX) {
                return Container(
                  width: 30,
                  height: 30,
                  margin: const EdgeInsets.all(2),
                  color: Colors.blue,
                );
              } else {
                return const SizedBox(width: 34, height: 34);
              }
            }),
          );
        }),
      ),
    );
  }
}

===================================================
박스 원형으로 교체

import 'package:flutter/material.dart';

void main() {
runApp(const MyApp());
}

class MyApp extends StatelessWidget {
const MyApp({super.key});

@override
Widget build(BuildContext context) {
    **return MaterialApp(**

      **title: 'X Circle Generator',**

      **theme: ThemeData(**

        **colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),**

        **useMaterial3: true,**

      **),**

      **home: const MyHomePage(title: '숫자 입력으로 X 그리기'),**

    **);**

}
}

class MyHomePage extends StatefulWidget {
const MyHomePage({super.key, required this.title});
final String title;

@override
State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
final TextEditingController _controller = TextEditingController();
int? boxSize;

@override
Widget build(BuildContext context) {
    **return Scaffold(**

      **appBar: AppBar(**

        **title: Text(widget.title),**

        **backgroundColor: Theme.of(context).colorScheme.inversePrimary,**

      **),**

      **body: Padding(**

        **padding: const EdgeInsets.all(20),**

        **child: Column(**

          **children: \[**

            **Row(**

              **children: \[**

                **Expanded(**

                  **child: TextField(**

                    **controller: \_controller,**

                    **keyboardType: TextInputType.number,**

                    **decoration: const InputDecoration(**

                      **labelText: '크기를 입력하세요 (홀수 권장)',**

                      **border: OutlineInputBorder(),**

                    **),**

                  **),**

                **),**

                **const SizedBox(width: 10),**

                **ElevatedButton(**

                  **onPressed: () {**

                    **final input = int.tryParse(\_controller.text);**

                    **if (input != null \&\& input > 1) {**

                      **setState(() {**

                        **boxSize = input;**

                      **});**

                    **}**

                  **},**

                  **child: const Text('그리기'),**

                **),**

              **],**

            **),**

            **const SizedBox(height: 30),**

            **if (boxSize != null) Expanded(child: createCircleWithX(boxSize!)),**

          **],**

        **),**

      **),**

    **);**

}

Widget createCircleWithX(int size) {
    **return SingleChildScrollView(**

      **child: Column(**

        **mainAxisAlignment: MainAxisAlignment.center,**

        **children: List.generate(size, (y) {**

          **return Row(**

            **mainAxisAlignment: MainAxisAlignment.center,**

            **children: List.generate(size, (x) {**

              **bool isBorder = x == 0 || x == size - 1 || y == 0 || y == size - 1;**

              **bool isX = x == y || x + y == size - 1;**



              **if (isBorder || isX) {**

                **return Container(**

                  **width: 30,**

                  **height: 30,**

                  **margin: const EdgeInsets.all(2),**

                  **decoration: const BoxDecoration(**

                    **color: Colors.blue,**

                    **shape: BoxShape.circle,**

                  **),**

                **);**

              **} else {**

                **return const SizedBox(width: 34, height: 34);**

              **}**

            **}),**

          **);**

        **}),**

      **),**

    **);**

}
}

===================================================
다크, 라이트 모드 추가

import 'package:flutter/material.dart';

void main() {
runApp(const MyApp());
}

class MyApp extends StatefulWidget {
const MyApp({super.key});

@override
State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
ThemeMode _themeMode = ThemeMode.light;

void toggleTheme() {
    **setState(() {**

      **\_themeMode =**

          **\_themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;**

    **});**

}

@override
Widget build(BuildContext context) {
    **return MaterialApp(**

      **title: 'X Box Generator',**

      **theme: ThemeData(**

        **brightness: Brightness.light,**

        **colorScheme: ColorScheme.fromSeed(**

          **seedColor: Colors.blue,**

          **brightness: Brightness.light,**

        **),**

        **useMaterial3: true,**

      **),**

      **darkTheme: ThemeData(**

        **brightness: Brightness.dark,**

        **colorScheme: ColorScheme.fromSeed(**

          **seedColor: Colors.blue,**

          **brightness: Brightness.dark,**

        **),**

        **useMaterial3: true,**

      **),**

      **themeMode: \_themeMode,**

      **home: MyHomePage(**

        **title: '숫자 입력으로 X 그리기',**

        **onToggleTheme: toggleTheme,**

        **isDarkMode: \_themeMode == ThemeMode.dark,**

      **),**

    **);**

}
}

class MyHomePage extends StatefulWidget {
const MyHomePage({
    **super.key,**

    **required this.title,**

    **required this.onToggleTheme,**

    **required this.isDarkMode,**

});

final String title;
final VoidCallback onToggleTheme;
final bool isDarkMode;

@override
State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
final TextEditingController _controller = TextEditingController();
int? boxSize;

@override
Widget build(BuildContext context) {
    **return Scaffold(**

      **appBar: AppBar(**

        **title: Text(widget.title),**

        **backgroundColor: Theme.of(context).colorScheme.inversePrimary,**

      **),**

      **body: Padding(**

        **padding: const EdgeInsets.all(20),**

        **child: Column(**

          **children: \[**

            **Row(**

              **children: \[**

                **Expanded(**

                  **child: TextField(**

                    **controller: \_controller,**

                    **keyboardType: TextInputType.number,**

                    **decoration: const InputDecoration(**

                      **labelText: '크기를 입력하세요 (홀수 권장)',**

                      **border: OutlineInputBorder(),**

                    **),**

                  **),**

                **),**

                **const SizedBox(width: 10),**

                **ElevatedButton(**

                  **onPressed: () {**

                    **final input = int.tryParse(\_controller.text);**

                    **if (input != null \&\& input > 1) {**

                      **setState(() {**

                        **boxSize = input;**

                      **});**

                    **}**

                  **},**

                  **child: const Text('그리기'),**

                **),**

              **],**

            **),**

            **const SizedBox(height: 30),**

            **if (boxSize != null)**

              **Expanded(child: createCircleWithX(boxSize!)),**

            **const SizedBox(height: 20),**

            **ElevatedButton.icon(**

              **onPressed: widget.onToggleTheme,**

              **icon: Icon(widget.isDarkMode ? Icons.light\_mode : Icons.dark\_mode),**

              **label: Text(widget.isDarkMode ? '라이트 모드로 전환' : '다크 모드로 전환'),**

            **),**

          **],**

        **),**

      **),**

    **);**

}

Widget createCircleWithX(int size) {
    **return SingleChildScrollView(**

      **child: Column(**

        **mainAxisAlignment: MainAxisAlignment.center,**

        **children: List.generate(size, (y) {**

          **return Row(**

            **mainAxisAlignment: MainAxisAlignment.center,**

            **children: List.generate(size, (x) {**

              **bool isBorder = x == 0 || x == size - 1 || y == 0 || y == size - 1;**

              **bool isX = x == y || x + y == size - 1;**



              **if (isBorder || isX) {**

                **return Container(**

                  **width: 30,**

                  **height: 30,**

                  **margin: const EdgeInsets.all(2),**

                  **decoration: const BoxDecoration(**

                    **color: Colors.blue,**

                    **shape: BoxShape.circle,**

                  **),**

                **);**

              **} else {**

                **return const SizedBox(width: 34, height: 34);**

              **}**

            **}),**

          **);**

        **}),**

      **),**

    **);**

}
}

==========================================
원에 그라데이션 넣기

import 'package:flutter/material.dart';

void main() {
runApp(const MyApp());
}

class MyApp extends StatefulWidget {
const MyApp({super.key});

@override
State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
ThemeMode _themeMode = ThemeMode.light;

void toggleTheme() {
    **setState(() {**

      **\_themeMode =**

          **\_themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;**

    **});**

}

@override
Widget build(BuildContext context) {
    **return MaterialApp(**

      **title: 'X Box Generator',**

      **theme: ThemeData(**

        **brightness: Brightness.light,**

        **colorScheme: ColorScheme.fromSeed(**

          **seedColor: Colors.blue,**

          **brightness: Brightness.light,**

        **),**

        **useMaterial3: true,**

      **),**

      **darkTheme: ThemeData(**

        **brightness: Brightness.dark,**

        **colorScheme: ColorScheme.fromSeed(**

          **seedColor: Colors.blue,**

          **brightness: Brightness.dark,**

        **),**

        **useMaterial3: true,**

      **),**

      **themeMode: \_themeMode,**

      **home: MyHomePage(**

        **title: '숫자 입력으로 X 그리기',**

        **onToggleTheme: toggleTheme,**

        **isDarkMode: \_themeMode == ThemeMode.dark,**

      **),**

    **);**

}
}

class MyHomePage extends StatefulWidget {
const MyHomePage({
    **super.key,**

    **required this.title,**

    **required this.onToggleTheme,**

    **required this.isDarkMode,**

});

final String title;
final VoidCallback onToggleTheme;
final bool isDarkMode;

@override
State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
final TextEditingController _controller = TextEditingController();
int? boxSize;

@override
Widget build(BuildContext context) {
    **return Scaffold(**

      **appBar: AppBar(**

        **title: Text(widget.title),**

        **backgroundColor: Theme.of(context).colorScheme.inversePrimary,**

      **),**

      **body: Padding(**

        **padding: const EdgeInsets.all(20),**

        **child: Column(**

          **children: \[**

            **Row(**

              **children: \[**

                **Expanded(**

                  **child: TextField(**

                    **controller: \_controller,**

                    **keyboardType: TextInputType.number,**

                    **decoration: const InputDecoration(**

                      **labelText: '크기를 입력하세요 (홀수 권장)',**

                      **border: OutlineInputBorder(),**

                    **),**

                  **),**

                **),**

                **const SizedBox(width: 10),**

                **ElevatedButton(**

                  **onPressed: () {**

                    **final input = int.tryParse(\_controller.text);**

                    **if (input != null \&\& input > 1) {**

                      **setState(() {**

                        **boxSize = input;**

                      **});**

                    **}**

                  **},**

                  **child: const Text('그리기'),**

                **),**

              **],**

            **),**

            **const SizedBox(height: 30),**

            **if (boxSize != null) Expanded(child: createCircleWithX(boxSize!)),**

            **const SizedBox(height: 20),**

            **ElevatedButton.icon(**

              **onPressed: widget.onToggleTheme,**

              **icon: Icon(widget.isDarkMode ? Icons.light\_mode : Icons.dark\_mode),**

              **label: Text(widget.isDarkMode ? '라이트 모드로 전환' : '다크 모드로 전환'),**

            **),**

          **],**

        **),**

      **),**

    **);**

}

Widget createCircleWithX(int size) {
    **return SingleChildScrollView(**

      **child: Column(**

        **mainAxisAlignment: MainAxisAlignment.center,**

        **children: List.generate(size, (y) {**

          **return Row(**

            **mainAxisAlignment: MainAxisAlignment.center,**

            **children: List.generate(size, (x) {**

              **bool isBorder = x == 0 || x == size - 1 || y == 0 || y == size - 1;**

              **bool isX = x == y || x + y == size - 1;**



              **if (isBorder || isX) {**

                **return Container(**

                  **width: 30,**

                  **height: 30,**

                  **margin: const EdgeInsets.all(2),**

                  **decoration: const BoxDecoration(**

                    **shape: BoxShape.circle,**

                    **gradient: RadialGradient(**

                      **colors: \[**

                        **Color(0xFF90CAF9), // 밝은 파란색**

                        **Color(0xFF1565C0), // 진한 파란색**

                      **],**

                      **center: Alignment.center,**

                      **radius: 0.8,**

                    **),**

                  **),**

                **);**

              **} else {**

                **return const SizedBox(width: 34, height: 34);**

              **}**

            **}),**

          **);**

        **}),**

      **),**

    **);**

}
}

==============================================
책 180 페이지 부터


import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '플러터 데모!',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const MyHomePage(title: '플러터 데모 홈페이지'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  bool opacity = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(child: createS6()),
    );
  }


  Widget createS1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(color: Colors.red, width: 100, height: 40),
        const SizedBox(height: 10),
        Container(color: Colors.blue, width: 100, height: 40),
      ],
    );
  }
  
  Widget createS2() {
    return ListView(
      scrollDirection: Axis.vertical,
      children: List.generate(
        1000,
        (index) => Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.all(5),
          color: Colors.red.withAlpha((index + 1) * 25),
          child: Center(
            child: Text(
              '안녕하세요',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
      )
      )
    );
    
  }

  Widget createS3() {
    return PageView(
      scrollDirection: Axis.vertical,
      pageSnapping: false,
      children: [
        Container(
          color: Colors.red,
          child: const Center(
            child: Text(
              "1",
              style: TextStyle(fontSize: 50, color: Colors.white),
            ),
          ),
        ),
        Container(
          color: Colors.blue,
          child: const Center(
            child: Text(
              "2",
              style: TextStyle(fontSize: 50, color: Colors.white),
            ),
          ),
        ),
        Container(
          color: Colors.yellow,
          child: const Center(
            child: Text(
              "3",
              style: TextStyle(fontSize: 50, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget createS4() {
    return Column(
      children: [
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              Container(
                color: Colors.blue,
                child: Center(child: Text('메뉴 1 페이지')),
                ),
              Container(
                color: Colors.orange,
                child: Center(child: Text('메뉴 2 페이지')),
              ),
              Container(
                color: Colors.green,
                child: Center(child: Text('메뉴 3 페이지')),
              ),
            ],
          ),
        ),
        TabBar(
          controller: _tabController,
          tabs: const [ Text('메뉴1'), Text('메뉴2'), Text('메뉴3')],
        ),
      ],
    );
  }

  Widget createS5() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [
       AnimatedOpacity(
        opacity: opacity ? 0.2 : 1, 
        duration: const Duration(milliseconds: 1000),
        child: Container(
          width: 150,
          height: 150,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
          ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            opacity = !opacity;
            setState(() {});
          },
          child : Text('투명하게'),
        )
      ],
    ),
  );
}

  Widget createS6() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 1020),
            width: opacity ? 100 : 150,
            height: opacity ? 100 : 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: opacity ? Colors.red : Colors.blue,
            ),
            onEnd: () {
              print('asdfasdf');
              },
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                opacity = !opacity;
                setState(() {});
              },
              child : Text('변경하기'),
            ),
          ),
        ],
    );
  }

}