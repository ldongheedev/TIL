from turtle import *

class Car:
    def __init__(self, speed, color, fname):
        self.speed = speed
        self.color = color
        self.turtle = Turtle()
        self.turtle.shape(fname)


    def drive(self, distance):
        self.turtle.forward(distance)

    def left_turn(self, degree):
        self.turtle.left(degree)

register_shape("car1.gif")
register_shape("car2.gif")
myCar = Car(0, "blue", "car1.gif")
yourCar = Car(0, "red", "car2.gif")

for i in range(10):
    myCar.drive(300)
    myCar.left_turn(90)
    yourCar.drive(100)
    yourCar.left_turn(60)
