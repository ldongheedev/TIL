'''
리스트를 사용하여 친구의 이름, 전화번호, 주소(00동)을 관리하는 프로그램 작성.
메뉴: 신규친구입력(동명이인 가능), 이름으로 검색하기, 주소로 검색하기, 이름으로 찾아 내용 수정하기, 이름으로 삭제하기(같은 이름 여러 개인 경우 사용자가 그중에서 골라서 삭제하기), 전체출력하기, 종료
'''


# 새친구 등록
def insert_friend() :
    
     name = input("친구이름: ")
     phone= input("폰번호: ")
     addr = input("주소(동) : ")
     friend.append([name,phone,addr])
     
     
#이름으로 검색하기  
def search_by_name() :
    
    input_name = input("친구이름: ")
    cnt = 0  #이름이 있는 지 확인
    
    for name, phone, addr  in friend :
        if name == input_name :
            print(f"폰번호: {phone}, 주소: {addr}")
            cnt+= 1
    if cnt == 0 :
        print("등록되지 않은 이름입니다")


#주소로 검색하기
def search_by_addr() :
    
    addr = input("주소(동): ")
    cnt = 0 #해당 주소에 사는 친구 여부 확인용
    
    for i in range(len(friend)) :
        if friend[i][2] == addr :
            print(f"이름:{friend[i][0]}, 폰번호: {friend[i][1]}")
            cnt+= 1
    if cnt == 0 :
        print(f"{addr}에는 사는 친구가 없습니다")
          

#이름으로 찾아 내용수정하기
def change_by_name() :
    change_index = [] # 동명이인들의 인덱스값 저장 
    name = input("친구이름: ")
    cnt = 0
    
    for i in range(len(friend)) :
        if friend[i][0] == name :
            print(f"{cnt+1}번 친구 폰번호: {friend[i][1]}, 주소: {friend[i][2]}")
            change_index.append(i)
            cnt+= 1
            
    if cnt == 0 :
        print("등록되지 않은 이름입니다")
        return
    elif cnt == 1 :
       index = change_index[0]
    else : #동명이인이 있는 경우
       cnt = int(input("몇번 친구를 수정할까요? "))
       index = change_index[cnt-1]
        
    friend[index][1] = input("수정할 폰번호:")
    friend[index][2] = input("수정할 주소: ")
    print("수정완료")

                        
 #이름으로 삭제하기
def delete_by_name() :
    delete_index = [] # 동명이인들의 인덱스값 저장 
    name = input("친구이름: ")
    cnt = 0
    
    for i in range(len(friend)) :
        if friend[i][0] == name :
            print(f"{cnt+1}번 친구 폰번호: {friend[i][1]}, 주소: {friend[i][2]}")
            delete_index.append(i)
            cnt+= 1
            
    if cnt == 0 :
        print("등록되지 않은 이름입니다")
        return
     
    elif cnt == 1 :
       index = delete_index[0]
    else :
       cnt = int(input("몇번 친구를 삭제할까요? "))
       index = delete_index[cnt-1] 
  
    del friend[index]
    
    print("삭제완료")           


# 전체 친구 출력
def all_friend_print() :
    new_list = sorted(friend)
    for i  in  new_list :
        print("%-7s\t%-10s\t%-10s\n" %(i[0], i[1], i[2]))

              

#메시지 지정
msg = "1.새친구등록(동명이인 가능), 2. 이름으로 검색하기, 3. 주소로 검색하기 4. 이름으로 찾아 내용수정하기, 5. 이름으로 삭제하기  6.전체 출력, 7.종료 : "


friend = []

if __name__=='__main__':
    while True: 
        n= int(input(msg))

        if n == 1 :
            insert_friend()
        elif n == 2:
            search_by_name()
        elif n == 3:
           search_by_addr()  
        elif n == 4:
            change_by_name()
        elif n == 5:
            delete_by_name()
        elif n == 6:
            all_friend_print()
        elif n == 7:
            print("프로그램 종료\n")
            break
        else :
            print("1~7중에서 선택하세요\n")
           
               
