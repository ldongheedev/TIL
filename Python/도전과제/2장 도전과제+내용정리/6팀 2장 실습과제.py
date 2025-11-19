#터틀 그래픽 가져오기
import turtle as t
#펜촉 모양을 거북이로 설정
t.shape("turtle")

#자동차 만들기


bodyw = int(input("자동차 바디의 가로길이를 설정: "))
bodyh = int(input("자동차 바디의 세로길이를 설정: "))
bodyc = input("자동차 바디의 색상을 설정: ")
headc = input("자동차 머리의 색상 입력: ")
tirec = input("바퀴의 색상을 입력하시오: ")

#펜촉을 들어서 그려지지 않게 한후, 좌표를 바디의 하단 좌표로 이동
#펜촉을 down으로 내려 놓고 그려지게 설정
headw = bodyw/2 #창문의 가로값을 바디가로의 값의 2/1
headh = bodyh/2 #창문의 세로값을 바디세로의 값의 2/1
tirer = headw/4 #바퀴의 반지름의 값을 창문의가로의 값의 4/1

t.up()
t.goto(-bodyw/2,-bodyh/2) # 자동차 바디를 가운데에 그리기 위해 좌표를 왼쪽 하단으로 설정
t.down()
t.color(bodyc) # 펜촉색상을 빨간색으로 설정
t.begin_fill() # 그림 색 채우기 시작
t.forward(bodyw) # 400만큼 이동
t.left(90) # 왼쪽각으로 90만큼 옮기기
t.forward(bodyh)
t.left(90)
t.forward(bodyw)
t.left(90)
t.forward(bodyh)
t.end_fill() # 그림 색 채우기 끝

t.up()
t.goto(-bodyw/4, bodyh/2) # 노란색 사각형을 빨간색 사각형 위에 위치하도록  좌표 설정
t.down()
t.color(headc) # 펜촉색상을 노란색으로 설정
t.begin_fill()
t.left(90)
t.fd(headw) # fd = forward의 약어
t.left(90)
t.fd(headh)
t.left(90)
t.fd(headw)
t.left(90)
t.fd(headh)
t.end_fill()

t.up()
t.goto(-bodyw/3, -bodyh/2) # 왼쪽 검정색 바퀴가 빨간색 사각형 밑에 위치하도록 좌표 설정
t.down()
t.color(tirec) #색상을 검정색으로 설정
t.begin_fill()
t.circle(tirer) # 원의 반지름을 50으로 설정
t.end_fill()

t.up()
t.goto(bodyw/3, -bodyh/2) # 오른쪽 검정색 바퀴가 빨간색 사각형 밑에 위치하도록 좌표 설정
t.down()
t.begin_fill()
t.circle(-tirer)
t.end_fill()

t.reset() # 그림판 초기화
# ====================================
bodyw = bodyw*1.5 # 바디의 가로값을 1.5배
bodyh = bodyh*1.5 # 바디의 세로값을 1.5배
headw = bodyw/2 # 바디의 값이 바뀌었으므로 재설정
headh = bodyh/2
tirer = headw/4
t.up()
t.goto(-bodyw/2,-bodyh/2) # 자동차 바디를 가운데에 그리기 위해 좌표를 왼쪽 하단으로 설정
t.down()
t.color(bodyc) # 펜촉색상을 빨간색으로 설정
t.begin_fill() # 그림 색 채우기 시작
t.forward(bodyw) # 400만큼 이동
t.left(90) # 왼쪽각으로 90만큼 옮기기
t.forward(bodyh)
t.left(90)
t.forward(bodyw)
t.left(90)
t.forward(bodyh)
t.end_fill() # 그림 색 채우기 끝

t.up()
t.goto(-bodyw/4, bodyh/2) # 노란색 사각형을 빨간색 사각형 위에 위치하도록  좌표 설정
t.down()
t.color(headc) # 펜촉색상을 노란색으로 설정
t.begin_fill()
t.left(90)
t.fd(headw) # fd = forward의 약어
t.left(90)
t.fd(headh)
t.left(90)
t.fd(headw)
t.left(90)
t.fd(headh)
t.end_fill()

t.up()
t.goto(-bodyw/3, -bodyh/2) # 왼쪽 검정색 바퀴가 빨간색 사각형 밑에 위치하도록 좌표 설정
t.down()
t.color(tirec) #색상을 검정색으로 설정
t.begin_fill()
t.circle(tirer) # 원의 반지름을 50으로 설정
t.end_fill()

t.up()
t.goto(bodyw/3, -bodyh/2) # 오른쪽 검정색 바퀴가 빨간색 사각형 밑에 위치하도록 좌표 설정
t.down()
t.begin_fill()
t.circle(-tirer)
t.end_fill()

t.reset()
# ==============================
bodyw = bodyw*3 # 바디의 가로값을 기존값의 3배로 지정
bodyh = bodyh*3
headw = bodyw/2
headh = bodyh/2
tirer = headw/4
t.up()
t.goto(-bodyw/2,-bodyh/2) # 자동차 바디를 가운데에 그리기 위해 좌표를 왼쪽 하단으로 설정
t.down()
t.color(bodyc) # 펜촉색상을 빨간색으로 설정
t.begin_fill() # 그림 색 채우기 시작
t.forward(bodyw) # 400만큼 이동
t.left(90) # 왼쪽각으로 90만큼 옮기기
t.forward(bodyh)
t.left(90)
t.forward(bodyw)
t.left(90)
t.forward(bodyh)
t.end_fill() # 그림 색 채우기 끝

t.up()
t.goto(-bodyw/4, bodyh/2) # 노란색 사각형을 빨간색 사각형 위에 위치하도록  좌표 설정
t.down()
t.color(headc) # 펜촉색상을 노란색으로 설정
t.begin_fill()
t.left(90)
t.fd(headw) # fd = forward의 약어
t.left(90)
t.fd(headh)
t.left(90)
t.fd(headw)
t.left(90)
t.fd(headh)
t.end_fill()

t.up()
t.goto(-bodyw/3, -bodyh/2) # 왼쪽 검정색 바퀴가 빨간색 사각형 밑에 위치하도록 좌표 설정
t.down()
t.color(tirec) #색상을 검정색으로 설정
t.begin_fill()
t.circle(tirer) # 원의 반지름을 50으로 설정
t.end_fill()

t.up()
t.goto(bodyw/3, -bodyh/2) # 오른쪽 검정색 바퀴가 빨간색 사각형 밑에 위치하도록 좌표 설정
t.down()
t.begin_fill()
t.circle(-tirer)
t.end_fill()


t.done() # 프로그램이 수행 후에도 그림판이 남아있도록 설정