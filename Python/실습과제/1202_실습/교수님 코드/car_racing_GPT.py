import turtle
import random
import time

# ----------------------------
# Car 클래스 정의
# ----------------------------
class Car:
    def __init__(self, name, image, start_x, start_y):
        self.name = name
        self.t = turtle.Turtle()
        self.t.penup()
        self.t.goto(start_x, start_y)
        self.t.shape(image)
        self.t.speed(0)
        self.finish_time = None

    def move(self):
        """자동차를 랜덤 속도로 전진"""
        step = random.randint(2, 10)
        self.t.forward(step)

    def mark_rank(self, rank):
        """결승선 통과 후 자동차 옆에 순위 출력"""
        self.t.write(f"  {rank}위", font=("Arial", 14, "bold"))


# ----------------------------
# Race 클래스 정의
# ----------------------------
class Race:
    def __init__(self, car_image_path, num_cars=5):
        self.screen = turtle.Screen()
        self.screen.title("Turtle Car Racing (OOP Version)")
        self.screen.setup(width=900, height=600)

        # 자동차 이미지 등록
        turtle.register_shape(car_image_path)

        self.cars = []
        self.finish_line = 350
        self.create_cars(car_image_path, num_cars)

    def create_cars(self, car_image_path, num_cars):
        start_x = -350
        start_y = 150
        gap = 70

        for i in range(num_cars):
            car = Car(
                name=f"Car{i+1}",
                image=car_image_path,
                start_x=start_x,
                start_y=start_y - i * gap
            )
            self.cars.append(car)

    def draw_finish_line(self):
        """결승선 그리기"""
        t = turtle.Turtle()
        t.hideturtle()
        t.penup()
        t.goto(self.finish_line, 250)
        t.pendown()
        t.right(90)
        t.pensize(3)
        for _ in range(25):
            t.forward(10)
            t.penup()
            t.forward(10)
            t.pendown()

    def start_race(self):
        """경주 시작"""
        running = True
        rank = 1
        finished = []

        self.draw_finish_line()

        while running:
            for car in self.cars:
                if car not in finished:
                    car.move()

                    # 결승선을 통과한 경우
                    if car.t.xcor() >= self.finish_line:
                        car.mark_rank(rank)
                        finished.append(car)
                        rank += 1

                if len(finished) == len(self.cars):
                    running = False

        turtle.done()


# ----------------------------
# 실행부
# ----------------------------
if __name__ == "__main__":
    race = Race("car2.gif", num_cars=5)
    race.start_race()
