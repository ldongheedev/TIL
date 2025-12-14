from turtle import *
import random as r

class Car:
    def __init__(self, speed, color, fname):
        self.speed = speed
        self.color = color
        self.turtle = Turtle()
        self.turtle.shape(fname)
        self.turtle.speed(self.speed)


    def drive(self, distance):
        self.turtle.forward(distance)

    def turnleft(self, degree):
        self.turtle.left(degree)

register_shape("car2.gif")

car_list = []
for _ in range(10):
    car_list.append(Car(r.randint(1,10), "red", "car2.gif"))

for _ in range(10):
    for car in car_list:
        car.drive(r.randint(50, 100))
        car.turnleft(r.choice([0, 90, 180, 270]))
