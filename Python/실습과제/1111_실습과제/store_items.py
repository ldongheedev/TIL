# 편의점 재고 관리
# 편의점에서 재고 관리를 수행하는 프로그램을 작성해 보자.
#편의점에서 판매하는 물건의 재고를 딕셔너리에 저장한다. 

'''
items = {"커피음료":7, "펜":3, "종이컵":2, "우유":1, "콜라":4, "책":5}

item = input("물건의 이름을 입력하시오:")
print(items[item])


<편의점 물품 재고관리>

-메뉴 : 1. 신규물품 재고 등록, 2. 특정물품 재고향 증가, 3. 특정물품 재고량 감소,
        4. 특정 물품 삭제, 5. 전체 물품 출력 6. 종료
-딕셔너리 자료형 사용 : item_dict = {물품명1:재고량1, 물품명2:재고량2, ...}

-에러체크 1 : 관리하는 물품 개수는 50개를 넘을 수 없음.
-에러체크 2 : 신규물품 등록할 때 이미 등록된 물품이면 에러처리
-에러체크 3 : 재고량증가/감소, 물품 삭제 작업전에 등록된 물품인지 확인
-에러체크 4 : 재고량 감소 시 재고량이 음수가 되지 않는 지 확인

'''

#신규 물품 등록
def insert_item() :
    if len(item_dict) >= 50 :
        print("이미 등록된 재고물품이 50개 넘음!!")
        return
    while True:
        item_key = input("물품명: ")
        if item_key in item_dict.keys() :
            print("이미 있는 물품임!!")
            continue
        else :
            break
    item_dict[item_key] = int(input("재고량: "))
    print("등록완료")

#특정 물품 재고량 증가
def inc_cnt() :
    while True:
        item_key = input("물품명: ")
        if item_key not in item_dict.keys() :
            print(f"{item_key}는 없는 물품임!!")
            continue
        else :
            break
    item_dict[item_key] += int(input("재고 증가량: "))
    print("재고량 증가 완료")

# 특정물품 재고량 감소
def dec_cnt() :
    while True :
        item_key = input("물품명: ")
        if item_key not in item_dict.keys() :
            print(f"{item_key}는 없는 물품임!!")
            continue
        else:
            break
    a= int(input("재고 감소량: "))
    if item_dict[item_key] - a < 0:
        print("재고 감소량이 음수입니다.")
        return
    else:
        item_dict[item_key] -= a
        
    print("재고량 감소 완료")

#특정 물품 삭제
def delete_item() :
    while True:
        item_key = input("물품명: ")
        if item_key not in item_dict.keys() :
            print(f"{item_key}는 등록되어 있지 않은 상품입니다")
        else:
            break
    item_dict.pop(item_key)
    print("삭제완료")
    

#전체 물품 출력
def all_item_print() :
    for i in sorted(item_dict.keys()):
        print("%7s\t%5d" %(i, item_dict[i])) #물품명 재고량

# 재고량 0인 물품 출력
def zero_item_print() :
    for item in sorted(item_dict.keys()) :
        if item_dict[item] == 0 :
            print("%7s\t%5d" %(item, item_dict[item]))
    return

#전역 변수 생성
msg = "1. 물품등록 2. 재고량 증가 3. 재고량 감소 4. 물품 삭제 5. 전체물품 출력 6. 재고량이 0인 물품 7. 종료 : "
item_dict = {}

#파이썬에는 main()함수가 없어도 상관없음.
#그래서 여기서부터 실행문이 실행된다는 관용구를 써서 프로그램 가독성을 높임
if __name__ == '__main__':
    while True:
        n = int(input(msg))

        if n == 1 :
            insert_item()
        elif n == 2 :
            inc_cnt()
        elif n == 3 :
            dec_cnt()
        elif n == 4 :
            delete_item()
        elif n == 5 :
            all_item_print()
        elif n == 6 :
            zero_item_print()
        elif n == 7 :
            print("프로그램 종료\n")
            break
        else :
            print("1~6중에서 선택하세요\n")
