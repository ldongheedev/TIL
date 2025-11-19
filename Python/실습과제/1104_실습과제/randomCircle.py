import turtle as t
import random as r

def Circle1(length):
    t.circle(length)


def drawit(x,y):
    t.up()
    t.goto(x, y)
    t.down()
    t.begin_fill()
    t.color(r.random(), r.random(), r.random())
    Circle1(r.randint(1, 100))
    t.end_fill()

s = t.Screen()
s.onscreenclick(drawit)

t.done()
