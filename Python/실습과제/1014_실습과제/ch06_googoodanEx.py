#구구단 출력하기(2단 --> 9단)
for i in range(10):
    for dan in range(2, 10) :
        if i==0:
            print(f"=={dan}단==", end=" ")
        else :
            print("%d*%d=%2d" % (dan, i, dan*i), end=" ")
    print("\n")

#구구단 출력하기(9단 --> 2단)
for i in range(10):
    for dan in range(9,1,-1) :
        if i==0:
            print(f"=={dan}단==", end=" ")
        else :
            print("%d*%d=%2d" % (dan, i, dan*i), end=" ")
    print("\n")
