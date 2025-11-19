
'''
mydict = {}

while True:
    date = input("날짜를 입력하시오:")
    if date == "q":
        break
    job = input("일정을 입력하시오: ")

    if date not in mydict.keys(): #신규 일정
        mydict[date] = [job] #처음부터 리스트 변수로 값을 저장
    else: # 이미 일정이 있는 날짜\
        mydict[date].append(job) # 추가 일정을 리스트 변수 항목으로 append

print(mydict)
#프로그램 소스 더블클릭하면 콘솔창이 프로그램 실행 후 자동으로
#닫히는 것을 방지하기 위해 
input()
'''
'''
입력한 날짜에 일정 넣기
특정한 날에 여러 개 일정 등록 가능
기능 메뉴화
'''
mydict = {}

while True:
    n = int(input("1. 일정등록 2. 모든 일정 조회 3: 종료: "))
    if n == 3:
        break
    elif n == 1:
        date = input("날짜를 입력하시오: ")
        job = input("일정을 입력하시오: ")

        if date not in mydict.keys():
            mydict[date] = [job]
        else:
            mydict[date].append(job)
    elif n == 2:
        print(mydict)

print("프로그램 종료")
input()
        
