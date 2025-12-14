# manage_friend_oop.py
class Friend:
    """친구 정보를 저장하는 클래스"""
    def __init__(self, name, phone, addr):
        self.name = name
        self.phone = phone
        self.addr = addr

    def __str__(self):
        return f"이름: {self.name}, 폰번호: {self.phone}, 주소: {self.addr}"

    def update(self, phone=None, addr=None):
        if phone:
            self.phone = phone
        if addr:
            self.addr = addr


class FriendManager:
    """친구 목록을 관리하는 클래스"""
    def __init__(self):
        self.friend_list = []

    def insert_friend(self):
        name = input("친구이름: ")
        phone = input("폰번호: ")
        addr = input("주소(동): ")
        self.friend_list.append(Friend(name, phone, addr))
        print("등록 완료!")

    def search_by_name(self):
        name = input("친구이름: ")
        found = [f for f in self.friend_list if f.name == name]
        if not found:
            print("등록되지 않은 이름입니다.")
        else:
            for f in found:
                print(f)

    def search_by_addr(self):
        addr = input("주소(동): ")
        found = [f for f in self.friend_list if f.addr == addr]
        if not found:
            print(f"{addr}에는 사는 친구가 없습니다.")
        else:
            for f in found:
                print(f)

    def change_by_name(self):
        name = input("친구이름: ")
        found = [f for f in self.friend_list if f.name == name]
        if not found:
            print("등록되지 않은 이름입니다.")
            return

        for idx, f in enumerate(found, start=1):
            print(f"{idx}. {f}")

        if len(found) > 1:
            num = int(input("몇번 친구를 수정할까요? "))
            target = found[num - 1]
        else:
            target = found[0]

        new_phone = input("수정할 폰번호: ")
        new_addr = input("수정할 주소(동): ")
        target.update(phone=new_phone, addr=new_addr)
        print("수정 완료!")

    def delete_by_name(self):
        name = input("친구이름: ")
        found = [f for f in self.friend_list if f.name == name]
        if not found:
            print("등록되지 않은 이름입니다.")
            return

        for idx, f in enumerate(found, start=1):
            print(f"{idx}. {f}")

        if len(found) > 1:
            num = int(input("몇번 친구를 삭제할까요? "))
            target = found[num - 1]
        else:
            target = found[0]

        self.friend_list.remove(target)
        print("삭제 완료!")

    def all_friend_print(self):
        if not self.friend_list:
            print("등록된 친구가 없습니다.")
            return

        print("\n[전체 친구 목록]")
        for f in sorted(self.friend_list, key=lambda x: x.name):
            print(f"{f.name:7}\t{f.phone:12}\t{f.addr}")
        print()

    def run(self):
        msg = (
            "\n1. 새친구등록(동명이인 가능)\n"
            "2. 이름으로 검색하기\n"
            "3. 주소로 검색하기\n"
            "4. 이름으로 찾아 내용수정하기\n"
            "5. 이름으로 삭제하기\n"
            "6. 전체 출력\n"
            "7. 종료\n선택: "
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
                self.search_by_addr()
            elif choice == 4:
                self.change_by_name()
            elif choice == 5:
                self.delete_by_name()
            elif choice == 6:
                self.all_friend_print()
            elif choice == 7:
                print("프로그램 종료")
                break
            else:
                print("1~7 중에서 선택하세요.")


if __name__ == "__main__":
    manager = FriendManager()
    manager.run()
