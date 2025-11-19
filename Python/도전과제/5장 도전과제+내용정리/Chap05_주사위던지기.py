#5장 주사던지기 게임

import random as r

dice = r.randrange(6)

print(f"주사위:{dice+1}")
if dice == 0:
    print("주사위의 숫자는 1입니다.")
elif dice == 1:
    print("주사위의 숫자는 2입니다.")
elif dice == 2:
    print("주사위의 숫자는 3입니다.")
elif dice == 3:
    print("주사위의 숫자는 4입니다.")
elif dice == 4:
    print("주사위의 숫자는 5입니다.")
else:
    print("주사위의 숫자는 6입니다.")
