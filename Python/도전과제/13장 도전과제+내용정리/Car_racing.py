'''
자동차 5대 경주 애니메이션 코딩하기(turtle module이용)
코드 줄단위로 주석달기
'''

from turtle import * # 터틀 모듈을 임포트 함
import random as r # 랜덤변수를 사용하기 위해 임포트 함

class Car: # Car 클래스 선언
    # 클래스안에 기초 함수 __init__선언 후 기본 값 세팅
    # self는 현재 생성되고 있는 객체 자신을 가리킴 (속성을 저장하기 위해 필수)
    def __init__(self, speed, color, model, start_x, start_y):
        self.speed = speed # 속도
        self.color = color # 색상
        self.model = model # 모델(차 번호로 쓸 예정)
        self.start_x = start_x # (시작 초기 x좌표)
        self.start_y = start_y # (시작 초기 y좌표)
        self.turtle = Turtle() # 펜촉 세팅
        self.turtle.shape("car1.gif") # 터틀 펜촉을 car1.gif 이미지로 대체
        self.start_setting() # 시작 위치 세팅 

    def drive(self): # 설정된 속도만큼 이동
        self.turtle.fd(self.speed)

    # 시작 위치를 세팅하는 함수 선언
    def start_setting(self):
        self.turtle.up() # 펜촉을 듦
        self.turtle.goto(self.start_x, self.start_y) #펜촉 이동
        self.turtle.down() # 펜촉을 놓음
        
# 같은 폴더 안에 car1.gif이미지가 있으면 자동차로 펜촉 모양 변경
register_shape("car1.gif")
cars = [] # 각 다른 차들을 담아 놓기 위해 cars 리스트 선언
num = 1 # 자동차의 번호를 매기기 위해 초기값 1로 설정
for i in range(-100,101,50): # 각 위치를 -100부터 y좌표를 50 간격으로 띄워서 5대를 설치
    ranspeed = r.randint(10, 50) # 자동차의 x값 이동 범위를 10~50사이의 수로 랜덤 지정
    car_num = f"{num}번차" # 차 번호를 설정
    myCar = Car(ranspeed, "blue", car_num, -200, i) # 랜덤속도, 색상, n번째차, 시작x좌표(고정), 시작y좌표
    cars.append(myCar) # append 하지 않으면 차가 한대만 소환돼서 각 차들을 cars리스트에 담음

    num += 1 # 차량 번호를 1,2,3 로 매기기 위해 +1 을 해줌

# break문으로만 while문을 탈출하는데 문제가 있어 레이싱 모드를 껐다 켰다할 수 있도록 설정 함
race_on_off = True

while race_on_off: # 레이스 시작
    for car in cars: #car가 cars리스트 안에 있으면 실행
        car.drive() # 드라이브 중
    # 만약 x값의 좌표가 50을 넘으면 레이스의 우승자를 발표 후 레이스를 종료함
    # xcor()는 Turtle 객체의 현재 x좌표를 알려주는 함수임 (AI를 통하여 학습함)
        if car.turtle.xcor() > 50: 
            print(f"{car.model}가 우승함") # 우승자 발표
            print("레이싱을 종료합니다") # 레이스 종료
            race_on_off = False # 레이스 종료
            break # 탈출
