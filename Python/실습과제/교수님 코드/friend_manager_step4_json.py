import json

class Friend:
    def __init__(self, name, phone, addr):
        self.name = name
        self.phone = phone
        self.addr = addr

    def __str__(self):
        return f"{self.name}, {self.phone}, {self.addr}"

    def to_dict(self):
        return {"name": self.name, "phone": self.phone, "addr": self.addr}

    @staticmethod
    def from_dict(data):
        return Friend(data["name"], data["phone"], data["addr"])

class FriendManager:
    def __init__(self, filename="friends.json"):
        self.friends = []
        self.filename = filename
        self.load_friends()

    def insert_friend(self):
        name = input("이름: ")
        phone = input("전화번호: ")
        addr = input("주소(동): ")
        self.friends.append(Friend(name, phone, addr))
        print("등록 완료!")
        self.save_friends()

    def search_by_name(self):
        name = input("이름: ")
        found = [f for f in self.friends if f.name == name]
        if not found:
            print("등록되지 않은 이름입니다.")
        else:
            for f in found:
                print(f)

    def all_friend_print(self):
        if not self.friends:
            print("등록된 친구가 없습니다.")
            return
        print("\n[전체 친구 목록]")
        for f in sorted(self.friends, key=lambda x: x.name):
            print(f)
        print()

    def save_friends(self):
        data = [f.to_dict() for f in self.friends]
        with open(self.filename, "w", encoding="utf-8") as f:
            json.dump(data, f, ensure_ascii=False, indent=2)
        print(f"→ '{self.filename}' 파일로 저장되었습니다.")

    def load_friends(self):
        try:
            with open(self.filename, "r", encoding="utf-8") as f:
                data = json.load(f)
                self.friends = [Friend.from_dict(d) for d in data]
            print(f"✅ '{self.filename}'에서 {len(self.friends)}명 불러옴")
        except FileNotFoundError:
            print("⚠️ 기존 데이터 파일이 없어 새로 시작합니다.")
            self.friends = []

    def run(self):
        msg = (
            "\n1. 새친구등록\n"
            "2. 이름으로 검색\n"
            "3. 전체 출력\n"
            "4. 프로그램 종료\n"
            "선택: "
        )

        while True:
            try:
                choice = int(input(msg))
            except ValueError:
                print("숫자를 입력하세요.")
                continue

            if choice == 1:
                self.insert_friend()
            elif choice == 2:
                self.search_by_name()
            elif choice == 3:
                self.all_friend_print()
            elif choice == 4:
                print("프로그램 종료")
                break
            else:
                print("1~4 중에서 선택하세요.")

if __name__ == "__main__":
    FriendManager().run()
