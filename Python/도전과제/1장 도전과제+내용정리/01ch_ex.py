#터틀 그래픽 가져오기
import turtle as t
#펜촉 모양을 거북이로 설정
t.shape("turtle")

#연습문제 4번

t.fd(100) #100만큼 이동 fd = forward의 약어 
t.left(90) # 왼쪽각도로 90도 옮기기
t.fd(100)
t.right(90)
t.fd(100)
t.right(90)
t.fd(100)
t.left(90)
t.fd(100)

t.clear() # 그린 화면 지우기
t.reset() # 세팅 초기화 

#연습문제 5번

t.width(10) #펜촉의 굵기를 10으로 설정
t.fd(100)
t.left(90)
t.fd(100)


t.clear()
t.reset()

#연습문제 6번

t.color("blue") #펜촉의 색상을 파란색으로 설정
t.fd(100)

t.clear()
t.reset()

#연습문제 7번

t.shape("square") #펜촉의 모양을 사각형으로 설정
t.fd(100)

t.clear()
t.reset()

#연습문제 8번

t.shape("turtle") #펜촉의 모양을 사각형에서 거북이로 재설정
t.fd(100)

t.up() # 펜촉을 들어서 그려지지 않게함 
t.goto(0,200) # 좌표를 goto 명령어로 0,200으로 이동
t.down() # 펜촉을 내려놓아서 그려지게 만듦
t.fd(100)

t.clear()
t.reset()


#연습문제 9번 ★

t.up()
t.goto(-200,50)
t.down()
t.color("blue") #펜촉의 색상을 오륜기의 파란색으로 설정
t.width(10) #펜촉의 굵기를 10으로 설정
t.circle(100) #원의 반지름을 100으로 설정

t.up()
t.goto(-25,50)
t.down()
t.color("black") #펜촉의 색상을 오륜기의 검정색으로 설정
t.width(10)
t.circle(100) 

t.up()
t.goto(150,50)
t.down()
t.color("red") #펜촉의 색상을 오륜기의 빨간색으로 설정
t.width(10)
t.circle(100)

t.up()
t.goto(-115,-75)
t.down()
t.color("yellow") #펜촉의 색상을 오륜기의 노란색으로 설정
t.width(10)
t.circle(100)

t.up()
t.goto(65,-75)
t.down()
t.color("green") #펜촉의 색상을 오륜기의 초록색으로 설정
t.width(10)
t.circle(100)

t.done() #프로그램 수행후에도 그림판이 남아있도록 설정
