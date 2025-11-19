def countVowel(string):
    count = 0
    for ch in string:
        if ch in ['a','e','i','o','u']:
            count += 1
    return count

s= input("문자열을 입력하시오: ")
n=countVowel(s)
print (f"모음의 개수는 {n}개입니다.")

def countVowel(string):
    count = 0
    for ch in string:
        if ch not in ['a','e','i','o','u']:
            count += 1            
    return count

s= input("문자열을 입력하시오: ")
n=countVowel(s)
print (f"모음의 개수는 {n}개입니다.")