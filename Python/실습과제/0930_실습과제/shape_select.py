#그림판을 띄우고 사용자에게 몇각형 그릴지 물어보고 해당 다각형 그리기

import turtle as t

s = t.textinput("", "몇각형을 그릴까요?")
n = int(s)
angle = 360/n

t.penup() #펜을 올려서 그림이 그려지지 않게 한다
t.goto(-100, 200) #거북이를 (-100, 200)으로 이동시킨다.
t.pendown() #펜을 내려서 그림이 그려지게 한다.

if n == 3 :  #삼각형 그리기
    t.forward(100)
    t.right(angle)
    t.forward(100)
    t.right(angle)
    t.forward(100)

elif n == 4 :  # 사각형 그리기
    t.forward(100)
    t.right(angle)
    t.forward(100)
    t.right(angle)
    t.forward(100)
    t.right(angle)
    t.forward(100)

elif n == 5 :  #오각형 그리기
    t.forward(100)
    t.right(angle)
    t.forward(100)
    t.right(angle)
    t.forward(100)
    t.right(angle)
    t.forward(100)
    t.right(angle)
    t.fd(100)

elif n == 6 :  #육각형 그리기
    t.forward(100)
    t.right(angle)
    t.forward(100)
    t.right(angle)
    t.forward(100)
    t.right(angle)
    t.forward(100)
    t.right(angle)
    t.fd(100)
    t.right(angle)
    t.fd(100)

else :
    t.write("잘못된 값입니다.")
