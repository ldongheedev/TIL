import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // 객체 -> MyApp이란 객체 생성
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
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
      body: Center(child: 
      Row(children: [createBody5()],)),
    );
  }

  Widget createBody() {
    return Center(
      child: Container(
        width: 200,
        height: 100,
        color: Colors.amber,
        alignment: Alignment.center,
        child: Text("Container"),
      )
    );
  }

  Widget createBody2() {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 255, 59, 98).withOpacity(0.7),
            Color.fromARGB(255, 255, 59, 98),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
          color: Color.fromARGB(255, 255, 59, 98).withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3),
          ),
        ],
      ),
      width: 200,
      height: 150,
      child: Center(
      child: Text('Container', style: TextStyle(fontSize: 24, fontStyle: FontStyle.italic, color: Colors.white)),
      ),
    );
  }

  Widget createBody3(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(5, (index) => Container(
        width: 40,
        height: 40,
        color: Colors.red,
        margin: const EdgeInsets.all(5),
      ),
      ),    
    );
  }

  Widget createBody4(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ...List.generate(
          4,
          (index) => Container(
            width: 40,
            height:  40,
            color: Colors.red,
            margin: const EdgeInsets.all(5),
          ),
          ),
          Expanded(child: Container(
          height: 40,
          color: Colors.red,
          margin: const EdgeInsets.all(5),
        ),
        ),
      ],
      );
  }

      Widget createBody5(){
        return Stack(
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(
                Icons.person,
                size: 40,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white
                ),
                child: const Icon(
                  Icons.camera_enhance,
                  size: 24,
                )
              ),),
          ],
        );
      }



} 