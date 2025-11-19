import turtle as t
import random as r

t.shape("turtle")

def shape_draw():
    dagak = r.randint(3, 6) # 3~6각형의 도형을 그리기 위해 랜덤으로 각 선언
    
    t.penup()
    t.goto(r.randint(-200, 200), r.randint(-200, 200)) # 그림 좌표 임의의 수로 선언
    t.pendown()
    
    t.begin_fill()
    t.color(r.random(), r.random(), r.random())    
    for i in range(dagak): 
        t.fd(r.randint(50, 150))
        t.left(360 / dagak) 
    t.end_fill()

# 그릴 횟수 1~10 사이의 변수로 설정
times = r.randint(1, 10)

print(f"그린 횟수: {times}")
for i in range(times):
    shape_draw()

# 프로그램이 종료 돼도 그대로 남겨 놓기
t.done()
