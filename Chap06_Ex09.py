#암호를 입력받아 암호를 맞추는 프로그램

import sys as s #sys 모듈을 import하여 break문 대신 사용할 예정


user_pw = input("패스워드를 입력하시오: ") # 사용자에게 암호를 입력 받음

# 알파벳 소문자와 숫자를 각각 리스트로 저장
pwE = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
      'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't',
      'u', 'v', 'w', 'x', 'y', 'z',]
pwN = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9',]



# 중첩 for문을 이용해 가능한 모든 조합을 생성하고 비교
# 입력한 암호와 일치하면 출력 후 프로그램 종료
for let1 in pwE:
    for let2 in pwE:
        for let3 in pwE:
            for let4 in pwN:
                for let5 in pwN:
                    guess = let1+let2+let3+let4+let5
                    print(guess)
                    if guess == user_pw:
                        print("당신의 패스워드는: " +guess)
                        s.exit()
