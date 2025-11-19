'''
- 메뉴: 1. 영어/한글 단어 뜻 검색 2. 단어 등록 3. 단어 삭제 4. 종료:
- 1번, 3번 메뉴 선택 후 "없는 단어" 에러 체크
- 2번 메뉴 선택 후  "있는 단어" 에러 체크
- 단어 등록 시 영어 단어이면 한글 뜻, 한글 단어이면 영문 뜻 입력하면 됨
- 조회, 등록, 삭제 기능: 한글, 영문 상관없이 단어 입력가능
추가 요구 조건
-전체 영어단어: 한글 뜻 출력, 또는 한글단어: 영어단어 출력 되는 메뉴 추가

'''
dict = {} # {영어단어: 한글뜻.....}

def word_check():
    str = input("단어 입력 : ")
    if str int sorted(dict.keys()):
        return 0, str    #영어 단어
    elif str in dict.values() :
        return 1, str   #한글 단어
    else :
        return -1, str  #없는 단어

def insert_word(flad, str):
    value = input("단어 뜻 입력:")
    if flag == 0 : #영어 키
        dict[str] = value
    else:
        dict[value] = str
    print(f"{str} 등록 완료")

def delete_word(flag, str) :
    if flag == 0: #영어 단어이므로 해당 영어 단어를 키로 하는 항목 삭제
        dict.pop(str)
    else: #한글이므로 한글을 값으로 하는 영어 단어 찾아 내어 삭제
        for key in sorted(dict.keys()) :
            if dict[key] == str :
                dict.pop(key)
    print(f"{str} 삭제 완료")

def find_word(flag, str):
    if flag == 0 : # 영어 단어이므로 해당 영어 단어를 키로 하는 항목 조회
        print(f"{str}의 뜻은 {dict[str]}입니다")

    else: #한글이므로 한글을 값으로 하는 영어 단어 찾아 내어 조회
        for key in sorted(dict.keys()):
            if dict[key] == str :
                print(f"{str}의 뜻은 {key}입니다")

if __name__ = __main__ :
    while True :
        n= int(input("1. 영어/한글 단어 뜻 검색 2. 단어 등록 3. 단어 삭제 4. 종료: "))
        if n == 4:
            print("프로그램 종료")
            break

        if n not in [1, 2, 3] :
            print("메뉴선택은 1~3 사이로 해주세요")
            continue

        flag, str = 0, ""
        flag, str = word_check() # -1:없는 단어, 0: 영단어, 1:한글단어
        
