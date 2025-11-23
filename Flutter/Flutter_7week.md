오늘 실습:
-[ ] 플러터 개발 환경 
-[ ] 프로젝트 생성 및 Hot-Reload 동작성 확인
-[ ] 레이아웃 관련 실습
-[ ] 문제 풀이

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

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: createBody(),
    );
  }

  Widget createBody() {
    // return Row(
    //   children: [
       /* const Text('MainAxisAlignment.start'),
        createS2(MainAxisAlignment.start),
        const Text('MainAxisAlignment.center'),
        createS2(MainAxisAlignment.center),
        const Text('MainAxisAlignment.end'),
        createS2(MainAxisAlignment.end),
        const Text('MainAxisAlignment.spaceEvenly'),
        createS2(MainAxisAlignment.spaceEvenly),
        const Text('MainAxisAlignment.spaceBetween'),
        createS2(MainAxisAlignment.spaceBetween),
        const Text('MainAxisAlignment.spaceAround'),
        createS2(MainAxisAlignment.spaceAround), */
       // const Text('CrossAxisAlignment.spaceAround'),
       // createS3(CrossAxisAlignment.center),
      // createS3(CrossAxisAlignment.stretch),
      // createS3(CrossAxisAlignment.start),
      // createS3(CrossAxisAlignment.end),
      // createS3(CrossAxisAlignment.center),
      // return createBox(11);

      // return Column(children: [
      //   Expanded(child: Container(color: Colors.blue)),
      //   Container(height: 300, color: Colors.red),
      // ],);
      return createS6();
    //   ],
    // );
  }
//============================================
  Widget createS1() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      width: 200,
      height: 50,
      color: Colors.red,
      child: const Center(child: Text('Container')),
    );
  }
//=====================================
  Widget createS2(MainAxisAlignment alignment) {
    return Row(
      mainAxisAlignment: alignment,
      children: List.generate(
        5,
        (index) => Container(
          width: 40,
          height: 40,
          color: Colors.red,
          margin: const EdgeInsets.all(5),
        ),
      ),
    );
  }
}
//=====================================================
Widget createS3(CrossAxisAlignment alignment){
  return Container(
      color: Colors.blue[100],
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: alignment,
        children: List.generate(
          5,
          (index) => Container(
          width: 40,
          height: 40,
          color: Colors.red,
          margin: const EdgeInsets.all(5),
          ),
        ),
      )
    );
}
//===================================
Widget addBox(bool isShowable){
  return Container(
    width: 40,
    height: 40,
    color: isShowable ? Colors.blue : Colors.transparent,
    margin: const EdgeInsets.all(5),
  );
}

Widget createBox(int size) {
  List<Widget> result = [];

  for(var y = 0; y < size; y++){
    List<Widget> line = [];
    for(var x = 0; x < size; x++){
      var condition = x ==y || (size - 1 - x) == y;

      line.add(addBox(condition));
    }
    result.add(Row(children: line));
  }

  return Column(children: result);
}
//=========================================
Widget createS4() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      ...List.generate(
        4,
        (index) => Container(
          width: 40,
          height: 40,
          color: Colors.red,
          margin: const EdgeInsets.all(5),
        ),
      ),

      Expanded(
        child: Container(
          height: 40,
          color: Colors.red,
          margin: const EdgeInsets.all(5),
        ),
      ),

    ],
  );
}
//================================
Widget addBox2(int flex){
  return Expanded(
    flex: flex,
    child: Container(
      height: 40,
      color: Colors.red,
      margin: const EdgeInsets.all(5),
    ),
  );
}

Widget createS5(){
  return Row(children: [addBox2(1), addBox2(2), addBox2(3),]);
}

Widget createS6() {
  return Center(
    child: SizedBox(
      width: 300,
      height:300,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(child: Container(color: Colors.red)),
                Expanded(child: Container(color: Colors.yellow)),
              ],
            ),
          ),
          Expanded(child: Container(color: Colors.blue)),
        ],
      ),
    ),
  );
}