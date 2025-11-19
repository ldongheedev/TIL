#산수 퀴즈 만들기


import random as r # random 모듈을 r이라는 약어로 만듬

x = r.randint(0,10) #x에 random 값을 넣어줌
y = r.randint(0,10)

msg = str(x) + '+' + str(y) + '=' #x+y의 메시지가 나오도록 하는 코드
ans = int(input(msg)) #메시지에 대한 값을 받도록 설정

calc_ans = x + y #x와 y의 값을 합

if ans == calc_ans :  #if문을 사용하여 x+y의 값이 맞는 확인
    print("정답")
else :
    print("오답")
