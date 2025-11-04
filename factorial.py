# for문을 이용하여서 팩토리얼을 계산
# 팩토리얼 n!은 1부터 n까지의 정수를 모두 곱한 것을 의미한다.
#즉 n! = 1x2x3x......x(n-1)xn이다

#n = int(input("정수를 입력하시오 : "))
#fact = 1

#for i in range(1, n+1):
#    fact = fact * i
#print(n, "!은", fact, "이다.")

#2 정수값을 입력받아 팩토리얼 값을 계산하는 함수 정의하고 호출하기

#s = int(input("1이상의 정수 입력 : "))

#def factorial(s):
#    fact = 1
#    for i in range(1, s+1):
#        fact = fact * i
#    return fact


#n = factorial(s)
#print(f"{s}!은 {n}이다.")

#3 정수값을 입력받아 팩토리얼 값을 계산하는 함수 작성하고 호출하기를 반복
#   사용자가 0을 입력하면 프로그램 종료

#while True :
#    s = int(input("1이상의 정수 입력 : "))

#    def factorial(s):
#        fact = 1
#        for i in range(1, s+1):
#            fact = fact * i
#        return fact
#
#    n = factorial(s)
#    if s != 0 :
#        print(f"{s}!은 {n}이다.")
#    else:
#        print("프로그램을 종료합니다!")
#        break



# 팩토리얼 함수를 재귀함수로 정의하기

def factorial(n):

    if n == 1:
        return 1
    return factorial(n-1) * n

while True:
    n = int(input("1이상의 정수 입력, 프로그램 종료는 0입력 : "))
    if n == 0:
         print("프로그램을 종료합니다")
         break
    print(f"{n}! = {factorial(n)}")
