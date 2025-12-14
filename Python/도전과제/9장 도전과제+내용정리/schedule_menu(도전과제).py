'''
입력한 날짜에 일정 넣기
특정한 날에 여러 개 일정 등록 가능
기능 메뉴화
'''

# 딕셔너리를 저장할 곳 선언 
mydict = {}

# 메뉴화를 위해 무한루프 생성
while True:
    n = int(input("1. 일정등록 2. 모든 일정 조회 3: 종료: "))
    if n == 3:
        break
    
    elif n == 1:
        date = input("날짜를 입력하시오: ")
        job = input("일정을 입력하시오: ")

        if date not in mydict.keys(): # 해당 날짜의 새로운 일정이라면
            mydict[date] = [job]
        else: # 해당 날짜의 이미 일정이 있으면 따로 추가하기
            mydict[date].append(job)
    elif n == 2:
        print(mydict)

print("프로그램 종료")
input()
