#터틀 그래픽 가져오기
import turtle as t
#펜촉 모양을 거북이로 설정
t.shape("turtle")

#자동차 만들기

#펜촉을 들어서 그려지지 않게 한후, 좌표를 -200,-100으로 이동
#펜촉을 down으로 내려 놓고 그려지게 설정
t.up()
t.goto(-200,-100)
t.down()
t.color("red") # 펜촉색상을 빨간색으로 설정
t.begin_fill() # 그림 색 채우기 시작
t.forward(400) # 400만큼 이동
t.left(90) # 왼쪽각으로 90만큼 옮기기
t.forward(200)
t.left(90)
t.forward(400)
t.left(90)
t.forward(200)
t.end_fill() # 그림 색 채우기 끝

t.up()
t.goto(-100, 100) # 노란색 사각형을 빨간색 사각형 위에 위치하도록  좌표 설정
t.down()
t.color("yellow") # 펜촉색상을 노란색으로 설정
t.begin_fill()
t.left(90)
t.fd(200) # fd = forward의 약어
t.left(90)
t.fd(100)
t.left(90)
t.fd(200)
t.left(90)
t.fd(100)
t.end_fill()

t.up()
t.goto(-150, -100) # 왼쪽 검정색 바퀴가 빨간색 사각형 밑에 위치하도록 좌표 설정
t.down()
t.color("black") #색상을 검정색으로 설정
t.begin_fill()
t.circle(50) # 원의 반지름을 50으로 설정
t.end_fill()


t.up()
t.goto(50, -100) # 오른쪽 검정색 바퀴가 빨간색 사각형 밑에 위치하도록 좌표 설정
t.down()
t.begin_fill()
t.circle(50)
t.end_fill()

t.clear() # 자동차를 클리어함수로 그린 화면 지우기
t.reset() # 펜촉의 각도와 위치를 리셋


#터틀 그래픽 가져오기
import turtle as t
#펜촉 모양을 거북이로 설정
t.shape("turtle")

#굴러가는 집 모양 만들기

#펜촉이 그려지지 않게 up으로 들고 정사각형이 가운데에 오도록
#펜촉을 goto명령어로  -100,-100(x,y)좌표로 이동 후, down명령어로 펜촉을 내려놓음
t.up() 
t.goto(-100,-100) 
t.down()


t.color("black","yellow") #펜촉의 테두리색을 검정,배경색을 노란색으로 설정
t.begin_fill() # 그림 그리는 화면의 색 채우기 시작
t.fd(200) # 200만큼 이동 fd = forward의 줄임
t.left(90) # 왼쪽각으로 90도 이동
t.fd(200)
t.left(90)
t.fd(200)
t.left(90)
t.fd(200)
t.end_fill() # 색 채우기 끝 

t.up()
t.goto(-100,100) # 삼각형을 그리기 위해 노란색 사각형의 왼쪽 모서리로 이동
t.down()
t.color("black","green") #테두리색은 검정, 배경색은 초록색으로 설정
t.begin_fill()
t.left(90)
t.fd(200)
t.left(120)
t.fd(200)
t.left(120)
t.fd(200)
t.end_fill()

t.up()
t.goto(-75,-115) # 왼쪽 바퀴를 그리기 위해 노란색 사각형의 밑 부분으로 이동
t.down()
t.color("black","brown") # 테두리색은 검정, 배경색 갈색으로 설정 
t.begin_fill()
t.circle(30) #반지름을 30으로 설정 
t.end_fill()

t.up()
t.goto(25,-115) # 오른쪽 바퀴를 그리기 위해 노란색 사각형의 밑 부분으로 이동
t.down()
t.begin_fill()
t.circle(30)
t.end_fill()

t.done() # 프로그램이 수행 후에도 그림판이 남아있도록 설정

