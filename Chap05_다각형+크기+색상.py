#도형의 유형, 크기, 색상을 입력받아 그리기 또는 오류 메시지 띄우기
import turtle as t
t.shape("turtle")

# 그림판 안에서 도형의  유형과 크기 색상을 prompt함
figure = int(t.textinput("", "도형의 유형을 입력하시오 (0~8): "))
size = int(t.textinput("", "크기입력: "))
color = int(t.textinput("", "색상입력(1:red, 2:yellow, 3:blue, 4:green, 5:black): " ))

# 각 번호에 따라 색상을 저장
if color == 1:
    t.color("red")
elif color == 2:
    t.color("yellow")
elif color == 3:
    t.color("blue")
elif color == 4:
    t.color("green")
elif color == 5:
    t.color("black")
else:
    t.color("black")

if figure == 0: # 0은 원을 그림
    t.begin_fill()
    t.circle(size)
    t.end_fill()

elif figure == 1 or figure == 2 or figure == 7: # 1, 2, 7은 오류 메시지를 띄움
    t.up()
    t.goto(100, 100)
    t.write("오류메시지입니다.")
    t.goto(0, 0)
    t.down()

elif figure in [3, 4, 5, 6, 8]: # 3, 4, 5, 6, 8각형의 도형을 그림
    # 다각형의 유형에 따라 앵글 각도를 설정
    angle = 360/figure
    t.begin_fill()
    for i in range(figure): # for문을 이용하여 간결하게 코드 작성
        t.fd(size)
        t.right(angle)
    t.end_fill()

else: # 0~8 사이의 숫자가 아닌 숫자를 입력 받으면 아래의 코드를 실행
    t.write("0~8 사이의 숫자를 입력해주세요.")

t.done()
