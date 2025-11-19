#사용자한테 값을 입력 받는것
#계산해서 화면에 출력하는 프로그램

x = int(input("첫 번째 숫자를 입력하시오!"))
y = int(input("두 번째 숫자를 입력하시오!"))

hap = x + y
cha = x - y
gop = x * y
mok = x // y
na = x % y

print("두 숫자의 합은 = ", hap)
print("두 숫자의 차는 = ", cha)
print("두 숫자의 곱은 = ", gop)
print("두 숫자의 나눗셈은 = ", mok)
print("두 숫자의 나머지는 = ", na)
