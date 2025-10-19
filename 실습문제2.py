# 학생 정보를 저장할 리스트 선언함
stu_list = []

# 3명 학생의 이름과 점수를 입력받아 리스트에 저장
for i in range(1, 4):
    name = input(f"{i}번 학생의 이름 입력: ")
    kor = int(input(f"{i}번 학생의 국어점수 입력: "))
    eng = int(input(f"{i}번 학생의 영어점수 입력: "))
    math = int(input(f"{i}번 학생의 수학점수 입력: "))
    stu_list.append([name, kor, eng, math])  # 중첩리스트로 저장

# 과목별 총점을 저장할 변수 초기화
total_kor = total_eng = total_math = 0

# 학생별 총점과 평균을 저장할 리스트 선언
stu_sum_list = []
stu_avg_list = []

# 학생별 점수를 반복하며 총점과 평균 계산
for name, kor, eng, math in stu_list:
    total_kor += kor  # 국어 총점 누적
    total_eng += eng  # 영어 총점 누적
    total_math += math  # 수학 총점 누적

    stu_sum = kor + eng + math  # 학생 총점 계산
    stu_avg = round(stu_sum / 3, 1)  # 평균 계산하고 소수점 1자리로 반올림

    stu_sum_list.append(stu_sum)  # 총점 리스트에 저장
    stu_avg_list.append(stu_avg)  # 평균 리스트에 저장

# 성적표 머릿말 출력함
print("성명\t국어\t영어\t수학\t총점\t평균")

# 학생별 성적 출력함
for i in range(len(stu_list)):
    print(f"{stu_list[i][0]}\t{stu_list[i][1]}\t{stu_list[i][2]}\t{stu_list[i][3]}\t{stu_sum_list[i]}\t{stu_avg_list[i]}")

# 과목별 총점과 평균 출력함
print(f"\n총점/평균 = {total_kor} / {round(total_kor/3,1)} / {total_eng} / {round(total_eng/3,1)} / {total_math} / {round(total_math/3,1)}")
