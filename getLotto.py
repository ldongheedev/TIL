#로또 번호를 생성하는 함수를 작성하여 사용해보자. 로또 번호는 1부터 45까지의 숫자
# 6개로 이루어진다. 따라서 6개의 난수를 생성해야 한다. 번호는 중복되면 안된다

import random as r #random 라이브러리를 import하였음

def getLotto():     # getLotto 함수를 호출
    numbers = []    # numbers라는 빈 리스트를 생성
    while len(numbers) < 6:     #numbers 리스트가 6보다 작으면 계속 실행
        n = r.randint(1,45)     #1~45의 숫자를 랜덤으로 선택
        if n not in numbers:    #numbers리스트 안에 n이 없다면 조건문
            numbers.append(n)   
    return numbers      #numbers 값 반환

for i in range(5):
    print(f"{i+1}번째 생성된 로또번호: {getLotto()}")
