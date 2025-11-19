import random as r

# 1~100까지의 숫자를 랜덤으로 10가지 생성 후 random_list리스트에
# append로 값을 넣음
def random_num():
    random_list = []
    for _ in range(10):
        random_list.append(r.randint(1,100))
    return random_list

# 가장 큰 값을 찾는 함수 선언
def max_num(num):
    Maxium_num = num[0]
    for i in num:
        if i > Maxium_num:  # Maxium_num과 비교
            Maxium_num = i
    return Maxium_num

num1 = random_num()
BN = max_num(num1)

print(f"10개의 숫자: {num1}")
print(f"가장 큰 값: {BN}")
    
