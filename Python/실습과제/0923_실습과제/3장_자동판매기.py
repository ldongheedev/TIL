#자판기 시뮬레이션 (거스름돈을 동전 단위별 몇개 줄 것인지 계산(% //)하여 출력
#devide & conquer 기법으로 로직 잡기


#사용자에게 투입한 돈, 물건값 입력받음
money = int(input("투입할 돈: ")) #투입할 돈을 입력하는 코드
price = int(input("물건값: ")) #물건 값을 입력하는 코드


# 거슬러 줄 잔돈을 가지고 있는 코인단위의 갯수 계싼
change = money-price #거스름 돈을 계산
print("거스름돈: ", change) # 거스름 돈을 알려줌

coin500s = change // 500 #거스름 돈에서 500원 동전이 몇개인지 계산
change = change % 500 # 500원 동전이 빠진 나머지 계산값

coin100s = change // 100
change = change % 100

coin50s = change // 50
change = change % 50

coin10s = change // 10
change = change % 10


#결과값 출력하기
print("500원 동전의 개수: ", coin500s) #500원 동전이 몇개인지 알려줌
print("100원 동전의 개수: ", coin100s)
print("50원 동전의 개수: ", coin50s)
print("10원 동전의 개수: ", coin10s)
