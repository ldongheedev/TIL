'''
리스트를 사용하여 친구의 이름, 전화번호, 주소(00동)을 관리하는 프로그램 작성.
메뉴: 신규친구입력(동명이인 가능), 이름으로 검색하기, 주소로 검색하기, 이름으로 찾아 내용 수정하기, 이름으로 삭제하기(같은 이름 여러 개인 경우 사용자가 그중에서 골라서 삭제하기), 전체출력하기, 종료
+ 친구관리 프로그램을 객체지향 코딩으로 바꾸기, 소스에 주석달기
'''



class FriendManager: # 친구 관리 클래스를 정의
    def __init__(self): # 초기화 함수 정의
        self.friend_list = [] # 친구 정보를 담을 리스트를 초기화
    
    def insert_friend(self): # 새 친구를 등록하는 함수 정의
        name = input("이름: ") # 이름 입력받음
        phone = input("폰번호: ") # 번호 입력받음
        addr = input("주소: ") # 주소 입력받음

        self.friend_list.append([name, phone, addr]) # 입력받은 정보를 리스트에 추가함
        print("등록 완료")
    
    def search_by_name(self): # 이름으로 친구를 검색하는 함수 정의
        input_name = input("이름: ") # 검색할 이름 입력받음
        cnt = 0 # 검색된 친구 수를 0으로 초기화
        
        for name, phone, addr in self.friend_list: # 리스트의 모든 친구 정보를 반복
            if name == input_name: # 이름이 일치하는지 확인
                print(f"폰번호: {phone}, 주소: {addr}") # 폰번호와 주소를 출력
                cnt += 1 # 검색 횟수 증가
        
        if cnt == 0: # 검색된 친구가 없는 경우
            print("존재하지 않는 이름")
            return # 함수 종료

    def search_by_addr(self): # 주소로 친구를 검색하는 함수 정의
        addr = input("주소: ") # 검색할 주소 입력받음
        cnt = 0 # 검색된 친구 수를 0으로 초기화
        
        for friend_data in self.friend_list: # 리스트의 모든 친구 정보를 반복
            if friend_data[2] == addr: # 주소가 일치하는지 확인
                print(f"이름:{friend_data[0]}, 폰번호: {friend_data[1]}") # 이름과 폰번호를 출력
                cnt += 1 # 검색된 횟수 증가
                
        if cnt == 0: # 검색된 친구가 없는 경우 확인
            print("존재하지 않는 주소")
            return # 함수 종료

    def change_by_name(self): # 이름으로 친구 정보를 수정하는 함수 
        change_index = [] # 동명이인을 저장할 리스트
        name = input("이름: ") # 수정할 친구 이름 입력받음
        cnt = 0 # 검색된 친구 수 초기화
        
        for i in range(len(self.friend_list)): # 리스트 확인
            if self.friend_list[i][0] == name: # 이름이 일치하는지 확인
                print(f"{cnt+1}번 친구 폰번호: {self.friend_list[i][1]}, 주소: {self.friend_list[i][2]}") 
                change_index.append(i) # 실제 리스트 인덱스를 저장
                cnt += 1 # 검색된 횟수 증가
                
        if cnt == 0: # 검색된 친구가 없는 경우 확인
            print("존재하지 않는 이름")
            return # 함수종료

        if cnt == 1: # 친구가 한 명인 경우 확인
            index = change_index[0] # 해당 친구의 인덱스를 선택
        else: # 동명이인인 경우 확인
            while True: # 유효한 번호를 입력받을 때까지 반복
                # 숫자인지 확인 없이 바로 정수로 변환
                choice = int(input("수정할 친구 번호: ")) 
                
                if 1 <= choice <= cnt: # 입력된 번호가 유효 범위인지 확인 ( Ai활용)
                    index = change_index[choice - 1] # 실제 리스트 인덱스를 계산
                    break # 반복 종료
                else:
                    print("번호를 다시 잘 입력하세요.")
        
        self.friend_list[index][0] = input("새 이름: ") # 새 이름을 입력받아 수정
        self.friend_list[index][1] = input("새 폰번호: ") # 새 폰번호를 입력받아 수정
        self.friend_list[index][2] = input("새 주소: ") # 새 주소를 입력받아 수정
        print("수정 완료")

    def delete_by_name(self): # 이름으로 친구 정보를 삭제하는 함수 
        delete_index = [] # 동명이인을 저장할 리스트
        name = input("삭제할 이름: ")
        cnt = 0 # 검색된 친구 수 초기화
        
        for i in range(len(self.friend_list)): # 리스트를 확인
            if self.friend_list[i][0] == name: # 이름이 일치하는지 확인
                print(f"{cnt+1}번 친구 폰번호: {self.friend_list[i][1]}, 주소: {self.friend_list[i][2]}") 
                delete_index.append(i) # 실제 리스트 인덱스를 저장
                cnt += 1 # 검색된 횟수 증가
                
        if cnt == 0: # 검색된 친구가 없는 경우 확인
            print("존재하지 않는 이름")
            return # 함수 종료
        
        if cnt == 1: # 친구가 한 명인 경우 확인
            index = delete_index[0] # 해당 친구의 인덱스를 선택
        else: # 동명이인인 경우 확인
            while True: # 유효한 번호를 입력받을 때까지 반복
                choice = int(input("삭제할 친구 번호: "))
                
                if 1 <= choice <= cnt: # 입력된 번호가 유효 범위인지 확인 (AI를 활용)
                    index = delete_index[choice - 1] # 실제 리스트 인덱스를 계산
                    break # 반복 종료
                else:
                    print("번호를 다시 잘 입력하세요.")

        del self.friend_list[index] # 해당 인덱스의 친구 정보를 리스트에서 제거
        print("삭제 완료")
        
    def all_friend_print(self): # 전체 친구 정보를 출력하는 함수 정의
        if not self.friend_list: # 리스트가 비어있는지 확인
            print("등록된 친구 없음")
            return # 함수 종료

        for i in self.friend_list: # 리스트의 모든 친구 정보를 순서대로 반복
            print(f"이름: {i[0]:<7} 폰번호: {i[1]:<15} 주소: {i[2]}") 
        
        print(f"총 {len(self.friend_list)}명 등록")


# 파이썬에는 main()함수가 없어도 상관없음. 그래서 여기서부터 실행문이
# 실행된다는 관용구를 써서 프로그램 가독성을 높임
if __name__ == '__main__':
     manager = FriendManager() # FriendManager 클래스의 객체를 생성

    # 메뉴 메세지
     msg = "1.새친구등록(동명이인 가능), 2. 이름으로 검색하기, 3. 주소로 검색하기 4. 이름으로 찾아 내용수정하기, 5. 이름으로 삭제하기 6.전체 출력, 7.종료: "

     while True: # 메뉴 시작
          n = int(input(f"{msg}")) # 메뉴 번호 선택
          
          if n == 1: #
               manager.insert_friend() # 친구 등록 함수를 호출
          elif n == 2: 
               manager.search_by_name() # 이름 검색 함수를 호출
          elif n == 3: 
               manager.search_by_addr() # 주소 검색 함수를 호출
          elif n == 4: 
               manager.change_by_name() # 정보 수정 함수를 호출
          elif n == 5: 
               manager.delete_by_name() # 친구 삭제 함수를 호출
          elif n == 6: 
               manager.all_friend_print() # 전체 출력 함수를 호출
          elif n == 7: 
               print("프로그램 종료") # 종료 메시지를 출력
               break # 루프 탈출
          else:
               print("1~7 중에서 선택하세요.") # 다시 선택
