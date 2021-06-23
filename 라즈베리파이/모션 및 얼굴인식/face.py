# -*- coding: utf-8 -*-
import pymysql
import ntplib
import time
import cv2
import numpy as np
from datetime import datetime,timedelta
from Adafruit_IO import Client

#store_id is necessary!!!!
store_id=11

time.sleep(10)
while True:
    print(".")
    try:
        conn = pymysql.connect(
            user='lyc',
            passwd='....',
            host='database-1.cshxrgoa1y2b.ap-northeast-2.rds.amazonaws.com',
            db='db',
            charset='utf8'
        )
        cursor = conn.cursor()
        break
    except:
        continue




ADAFRUIT_IO_KEY = '....'
ADAFRUIT_IO_USERNAME = 'whfwkr16'
aio = Client(ADAFRUIT_IO_USERNAME, ADAFRUIT_IO_KEY)

def getCurTime(): # get time from NTP #인터넷 시간
    timeServer = 'time.windows.com'
    c = ntplib.NTPClient()
    response = c.request(timeServer, version=3)
    a=response.tx_time
    return time.localtime(a)

def sendToAio(tm,people):
    try:
        if tm.tm_sec%5==0:
            aio.send("people",people)
    except:
        return

def sendSql(sql): #send SQL QUERY
    cursor.execute(sql)
    conn.commit()
    return cursor.fetchall()

def sendToDB(tm, people):
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
    # Adafruit IO로 보내기
    sendToAio(tm, people)


def motionCheck(diff_cnt):
    #모션인식 민감도
    max_diff = 5
    if diff_cnt > max_diff:  # detect motion
        return 1
    else:
        return 0


def motion(motion_check):
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
            if motion_check != tmp:
                return tmp

            a = b
            b = c

    return motion_check

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
        print("첫번째")
        motion_check = motion(0)
        print(motion_check)
        if motion_check == 1:
            time.sleep(0.5)
            faces = detectFace()
            print("얼굴인식완료",faces)
            if faces == 0:
                continue
            else:
                people = people + faces
                start = time.time()
                while time.time() - start < 10:
                    print(time.time() - start)
                    if motion(0) == 1:
                        start = time.time()
                    sendData(people)
                    print("데이터 전송",people)
                    tm = getCurTime()
                    print(tm)
                    if tm.tm_sec % 30 == 0 or tm.tm_sec % 30 == 1:
                        people = 0
                        break
        else:
            sendData(people)
            print("데이터 전송",people)
            tm = getCurTime()
            print(tm)
            if tm.tm_sec % 30 == 0 or tm.tm_sec % 30 == 1: people = 0

        # ESC눌리면 종료
        if cv2.waitKey(1) & 0xFF == 27: break

main()