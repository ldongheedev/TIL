# 자동차가 일렬로 서서 랜덤하게 전진해서 순위 정하기

from turtle import *
import random as r

#차량 객체
class Car:
    def __init__(self, speed, color, fname, start_pos):
        self.speed = speed
        self.color = color
        self.turtle = Turtle()
        self.turtle.shape(fname)
        self.turtle.penup()
        self.turtle.goto(start_pos)
        self.turtle.speed(self.speed)

    def drive(self, distance):
        self.turtle.forward(distance)

register_shape("car2.gif")

#차량 위치지정 및 생성하기
car_list = []
starty = -200
for i in range(5):
    pos = (-300, starty + i*100) #위치 지정하기
    car_list.append(Car(r.randint(1,10), "red", "car2.gif", pos)) #리스트에 차량 추가하기

#차량 랜덤하게 전진하게 하기
for _ in range(10):
    for car in car_list:
        car.drive(r.randint(10, 100))

