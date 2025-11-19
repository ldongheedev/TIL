#구구단 2~9단까지 출력하기

print("구구단 출력")

# 단 제목 출력
for j in range(2, 10):
    print(f"{j}단", end="\t")
print()  # 줄 바꿈

# 각 곱셈 결과를 가로로 정렬
for i in range(1, 10):
    for j in range(2, 10):
        print(f"{j}*{i}={j*i}", end="\t")
    print()  




