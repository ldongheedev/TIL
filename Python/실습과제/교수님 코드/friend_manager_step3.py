class Friend:
    def __init__(self, name, phone, addr):
        self.name = name
        self.phone = phone
        self.addr = addr

    def __str__(self):
        return f"{self.name}, {self.phone}, {self.addr}"

class FriendManager:
    def __init__(self):
        self.friends = []

    def insert_friend(self):
        name = input("이름: ")
        phone = input("전화번호: ")
        addr = input("주소(동): ")
        self.friends.append(Friend(name, phone, addr))
        print("등록 완료!")

    def search_by_name(self):
        name = input("이름: ")
        for f in self.friends:
            if f.name == name:
                print(f)

    def run(self):
        while True:
            sel = int(input("1.등록 2.검색 3.종료: "))
            if sel == 1:
                self.insert_friend()
            elif sel == 2:
                self.search_by_name()
            elif sel == 3:
                print("프로그램 종료")
                break

if __name__ == "__main__":
    FriendManager().run()
