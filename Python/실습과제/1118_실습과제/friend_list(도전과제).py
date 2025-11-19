'''
리스트를 사용하여 친구의 이름, 전화번호, 주소(00동)을 관리하는 프로그램 작성
메뉴: 신규친구입력(동명이인 가능), 이름으로 검색하기, 주소로 검색하기,
이름으로 찾아 내용 수정하기, 이름으로 삭제하기(같은 이름 여러 개인 경우 사용자가
그중에서 골라서 삭제하기), 전체 출력하기, 종료
'''

#새친구 등록
def insert_friend() :
    name = input("친구이름: ")
    phone = input("폰번호: ")
    addr = input("주소(동): ")
    friend.append([name,phone,addr])


......

#메시지 지정
msg = "1.새친구등록(동명이인 가능), 2. 이름으로 검색하기, 3, 주소로 검색하기, 4. 이름으로 찾아 내용수정하기, 5. 이름으로 삭제하기, 6.전체 출력, 7 종료 : "

friend = []

if __name__ = '__main__' :
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
