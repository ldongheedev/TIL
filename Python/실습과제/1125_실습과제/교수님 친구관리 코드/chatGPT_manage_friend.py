'''
chapGPT작성
- 리스트를 사용하여 친구의 이름, 전화번호, 주소(00동)을 관리하는 프로그램 작성.
- 메뉴: 신규친구입력(동명이인 가능), 이름으로 검색하기, 주소로 검색하기, 이름으로 찾아 내용 수정하기, 이름으로 삭제하기(같은 이름 여러 개인 경우 사용자가 그중에서 골라서 삭제하기), 전체출력하기, 종료
'''
# 친구 정보를 저장할 리스트
friends_list = []

# 친구 정보를 관리하는 함수들

def add_friend():
    name = input("친구의 이름을 입력하세요: ")
    phone = input("친구의 전화번호를 입력하세요: ")
    address = input("친구의 주소(00동)를 입력하세요: ")
    # 친구 정보 딕셔너리로 저장
    friend = {"name": name, "phone": phone, "address": address}
    friends_list.append(friend)
    print(f"{name}님의 정보가 추가되었습니다.")

def search_by_name():
    name = input("검색할 친구의 이름을 입력하세요: ")
    found_friends = [friend for friend in friends_list if friend['name'] == name]
    if found_friends:
        for idx, friend in enumerate(found_friends, 1):
            print(f"{idx}. 이름: {friend['name']}, 전화번호: {friend['phone']}, 주소: {friend['address']}")
    else:
        print(f"{name}님의 정보를 찾을 수 없습니다.")

def search_by_address():
    address = input("검색할 주소를 입력하세요(00동): ")
    found_friends = [friend for friend in friends_list if friend['address'] == address]
    if found_friends:
        for idx, friend in enumerate(found_friends, 1):
            print(f"{idx}. 이름: {friend['name']}, 전화번호: {friend['phone']}, 주소: {friend['address']}")
    else:
        print(f"{address}에 거주하는 친구를 찾을 수 없습니다.")

def modify_friend():
    name = input("수정할 친구의 이름을 입력하세요: ")
    found_friends = [friend for friend in friends_list if friend['name'] == name]
    
    if found_friends:
        for idx, friend in enumerate(found_friends, 1):
            print(f"{idx}. 이름: {friend['name']}, 전화번호: {friend['phone']}, 주소: {friend['address']}")
        
        try:
            choice = int(input("수정할 친구의 번호를 선택하세요: "))
            selected_friend = found_friends[choice - 1]
            print(f"선택한 친구: {selected_friend['name']}")
            
            # 수정할 항목 선택
            field = input("수정할 항목 (name/phone/address): ").strip().lower()
            if field == "name":
                new_name = input("새 이름을 입력하세요: ")
                selected_friend['name'] = new_name
            elif field == "phone":
                new_phone = input("새 전화번호를 입력하세요: ")
                selected_friend['phone'] = new_phone
            elif field == "address":
                new_address = input("새 주소를 입력하세요: ")
                selected_friend['address'] = new_address
            else:
                print("잘못된 항목입니다.")
                return
            print("친구 정보가 수정되었습니다.")
        except (ValueError, IndexError):
            print("잘못된 선택입니다.")
    else:
        print(f"{name}님의 정보를 찾을 수 없습니다.")

def delete_friend():
    name = input("삭제할 친구의 이름을 입력하세요: ")
    found_friends = [friend for friend in friends_list if friend['name'] == name]
    
    if found_friends:
        for idx, friend in enumerate(found_friends, 1):
            print(f"{idx}. 이름: {friend['name']}, 전화번호: {friend['phone']}, 주소: {friend['address']}")
        
        try:
            choice = int(input("삭제할 친구의 번호를 선택하세요: "))
            selected_friend = found_friends[choice - 1]
            friends_list.remove(selected_friend)
            print(f"{selected_friend['name']}님의 정보가 삭제되었습니다.")
        except (ValueError, IndexError):
            print("잘못된 선택입니다.")
    else:
        print(f"{name}님의 정보를 찾을 수 없습니다.")

def print_all_friends():
    if friends_list:
        print("\n--- 전체 친구 목록 ---")
        for idx, friend in enumerate(friends_list, 1):
            print(f"{idx}. 이름: {friend['name']}, 전화번호: {friend['phone']}, 주소: {friend['address']}")
    else:
        print("친구 목록이 비어 있습니다.")

# 메뉴 출력 함수
def print_menu():
    print("\n--- 친구 관리 프로그램 ---")
    print("1. 신규 친구 입력")
    print("2. 이름으로 검색하기")
    print("3. 주소로 검색하기")
    print("4. 이름으로 내용 수정하기")
    print("5. 이름으로 삭제하기")
    print("6. 전체 친구 출력하기")
    print("7. 프로그램 종료")

# 메인 프로그램
def main():
    while True:
        print_menu()
        choice = input("원하는 메뉴 번호를 입력하세요: ")

        if choice == "1":
            add_friend()
        elif choice == "2":
            search_by_name()
        elif choice == "3":
            search_by_address()
        elif choice == "4":
            modify_friend()
        elif choice == "5":
            delete_friend()
        elif choice == "6":
            print_all_friends()
        elif choice == "7":
            print("프로그램을 종료합니다.")
            break
        else:
            print("잘못된 입력입니다. 다시 시도하세요.")

if __name__ == "__main__":
    main()
