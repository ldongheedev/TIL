라우터 다음주에 할거고 다음주부터 당근마켓 클론 만들기 할거임 과제를 통해서 나머지 만들거임 기말은 조금 어렵게 낼거임

객체지향 프로그램 강화 학습할거임

객체지향 프로그래밍
-> 프로그램을 '객체'라는 독립된 단위로 나누어, 이 객체들이 서로 상호 작용하며 동작하도록 설계하는 프로그래밍 패러다임
= 현실 세계의 사물이나 개념을 모델링 해 객체로 표현하는 방식

-------------------------------------------------------------------------------------

OOP(객체지향 프로그래밍)을 사용하는 이유
소프트웨어가 복잡해도, 객체 단위로 나누어 서로 상호작용하게 만들면 구조가 단순해지고, 효율적이며 유지보수가 쉬워짐

프로그램을 여러 객체로 나누어 표현하면, 각 객체가 맡은 역할만 관리하면 되기 때문에 개발과 유지보수가 훨씬 편리해집니다.

"너는 너 일을, 나는 내 일을, 너와 나는 손만 잡고"
----------------------------------------------------------------------------------------------------------

OOP 핵심 개념
객체(개체)(object) : 현실 세계의 사물이나 개념을 코드로 표현한 것 
				예: 자동차, 학생, 은행계좌 등
클래스(class) : 객체를 만들기 위한 설계도. 객체의 속성(변수)과 행동(메서드)을 정의
인스턴스(Instance) : 클래스를 기반으로 실제로 생성된 객체
속성(Attribute) : 객체가 가진 데이터
			예 : 자동차의 색상, 속도).
메서드(Method) : 객체가 수행할 수 있는 행동
				예 : 자동차의 accelerate, brake
--------------------------------------------------------------------------------------------------------

OOP 4대 원칙
캡슐화 : 데이터와 기능을 하나로 묶고, 외부에서 접근하지 못하게 보호
		예 : 사생활 보호
상속 : 기존 클래스의 속성과 기능을 물려받아 새로운 클래스로 정의
		예 : 부모 재산 상속
다형성 : 같은 이름의 메서드가 상황에 따라 다르게 동작
		예 : 이동 - 기다, 걷다, 뛰다, 날다
추상화  : 복잡한 구현을 숨기고, 필요한 기능만 드러냄
		예 : Auto 기어 자동차 운전
--------------------------------------------------------------------------------------------------------

Dart에서의 OOP
● 클래스
● 생성자
	○ 명명된 생성자
	○ 팩토리 생성자
● 변수
	○ 멤버 변수
	○ 클래스 변수
● 멤버 함수
● 4대 원칙
	○ 상속
	○ 캡슐화
	○ 추상화
	○ 다형성
● mixin
-------------------------------------------------------------------------------

실습
1번째 질문 
플러터 다트 언어를 통해서 객체지향 프로그래밍을 하고 싶은데, OOP 4대 원칙인 캡슐화, 상속, 다형성, 추상화를 코드로 확인하고 싶어. 먼저 캡슐화 도니 것과 안된것을 비교 해줘

캡슐화

캡슐화 된 코드

  class BankAccount {
  double _balance = 0; // private 변수

  void deposit(double amount) {
    if (amount > 0) {
      _balance += amount;
    }
  }

  void withdraw(double amount) {
    if (amount > 0 && amount <= _balance) {
      _balance -= amount;
    }
  }

  double getBalance() {
    return _balance;
  }
}

void main() {
  BankAccount account = BankAccount();
  account.deposit(1000);
  account.withdraw(300);
  print("잔액: ${account.getBalance()}"); // 출력: 잔액: 700
}

------------------------------------------------------------------------------------------------
캡슐화 안된 코드

class BankAccount {
  double balance = 0; // public 변수
}

void main() {
  BankAccount account = BankAccount();
  account.balance = -500; // 잘못된 접근
  print("잔액: ${account.balance}"); // 출력: 잔액: -500
}
-------------------------------------------------------------------------------------------------
캡슐화 안된 것 캡슐화로 고친 것
class BankAccount {
  final double _balance; // public 변수
  
  BankAccount(this._balance);
  
  double get balance => _balance;
}


void main() {
  BankAccount account = BankAccount(50);
  //account.balance = -500; // 잘못된 접근
  print("잔액: ${account.balance}"); // 출력: 잔액: -500
}

=======================================================================

2번째 질문 
다음은 상속을 다트 코드로 가장 쉽게 알려줄래?

상속

// 부모 클래스 (Super Class)
class Animal {
  void makeSound() {
    print("동물이 소리를 냅니다.");
  }
}

// 자식 클래스 (Sub Class)
class Dog extends Animal {
  void bark() {
    print("강아지가 멍멍 짖습니다.");
  }
}

void main() {
  Dog myDog = Dog();

  // 부모 클래스의 메서드 사용
  myDog.makeSound(); // 출력: 동물이 소리를 냅니다.

  // 자식 클래스의 메서드 사용
  myDog.bark(); // 출력: 강아지가 멍멍 짖습니다.
}
===============================================
3번째 질문
위의 코드에서 다형성을 설명할 수 있도록 코드를 확장해줘

// 부모 클래스
class Animal {
  void makeSound() {
    print("동물이 소리를 냅니다.");
  }
}

// 자식 클래스 1
class Dog extends Animal {
  @override
  void makeSound() {
    print("강아지가 멍멍 짖습니다.");
  }
}

// 자식 클래스 2
class Cat extends Animal {
  @override
  void makeSound() {
    print("고양이가 야옹 울어요.");
  }
}

// 자식 클래스 3
class Bird extends Animal {
  @override
  void makeSound() {
    print("새가 짹짹 울어요.");
  }
}

void main() {
  // Animal 타입의 리스트에 다양한 자식 클래스 객체를 담음
  List<Animal> animals = [Dog(), Cat(), Bird()];

  // 반복문을 통해 각 동물의 makeSound 호출
  for (var animal in animals) {
    animal.makeSound();
  }
}
-------------------------------------------------------------------------------------------------

상속 코드를 이용한 다형성 표현하기

// 부모 클래스 (Super Class)
class Animal {
  String _name = "";
  String get name => _name;

  Animal(this._name);

  void eat() {
    print("동물이 먹고 있습니다.");
  }

  void makeSound() {
    print("$name이(가) 소리를 내고 있어요!");
  }
}

// 자식 클래스 (Sub Class)
class Dog extends Animal {
  Dog(String name) : super(name);

  void bark() {
    print("멍멍!");
  }

  void makeSound() {
    print("$name: 월월!");
  }
}

class Cat extends Animal {
  Cat(String name) : super(name);

  void makeSound() {
    print("$name: 야옹!");
  }
}

void main() {
  Dog myDog = Dog("바둑이");
  Cat myCat = Cat("냥이");

  // 부모 클래스의 메서드 사용
  myDog.eat(); // 출력: 동물이 소리를 냅니다.

  // 자식 클래스의 메서드 사용
  //myDog.makeSound();
  //myCat.makeSound();

  List<Animal> animals = [myDog, myCat];
  for (var animal in animals) {
    animal.makeSound();
  }
}
===============================================================
4번째 질문
위의 코드를 이용해 추상화 클래스를 보여줘

// 추상 클래스
abstract class Animal {
  void makeSound(); // 추상 메서드: 구현은 자식 클래스에서
}

// 강아지 클래스
class Dog extends Animal {
  @override
  void makeSound() {
    print("강아지가 멍멍 짖습니다.");
  }
}

// 고양이 클래스
class Cat extends Animal {
  @override
  void makeSound() {
    print("고양이가 야옹 울어요.");
  }
}

// 새 클래스
class Bird extends Animal {
  @override
  void makeSound() {
    print("새가 짹짹 울어요.");
  }
}

void main() {
  List<Animal> animals = [Dog(), Cat(), Bird()];

  for (var animal in animals) {
    animal.makeSound();
  }
}
------------------------------------------------------------------------------------------------

추상화

// 추상 클래스 (Abstract Super Class)
abstract class Animal {
  String _name = "";
  String get name => _name;

  Animal(this._name);

  void eat() {
    print("동물이 먹고 있습니다.");
  }

  // 추상 메서드: 자식 클래스에서 반드시 구현해야 함
  void makeSound();
}

// 자식 클래스: Dog
class Dog extends Animal {
  Dog(String name) : super(name);

  void bark() {
    print("멍멍!");
  }

  @override
  void makeSound() {
    print("$name: 월월!");
  }
}

// 자식 클래스: Cat
class Cat extends Animal {
  Cat(String name) : super(name);

  @override
  void makeSound() {
    print("$name: 야옹!");
  }
}

void main() {
  Dog myDog = Dog("바둑이");
  Cat myCat = Cat("냥이");

  myDog.eat(); // 출력: 동물이 먹고 있습니다.

  List<Animal> animals = [myDog, myCat];
  for (var animal in animals) {
    animal.makeSound(); // 각 동물의 고유한 소리 출력
  }
}

==============================================================
OOP 4대 원칙을 모두 넣은 코드

// ✅ 추상화 (Abstraction): 공통 인터페이스 정의
abstract class Animal {
  // ✅ 캡슐화 (Encapsulation): private 변수와 getter
  String _name;
  String get name => _name;

  Animal(this._name);

  void eat() {
    print("$name이(가) 먹고 있습니다.");
  }

  // 추상 메서드: 자식 클래스에서 반드시 구현
  void makeSound();
}

// ✅ 상속 (Inheritance): Animal 클래스를 상속
class Dog extends Animal {
  Dog(String name) : super(name);

  void bark() {
    print("멍멍!");
  }

  // ✅ 다형성 (Polymorphism): makeSound 오버라이딩
  @override
  void makeSound() {
    print("$name: 월월!");
  }
}

class Cat extends Animal {
  Cat(String name) : super(name);

  @override
  void makeSound() {
    print("$name: 야옹!");
  }
}

class Bird extends Animal {
  Bird(String name) : super(name);

  @override
  void makeSound() {
    print("$name: 짹짹!");
  }
}

void main() {
  // Animal 타입으로 다양한 자식 객체를 다룰 수 있음 (다형성)
  List<Animal> animals = [
    Dog("바둑이"),
    Cat("냥이"),
    Bird("짹짹이"),
  ];

  for (var animal in animals) {
    animal.eat();       // 캡슐화된 name 사용
    animal.makeSound(); // 각 클래스의 고유한 구현 호출
  }
}

================================================================

질문5
현실 세계의 객체를 컴퓨터로 모델링 할 때 상태와 행위로 모델링을 할 수 있잖아. 그런데 왜 상태와 행위로 모델링을 하는거야?

===================================================

35분 부터 각자! Copilot을 이용해서

객체지향 프로그래밍을 Dart 언어로 어떻게 하는지 캡슐화, 상속, 다형성, 추상화 관점에서 살펴보고, 관련 코드를 확인하여 실행해보고
더 나아가서 인터페이스와 mixin에 대해서 확인하고 어떤 장점이 있는지 확인하고
코드를 요청해서 실행하고 그 결과를 확인할 것!
※ 물어볼 때 장/단점을 알려달라는 것 좋음