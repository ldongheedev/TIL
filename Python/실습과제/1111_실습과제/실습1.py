#<실습1>
#사용자에게 2 이상의 정수 n과 연산자를 입력받아
#연산자가 곱하기이면 1~n까지의 곱을 계산
#연산자가 더하기이면 1~n까지의 합을 계산
#함수 사용하기 전과 후 비교
'''
n = int(input("2이상의 정수 n을 입력하시오"))
op = input("연산자 +,* 중 하나를 입력하시오")

if op == '+':
    result = 1
    for i in range(2, n+1):
        result += i
elif op == '*' or op == 'X' or op == 'x':
    result = 1
    for i in range(2, n+1):
        result *= i
else:
    print("잘못된 연산자입니다.")

print(f"{n}까지 {op}연산한 결과값은 {result}입니다.")
'''
#===============================

def add_int(n) :
    result = 0
    for i in range(2, n+1):
        result += i
    return result

def multiply_int(n) :
    result = 1
    for i in range(2, n+1):
        result *= i
    return result

n = int(input("2이상의 정수 n을 입력하시오"))
op = input("연산자 +,* 중 하나를 입력하시오")

if op == '+':
    result = add_int(n)
elif op == '*' or op == 'X' or op == 'x':
    result = multiply_int(n)
else:
    print("잘못된 연산자입니다.")

print(f"{n}까지 {op}연산한 결과값은 {result}입니다.")

