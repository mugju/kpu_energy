# -*- coding: utf-8 -*-
import pymysql
import ntplib
import time
import cv2
import paho.mqtt.client as mqtt
from rpi_ws281x import *
import argparse


 
# LED strip configuration:
LED_COUNT      = 12      # Number of LED pixels.
LED_PIN        = 21      # GPIO pin connected to the pixels (18 uses PWM!).
LED_FREQ_HZ    = 800000  # LED signal frequency in hertz (usually 800khz)
LED_DMA        = 10      # DMA channel to use for generating signal (try 10)
LED_BRIGHTNESS = 120     # Set to 0 for darkest and 255 for brightest
LED_INVERT     = False   # True to invert the signal (when using NPN transistor level shift)
LED_CHANNEL    = 0       # set to '1' for GPIOs 13, 19, 41, 45 or 53

def on(strip):
    for i in range(strip.numPixels()):
        strip.setPixelColor(i, Color(127, 127, 127))
        strip.show()
    print("on")

def off(strip):
    for i in range(strip.numPixels()):
        strip.setPixelColor(i, Color(0,0,0))
        strip.show()
    print("off")

strip = Adafruit_NeoPixel(LED_COUNT, LED_PIN, LED_FREQ_HZ, LED_DMA, LED_INVERT, LED_BRIGHTNESS, LED_CHANNEL)

strip.begin()
on(strip)
strip.show()


client = mqtt.Client("python_pub") #Mqtt Client 오브젝트 생성
client.connect("elijah.iptime.org", 1883) #MQTT 서버에 연결

#store_id is necessary!!!!
store_id=11
prev = 0

#부팅 후 5초 기다렸다가 시작
time.sleep(5)


while True: #DB Connect
    print(".")
    try:
        conn = pymysql.connect(
            user='lyc',
            passwd='lee',
            host='database-1.cshxrgoa1y2b.ap-northeast-2.rds.amazonaws.com',
            db='db',
            charset='utf8'
        )
        cursor = conn.cursor()
        break
    except:
        continue

def getCurTime(): # get time from NTP #인터넷 시간
    while True:
        try:
            timeServer = 'time.windows.com'
            c = ntplib.NTPClient()
            response = c.request(timeServer, version=3)
            a=response.tx_time
            return time.localtime(a)
        except:
            print("시간 서버 접속 오류")
            time.sleep(1)
            continue

def sendSql(sql): #send SQL QUERY
    cursor.execute(sql)
    conn.commit()
    return cursor.fetchall()

def sendToDB(tm, people): #insert people value and send to DB
    sqlTime = '\'' + str(tm.tm_year) + '-' + str(tm.tm_mon) + '-' + str(tm.tm_mday) + ' ' + str(tm.tm_hour) + ':' + str(
        tm.tm_min) + ':00\''
    try:
        if tm.tm_min % 5 == 0 and (tm.tm_sec >= 0 or tm.tm_sec <= 2):  # 확인 주기를 늘리기위해 2초 추가
            sql = 'insert into Env (datetime, store_id,people) values(' + sqlTime + ',' + str(store_id) + ','+ str(people)+')'
            sendSql(sql)
    except:
        return

def sendData(people):
    # 현재 인터넷 시간 불러오기
    try:
        tm = getCurTime()
    except:
        return

    # DB로 보내기
    sendToDB(tm, people)
    if people > 0: Smplug1=1
    else : Smplug1 = 0
    global prev
    if Smplug1 != prev:     
        #MQTT로 보냄
        client.publish("People",people)
        if(people>0):
            client.publish("Smplug1",Smplug1)
            on(strip)
        else:
            client.publish("Smplug1",Smplug1)
            off(strip)  
        prev = Smplug1

def motionCheck(diff_cnt):
    #모션인식 민감도
    max_diff = 50
    if diff_cnt > max_diff:  # detect motion
        return 1
    else:
        return 0


def motion():
    thresh = 25

    a, b, c = None, None, None
    cap = cv2.VideoCapture(0)
    cap.set(cv2.CAP_PROP_FRAME_WIDTH, 480)
    cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 320)

    if cap.isOpened():
        ret, a = cap.read()
        ret, b = cap.read()
        start=time.time()
        while time.time()-start < 1:
            ret, c = cap.read()
            if not ret:
                break

            a_gray = cv2.cvtColor(a, cv2.COLOR_BGR2GRAY)
            b_gray = cv2.cvtColor(b, cv2.COLOR_BGR2GRAY)
            c_gray = cv2.cvtColor(c, cv2.COLOR_BGR2GRAY)

            diff1 = cv2.absdiff(a_gray, b_gray)
            diff2 = cv2.absdiff(b_gray, c_gray)

            ret, diff1_t = cv2.threshold(diff1, thresh, 255, cv2.THRESH_BINARY)
            ret, diff2_t = cv2.threshold(diff2, thresh, 255, cv2.THRESH_BINARY)

            diff = cv2.bitwise_and(diff1_t, diff2_t)

            k = cv2.getStructuringElement(cv2.MORPH_CROSS, (3, 3))
            diff = cv2.morphologyEx(diff, cv2.MORPH_OPEN, k)

            diff_cnt = cv2.countNonZero(diff)
            tmp = motionCheck(diff_cnt)
            # 모션이 있었는지 확인
            if tmp != 0:
                return tmp

            a = b
            b = c

    return 0

def detectFace():
    faceCascade = cv2.CascadeClassifier('frontalface.xml')
    cap = cv2.VideoCapture(0)
    cap.set(3,640) # set Width
    cap.set(4,480) # set Height

    ret, img = cap.read()
    img = cv2.flip(img, -1) # 상하반전
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    faces = faceCascade.detectMultiScale(
        gray,
        scaleFactor=1.2,
        minNeighbors=5,
        minSize=(20, 20)
    )
    return len(faces)


def main():
    people=0
    while True:
        print("모션인식 확인")
        motion_check = motion()
        print(motion_check)
        #손님 없을 때 모션인식이 존재하면, 얼굴인식
        if motion_check == 1:
            time.sleep(0.5)
            faces = detectFace()
            print("얼굴인식완료",faces)
            #얼굴인식이 되지 않으면, 처음으로 모션인식
            if faces == 0:
                continue
            #얼굴인식하여 특정시간동안 사람 수 파악
            else:
                people = people + faces
                sendData(people)
                start = time.time()
                #10초 동안 모션움직임이 없으면, 손님이 없다고 판단
                while time.time() - start < 10:
                    print(time.time() - start)
                    if motion() == 1:
                        start = time.time()
                    sendData(people)
                    print("데이터 전송(손님 있을 때)",people)
                    tm = getCurTime()
                    # 원래는 5분 단위로 초기화하는데, 데모를 위해 30초로 줄임
                    if tm.tm_sec % 30 == 0 or tm.tm_sec % 30 == 1:
                        people = 0
                        break
        else:
            sendData(people)
            print("데이터 전송(손님 없을 때)",people)
            tm = getCurTime()
            #원래는 5분 단위로 초기화하는데, 데모를 위해 30초로 줄임
            if tm.tm_sec % 30 == 0 or tm.tm_sec % 30 == 1: people = 0

        # ESC눌리면 종료
        if cv2.waitKey(1) & 0xFF == 27: break

main()
