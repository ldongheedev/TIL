import random as r

# 랜덤 숫자 2개와 사칙연산 랜덤으로 반환하는 tool 함수 선언
def tool():
    num1 = r.randint(1,9)
    num2 = r.randint(1,9)

    oper = r.choice(["+", "-", "/", "*"])

    if oper == "+":
        ans  = num1 + num2
    elif oper == "-":
        ans  = num1 - num2
    elif oper == "*":
        ans  = num1 * num2
    else:
        ans  = num1 / num2

    return num1, oper, num2 , ans

# 사용자의 값을 입력 받아 해당 문제와 비교하여 정답오답 판별 
def QTU(num1, oper, num2, ans):
    print(f"{num1} {oper} {num2} = ")
    while True:
        user_ans = int(input("정답: "))
        if ans == user_ans:
            break
        else:
            print("오답")

while True:
    a = tool() # 함수 호출
    QTU(*a) # 오류가 나지 않게 튜플 사용

    question = input("계속하시겠습니까? (y/n): ")
    if question != "y": # y를 입력하면 계속 실행, 외의 것은 프로그램 종료
        break

    
    
