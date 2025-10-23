import random as r

select = "y"

while select == "y" or select == "Y" :
	num1 = r.randint(11, 99)
	num2 = r.randint(11, 99)

	op_list = ["+", "-", "*", "/"]
	op = r.choice(op_list)
	
	if op == "+":
		solution = num1 + num2
	elif op == "-":
		solution = num1 - num2
	elif op == "*":
		solution = num1 * num2
	else:
		solution = num1 // num2

	while True :
		quiz = str(num1) + op + str(num2) + "="
		user = int(input(quiz))
		if user == solution :
			break
		else :
			print("오답입니다.")
	
	select = input("정답입니다. 산수퀴즈를 계속할까요?")
print("프로그램을 종료합니다.")
