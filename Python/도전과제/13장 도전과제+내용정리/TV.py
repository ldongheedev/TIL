'''
연습문제 2번 TV클래스 정의하고 1개 TV객체 만들기.
사용자에게 메뉴를 보여주고 입력된 메뉴에 따라
TV조작하기(TV켜기, 끄기, 채널변경, 볼륨변경)
'''

class TV: # TV라는 클래스 만듦
    def __init__(self): # 기본값을 담을 수 있는 init 함수 선언한
        self.channel = 1 # 채널의 기본 값을 1
        self.volume = 0 # 볼륨의 기본 값을 0으로 설정
        self.on = False # 티비의 켜짐/꺼짐 상태 (False = 꺼짐)

    def turnOn(self): # 티비켜는 함수 선언
        self.on = True # 티비 켜짐

    def turnOff(self): # 티비 끄는 함수 선언
        self.on = False # 티비 꺼짐

    def setVolume(self, volume): # 볼륨조절 함수
        self.volume = volume

    def setChannel(self, channel): # 채널 조정 함수
        self.channel = channel


tvs = TV() # TV 클래스를 이용해 tvs 객체를 생성함

TV_condition = True # 티비의 실행 여부를 물어보는 while문을 실행함

while TV_condition:
    TV_ON_OFF = int(input("1: TV켜기, 2: TV끄기: ")) # 티비를 끌지 켤지를 고름
    if TV_ON_OFF not in [1,2]: # 외의 것을 고르면 다시 고르도록 유도함
        print("1~2번의 메뉴만 골라주세요")
        continue
    
    if TV_ON_OFF == 1: # 1번을 고르면 티비가 켜지면서 TV_ON while문으로 들어감
        tvs.turnOn()
        print("티비가 켜졌습니다.")
        TV_ON = True

    elif TV_ON_OFF == 2: # while문을 빠져나가고 티비가 꺼짐
        tvs.turnOff()
        print("티비가 꺼졌습니다.")
        TV_ON = False
        TV_condition = False
    # 채널과 볼륨의 초기값을 설정함    
    select_channel = 1
    select_volume = 0
    
    while TV_ON: # 티비를 켰을 때
        # 메뉴얼을 보여줌
        select_user = int(input("1: TV끄기, 2: 채널변경, 3: 볼륨변경, 4:현재볼륨 및 채널 보기: "))
        
        if select_user not in [1,2,3,4]: # 외의것을 고르면 다시 고르도록 유도함
            print("1~4번의 메뉴만 골라주세요.")
            
        if select_user == 1: # 티비끄기를 골라서 티비가 꺼짐
            TV_ON = False
            TV_condition = False
            print("티비가 꺼졌습니다.")
            
        elif select_user == 2: #채널변경을 고름
            select_channel = int(input("변경할 채널의 번호를 입력: ")) # 채널번호를 입력 받음
            tvs.setChannel(select_channel) # 입력 받은 번호를 채널값에 저장함
            print(f"티비의 채널이 {tvs.channel}(으)로 변경 되었습니다.") # 변경된 채널 번호를 보여줌
            
        elif select_user == 3: # 볼륨을 조절함
            select_volume = int(input("변경할 볼륨의 강도 입력: ")) # 볼륨크기를 입력 받음
            tvs.setVolume(select_volume) # 입력 받은 볼륨의 크기를 저장함
            print(f"티비의 볼륨이 {tvs.volume}(으)로 변경 되었습니다.") # 변경된 볼륨의 크기를 보여줌
            
        elif select_user == 4: # 설정된 볼륨과 채널을 보여줌
            print(f"현재 채널: {tvs.channel}, 볼륨: {tvs.volume}")
            
