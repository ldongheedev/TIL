# 교재 연습문제 09번
# 2자리 숫자로 이루어진 복권,
#복권번호는 사용자가 입력,당첨번호는
#무작위로 생성하여 사용자 번호와 비교,다 맞으면
#100만원,2자리중 1개 맞으면 50만원,아니면 꽝

import random as r


user = int(input("2자리 복권숫자를 입력하시오: ")) #사용자의 복권예측 수를 입력받음

user10 = user//10 #10의자리 숫자를 user10변수에 저장
user1 = user%10 #1의자리 숫자를 user1변수에 저장

lotto = r.randint(00,99)

lotto10 = lotto//10
lotto1 = lotto%10

print(f"로또의 번호는 {lotto}이다.") # 로또의 번호를 먼저 보여줌
print(f"복권의 10의자리는{lotto10}이고, 1의자리는 {lotto1}이다.")

# 로또와 사용자로또번호의 10의자리 수와 1의 자리 수를 비교하여 알맞게 값출력
if user10 == lotto10 and user1 == lotto1:
    print("2자리 다 맞았다 100만원이다.")

elif user10 == lotto10 or user1 == lotto1:
    print("1자리 맞았다 50만원이다.")

else:
    print("둘다 틀렸다 상금은 없다")
    
