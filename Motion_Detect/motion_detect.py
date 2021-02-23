import pymysql
import ntplib
import time
import cv2
import numpy as np

# Store Id is necessary!!!!! 
store_id = 22

def sendSql(cursor,sql):
    cursor.execute(sql)
    conn.commit()
    return cursor.fetchall()

def getTime():
    timeServer = 'time.windows.com'
    c = ntplib.NTPClient()
    response = c.request(timeServer, version=3)
    a=response.tx_time
    return time.localtime(a)
    # str(tm.tm_year)+'-'+str(tm.tm_mon)+'-'+str(tm.tm_mday)+' '+str(tm.tm_hour)+':'+str(tm.tm_min)+':'+str(tm.tm_sec)

def motion(cursor):
    thresh = 25
    max_diff = 5
    motion_check = 1
    had_motion=1
    start=0
    a, b, c = None, None, None

    cap = cv2.VideoCapture(0)
    cap.set(cv2.CAP_PROP_FRAME_WIDTH, 480)
    cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 320)

    if cap.isOpened():
        ret, a = cap.read()
        ret, b = cap.read()
        while ret:
            ret, c = cap.read()
            draw = c.copy()
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
            if diff_cnt > max_diff: #detect motion
                nzero = np.nonzero(diff)
                cv2.rectangle(draw, (min(nzero[1]), min(nzero[0])),
                              (max(nzero[1]), max(nzero[0])), (0, 255, 0), 2)
                cv2.putText(draw, "Motion detected!!", (10, 30),
                            cv2.FONT_HERSHEY_DUPLEX, 0.5, (0, 0, 255))
                had_motion = 1
                motion_check = 1


            else: #motion detect X
                if had_motion == 1: #first time, no motion
                    start = time.time()
                    had_motion=0
                else: #not first time,no motion
                    if (time.time()-start)>30: #more than 30 seconds with no motion
                        motion_check = 0 #variable which mean more than 30 seconds with no motion
                    else:
                        motion_check=1
            # send SQL
            try:
                tm = getTime()
                if tm.tm_min%1==0 and tm.tm_sec==0:
                    if motion_check ==1: #no motion in 5 minutes
                        sql = 'insert into Env (datetime, store_id,people) values(\''+str(tm.tm_year)+'-'+str(tm.tm_mon)+'-'+str(tm.tm_mday)+' '+str(tm.tm_hour)+':'+str(tm.tm_min)+':'+str(tm.tm_sec)+'\',22,1)'
                        sendSql(cursor,sql)
                    else: # motion in 5 minutes
                        sql = 'insert into Env (datetime, store_id,people) values(\''+str(tm.tm_year)+'-'+str(tm.tm_mon)+'-'+str(tm.tm_mday)+' '+str(tm.tm_hour)+':'+str(tm.tm_min)+':'+str(tm.tm_sec)+'\',22,0)'
                        sendSql(cursor,sql)
            except:
                continue

                
                
                
            stacked = np.hstack((draw, cv2.cvtColor(diff, cv2.COLOR_GRAY2BGR)))
            cv2.imshow('motion', stacked)

            a = b
            b = c

            if cv2.waitKey(1) & 0xFF == 27:
                break    
    
#main__    
conn = pymysql.connect(
    user='lyc',
    passwd='lee',
    host='database-1.cshxrgoa1y2b.ap-northeast-2.rds.amazonaws.com',
    db='db',
    charset='utf8'
)
cursor = conn.cursor()

motion(cursor)