# 교재 연습문제 04번
# 점수를 입력 받아 각 점수에 대한 학점 매기기
score = int(input("점수를 입력하시오: "))


if score >= 90: # 90점 이상이면
    print("A학점입니다.")

elif score >= 80: # 90점 미만 80점 이상이면
    print("B학점입니다.")

elif score >= 70: # 80점 미만 70점 이상이면
    print("C학점입니다.")

elif score >= 60: # 70점 미만 60점 이상이면
    print("D학점입니다.")

else: # 60점 미만이면
    print("F학점입니다.")
