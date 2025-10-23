import random as r

std_id  = ["shingu", "it", "software"]

num1 = r.randint(0,9)
num2 = r.randint(0,9)
num3 = r.randint(0,9)

password = str(num1) + str(num2) + str(num3) 

std = input("사용자 id를 입력하시오")

if std in std_id :
    print("환영합니다.")
    print(f"{password}")
else :
    print("없는 id입니다.")
