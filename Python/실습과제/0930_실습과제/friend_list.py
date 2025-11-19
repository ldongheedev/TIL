#사용자에게 한명의 이름과 나이와 주소를 입력받아
# friend 라는 리스트에 저장하고 화면에 출력하기


friend = []

friend.append(input("이름을 입력하시오 : "))
friend.append(int(input("나이를 입력하시오 : ")))
friend.append(input("주소를 입력하시오 : "))

print(f"이름은 {friend[0]} 이고 나이는 {friend[1]} 이고 주소는 {friend[2]} 입니다.")
