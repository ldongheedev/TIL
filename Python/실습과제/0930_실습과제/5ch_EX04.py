# 학생 시험 점수에 따른 학점 출력하기

score = int(input("시험 점수를 입력하시오 : ")) # score 변수에 점수를 저장하기

if score >= 90 : # 점수가 90점 이상이라면 A학점이라고 출력하는 코드
    print("A 학점 입니다.")
elif score >=80 :
    print("B 학점 입니다.")
elif score >=70 :
    print("C 학점 입니다.")
elif score >=60 :
    print("D 학점 입니다.")
else :
    print("F 학점 입니다.")
