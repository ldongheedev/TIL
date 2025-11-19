from gtts import gTTS
import os

text = "안녕하세요, 2학년 여러분. 우리 모두 성공합시다."

tts = gTTS(text = text, lang = 'ko')
tts.save("ttt.mp3")
os.system("ttt.mp3")
