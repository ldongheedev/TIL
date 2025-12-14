friend = []

def insert_friend():
    name = input("이름: ")
    phone = input("전화번호: ")
    addr = input("주소(동): ")
    friend.append([name, phone, addr])

def search_by_name():
    name = input("이름: ")
    for f in friend:
        if f[0] == name:
            print(f"전화번호: {f[1]}, 주소: {f[2]}")

while True:
    sel = int(input("1.등록 2.검색 3.종료: "))
    if sel == 1:
        insert_friend()
    elif sel == 2:
        search_by_name()
    elif sel == 3:
        break
