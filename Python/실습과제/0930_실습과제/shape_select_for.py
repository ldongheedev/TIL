#그림판을 띄우고 사용자에게 몇각형 그릴지 물어보고 해당 다각형 그리기

import turtle as t

n = 1
while n !=0 : 

    n = int(t.textinput("", "몇각형을 그릴까요? 종료는 0번"))

    t.penup() #펜을 올려서 그림이 그려지지 않게 한다
    t.goto(-100, 200) #거북이를 (-100, 200)으로 이동시킨다.
    t.pendown() #펜을 내려서 그림이 그려지게 한다.

    if n == 0:
        break

    elif n < 3 or n > 6 :
        t.write("잘못된 입력값입니다.")
    else :
        t.reset()
        angle = 360/n
        t.penup() #펜을 올려서 그림이 그려지지 않게 한다
        t.goto(-100, 200) #거북이를 (-100, 200)으로 이동시킨다.
        t.pendown() #펜을 내려서 그림이 그려지게 한다.
        for i in range(n) :
            t.fd(100)
            t.right(angle)
            
t.write("프로그램을 종료합니다.")
