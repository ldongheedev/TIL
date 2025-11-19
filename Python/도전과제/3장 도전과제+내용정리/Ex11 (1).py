#시간 모듈을 불러옴
import time

#1970년 이후 흘러온 초가 실수로 반환 됨
fseconds = time.time()
total_sec = int(fseconds)

# 흘러온 초를 분으로 바꾸고, 현재 몇분인지 계산
total_min = total_sec // 60
minute = total_min % 60

# 흘러온 분을 시간으로 바꾸고, 현재 몇시인지 계산
total_hour = total_min // 60
hour = total_hour % 24

print("현재 시간 (영국 그리니치 시각) : " + str(hour) + "시"+ str(minute) + "분")
