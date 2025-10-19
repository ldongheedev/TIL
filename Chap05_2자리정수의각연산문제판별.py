#2자리 정수 2개를 랜덤으로 부여받아 각 연산자로 연산하여
#사용자의 입력값과 비교해 정답 오답을 판별하는 프로그램
import random as r

# 2자리 정수 2개를 각 num1,num2에 저장
num1 = r.randint(10, 99)
num2 = r.randint(10, 99)

operator = r.choice(["+","-","*","/"]) # 연산자를 operator변수에 랜덤 지정

# 각 연산자에 대한 정수 2개 값 계산
if operator == "+":
    ans = num1+num2
elif operator == "-":
    ans = num1-num2
elif operator == "*":
    ans = num1*num2
else:
    ans = num1/num2

 
ans = round(ans, 1) # 나눗셈 결과를 소수점 첫 번째로 반올림   

#fString으로 깔끔하게 정리
quest = float(input(f"{num1}{operator}{num2}= "))


if operator == "/":
    round(quest, 1) # 사용자가 입력 받은 값도 소수점 첫 번째로 반올림

# 정답 오답 프린트
if quest == ans:
    print("정답")
else:
    print("오답")
