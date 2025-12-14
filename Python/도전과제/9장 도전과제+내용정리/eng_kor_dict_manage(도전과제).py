'''
- 메뉴: 1. 영어/한글 단어 뜻 검색 2. 단어 등록 3. 단어 삭제 4. 종료:
- 1번, 3번 메뉴 선택 후 "없는 단어" 에러 체크
- 2번 메뉴 선택 후 "있는 단어" 에러 체크
- 단어 등록 시 영어 단어이면 한글 뜻, 한글 단어이면 영문 뜻 입력하면 됨
- 조회, 등록, 삭제 기능: 한글, 영문 상관없이 단어 입력 가능
- 추가 요구사항 -->  전체 영어 단어: 한글 뜻 출력, 또는 한글단어: 영어단어 출력 되는 메뉴 추가
'''

dict = {} # {영어단어:한글뜻.....}

# 사용자가 한/영 중 어떤 단어로 입력하였는지 확인하는 함수
def word_check():
    str = input("단어 입력: ")
    if str in sorted(dict.keys()):
        return 0, str       # 영어 단어
    elif str in dict.values():
        return 1, str       # 한글 단어
    else:
        return -1, str      # 없는 단어

# 사용자로부터 단어와 뜻을 받아들여 값을 저장 하는 함수
def insert_word(flag, str):
    value = input("단어 뜻 입력: ")
    if flag == 0: #영어 키
        dict[str] = value
    else:
        dict[value] = str
    print(f" {str} 등록 완료")

# 사용자로부터 값을 받아와 해당 데이터를 삭제하는 함수
def delete_word(flag, str) :
    if flag == 0: #영어 단어이므로 해당 영어단어를 키로 하는 항목 삭제
        dict.pop(str)
    else: # 한글이므로 한글을 값으로 하는 영어 단어 찾아 내어 삭제
        for key in sorted(dict.keys()):
            if dict[key] == str:
                dict.pop(key)
    print(f" {str} 삭제 완료")

# 한/영 중 사용자가 입력한 단어의 한글 뜻, 혹은 영어 뜻을 출력해주는 함수
def find_word(flag, str) :
    if flag == 0 : #영어단어이므로 해당 영어단어를 키로 하는 항목 조회
        print(f"{str}의 뜻은 {dict[str]}입니다")
    else: # 한글이므로 한글을 값으로 하는 영어 단어 찾아 내어 조회
        for key in sorted(dict.keys()):
            if dict[key] == str:
                print(f" {str}의 뜻은 {key}입니다")

# 전체 단어를 조회해주는 함수 
def all_find_word():
    print(dict)
    

if __name__ == '__main__':
    while True:
        n = int(input("1. 영어/한글 단어 뜻 검색 2. 단어 등록 3. 단어 삭제 4. 전체 단어 조회 5. 종료: "))
        if n == 5:
            print("프로그램 종료")
            break
        
        if n == 4:
            all_find_word();
            continue

        if n not in [1,2,3,4]:
            print("메뉴선택은 1~4 사이로 해주세요")
            continue

        flag, str = 0, ""
        flag, str = word_check() # -1: 없는 단어 , 0: 영단어, 1: 한글단어

        if flag != -1 and n == 2: #있는 단어 & 등록 --> 에러체크
            print(f"{str}은 등록된 단어 입니다")
            continue
        
        elif flag == -1 and n == 2: # 없는 단어 & 등록
            insert_word(flag, str)
            
        elif flag == -1 and n !=2: #없는 단어 & 조회,삭제 --> 에러체크
            print("없는 단어")
            continue
        
        elif flag != -1 and n == 3: #있는 단어 & 삭제
            delete_word(flag,str)
            
        elif flag != -1 and n == 1: #있는단어 & 조회
            find_word(flag,str)
        
