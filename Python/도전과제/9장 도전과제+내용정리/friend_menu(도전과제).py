'''
리스트를 사용하여 친구의 이름, 전화번호, 주소 (00동) 관리하는 프로그램 작성.
메뉴: 신규친구입력(동명이인 가능), 이름으로 검색하기, 주소로 검색하기, 이름으로 찾아 내용 수정하기,
이름으로 삭제하기(같은 이름 여러 개인 경우 사용자가 그 중에서 골라서 삭제하기), 전체출력하기, 종료
'''

#메시지 지정
msg = "1.새친구등록(동명이인 가능), 2. 이름으로 검색하기, 3. 주소로 검색하기 4. 이름으로 찾아 내용수정하기, 5. 이름으로 삭제하기 6. 전체 출력, 7. 종료: "


friend = []

# 새친구 등록
def insert_friend():
    name = input("친구이름: ")
    phone = input("폰번호: ")
    addr = input("주소(동): ")
    friend.append([name,phone,addr])

# 이름으로 검색하여 정보 보기
def search_by_name():
    n = input("친구이름: ")
    search = False # 친구가 존재하는 지 체크
    for index in friend:
        if index[0] == n:
            print(f"이름: {index[0]}, 번호: {index[1]}, 주소: {index[2]}")
            search = True # 존재하면 True
    if not search: # 만약 false라면 이름이 없다고 출력
        print('없는 이름입니다')

# 주소로 검색하여 정보 보기
def search_by_addr():
    n = input("친구주소: ")
    search = False
    for index in friend:
        if index[2] == n:
            print(f"이름: {index[0]}, 번호: {index[1]}, 주소: {index[2]}")
            search = True
    if not search:
        print('없는 주소입니다.')

# 이름으로 대상을 검색 후 내용 변경하기
def change_by_name():
    n = input("친구이름: ")
    search = False
    for index in friend:
        if index[0] == n:
            print(f"{n}의 정보를 수정합니다.")
            index[0] = input("새 이름: ")
            index[1] = input("새 번호: ")
            index[2] = input("새 주소: ")
            search = True
            return
    if not search:
        print('없는 이름입니다')

# 이름으로 대상을 검색 후 해당 데이터 삭제하기 
def delete_by_name():
    n = input("친구이름: ")
    search = False
    for index in friend:
        if index[0] == n:
            friend.remove(index)
            search = True
    if not search:
        print('없는 이름입니다')

# 모든 데이터 값 보여주기
def all_friend_print():
    print(friend)


    
        


if __name__ == '__main__':
    
    while True:
        n = int(input(msg))

        if n == 1:
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
        else:
            print("1~7중에서 선택하세요\n")
