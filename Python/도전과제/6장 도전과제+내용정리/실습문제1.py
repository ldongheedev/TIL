# 10~99중 2개의 숫자를 무작위로 뽑고
# 사칙연산자도 무작위로 생성해 수학식을 만들어 출력
# 문제 정답을 마주거나 시도 횟수가 10이하일 때까지 계속 풀게함
# 처음 문제풀이가 끝나면 사용자에게 계속 할지 물어봄
# (y/n)사용자가 종료를 택하면 끝내고 아니면 계속 풀게함

import random as r

while True:  # 계속 반복함
    num1 = r.randint(10, 99)  # 10~99 사이 숫자 생성
    num2 = r.randint(10, 99)
    oper = r.choice(["+", "-", "*", "/"])  # 사칙연산자 무작위 선택

    # 연산자에 따라 정답 계산함
    if oper == "+":
        ans = num1 + num2
    elif oper == "-":
        ans = num1 - num2
    elif oper == "*":
        ans = num1 * num2
    else:
        ans = round(num1 / num2, 1)  # 나눗셈은 소수점 1자리까지 반올림

    print(f"문제: {num1} {oper} {num2} = ?")  # 문제 출력
    count = 0  # 시도 횟수 초기화함

    while count < 10:  # 최대 10번까지 시도함
        user_input = input("정답 입력: ")  # 사용자 입력 받음


        user = float(user_input)  # 입력값을 실수로 변환함

        if user == ans:
            print("정답!!!!")  # 정답 맞춤
            break
        else:
            print("오답X")  # 틀림
            count += 1
                
    # 문제 끝나고 계속할지 물어봄
    question = input("계속하시겠습니까? (y/n): ")

    if question == "n":
        print("n을 입력하셔 프로그램 종료함")
        break
    elif question != "y":
        print("y/n 외의 입력으로 프로그램 종료함")
        break
