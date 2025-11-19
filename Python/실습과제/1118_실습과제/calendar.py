'''
일정 관리 프로그램, 하나의 일자에 1개 일정만 넣을 수 있게함
딕셔너리{일지} = 일정1
'''
'''
mydict = {}

while True:
    date = input("날짜를 입력하시오:")
    if date == "q":
        break
    if date in mydict.keys():
        print("이미 입력한 날짜임")
        continue

        
    job = input("일정을 입력하시오: ")
    mydict[date] = job

print(mydict)
'''


'''
일정 관리 프로그램, 하나의 일자에 여러 개 일정 넣을 수 있게함
딕셔너리{일지} = {일정1, 일정2.....}
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
