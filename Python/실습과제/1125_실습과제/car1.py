#객체지향 이용해서 자동차 움직이기

from turtle import *
import random as r

class Car:
    def __init__(self, speed, color, model):
        self.speed = speed
        self.color = color
        self.turtle = Turtle()
        self.turtle.shape("car1.gif")

    def drive(self):
        self.turtle.forward(self.speed)

    def left_turn(self):
        self.turtle.left(r.randint(60, 180))

register_shape("car1.gif")
myCar = Car(200, "red", "E-class")
for i in range(100):
    myCar.drive()
    myCar.left_turn()
