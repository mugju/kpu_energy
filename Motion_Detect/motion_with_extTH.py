# -*- coding: utf-8 -*-
import pymysql
import ntplib
import time
import cv2
import numpy as np
import urllib
import requests
import json
import math
import googlemaps
from requests import get
from urllib.parse import urlencode, unquote, quote_plus
from urllib.request import urlopen
from datetime import datetime,timedelta

#store_id is necessary!!!!
store_id=11

def getIP(): # 공인 ip 찾아주는 api
    print("Getting ip....")
    return get("https://api.ipify.org").text

def getLoc(ip): #ip기반으로 주소, 경도, 위도 찾는 api
    print("Getting lan, lng....")
    request = "https://geo.ipify.org/api/v1?apiKey=at_UeB7YHQ9B3y7yxUgsSBbTqjw2Rc3Z&ipAddress="+ip
    url = urlopen(request).read().decode('utf8')
    json_data = json.loads(url)
    return json_data

def getAddr(lat,lng): # 위도랑 경도 기반으로 배열로 주소 알려줌 *일단 안씀, 나중에
    admin_level=''
    locality=''
    sublocal1=''
    sublocal2=''
    arr=[]
    gmaps = googlemaps.Client(key='AIzaSyDOHJ5O17vrctc-lei_67TGf5lfiQ5SeRg')
    addr = gmaps.reverse_geocode((lat, lng),language='ko')
    for i in range(len(addr[0]['address_components'])):
        for j in addr[0]['address_components'][i]['types']:
            if j == 'administrative_area_level_1':
                admin_level= addr[0]['address_components'][i]['short_name']
            elif j == 'locality':
                locality = addr[0]['address_components'][i]['short_name']
            elif j == 'sublocality_level_1':
                sublocal1 = addr[0]['address_components'][i]['short_name']
            elif j == 'sublocality_level_2':
                sublocal2 = addr[0]['address_components'][i]['short_name']
                
    arr.append(admin_level)
    if locality != '':
        arr.append(locality)
    if sublocal1 != '':
        arr.append(sublocal1)
    if sublocal2 != '':
        arr.append(sublocal2)    
    return arr

def mapToGrid(lat, lon, code = 0 ): # 기상청 api로 사용가능하도록 경도 위도를 격자로 변경
    print("Changing lat, lng to Grid....")
    NX = 149            ## X축 격자점 수
    NY = 253            ## Y축 격자점 수

    Re = 6371.00877     ##  지도반경
    grid = 5.0          ##  격자간격 (km)
    slat1 = 30.0        ##  표준위도 1
    slat2 = 60.0        ##  표준위도 2
    olon = 126.0        ##  기준점 경도
    olat = 38.0         ##  기준점 위도
    xo = 210 / grid     ##  기준점 X좌표
    yo = 675 / grid     ##  기준점 Y좌표
    PI = math.asin(1.0) * 2.0
    DEGRAD = PI/ 180.0
    RADDEG = 180.0 / PI


    re = Re / grid
    slat1 = slat1 * DEGRAD
    slat2 = slat2 * DEGRAD
    olon = olon * DEGRAD
    olat = olat * DEGRAD

    sn = math.tan(PI * 0.25 + slat2 * 0.5) / math.tan(PI * 0.25 + slat1 * 0.5)
    sn = math.log(math.cos(slat1) / math.cos(slat2)) / math.log(sn)
    sf = math.tan(PI * 0.25 + slat1 * 0.5)
    sf = math.pow(sf, sn) * math.cos(slat1) / sn
    ro = math.tan(PI * 0.25 + olat * 0.5)
    ro = re * sf / math.pow(ro, sn)
    
    
    
    ra = math.tan(PI * 0.25 + lat * DEGRAD * 0.5)
    ra = re * sf / pow(ra, sn)
    theta = lon * DEGRAD - olon
    if theta > PI :
        theta -= 2.0 * PI
    if theta < -PI :
        theta += 2.0 * PI
    theta *= sn
    x = (ra * math.sin(theta)) + xo
    y = (ro - ra * math.cos(theta)) + yo
    x = int(x + 1.5)
    y = int(y + 1.5)
    return x, y

def getCurTime(): # get time from NTP #인터넷 시간
    timeServer = 'time.windows.com'
    c = ntplib.NTPClient()
    response = c.request(timeServer, version=3)
    a=response.tx_time
    return time.localtime(a)

def getBaseTime(): #기상청 api에서 가져올 데이터의 시간(기상청 동기화시간이 40분 걸린다해서 40분뺌)
    tm = getCurTime()
    y=tm.tm_year
    m=tm.tm_mon
    d=tm.tm_mday
    h=tm.tm_hour
    mn=tm.tm_min
    s=tm.tm_sec
    base = datetime(y,m,d,h,mn,s)+timedelta(minutes=-40)
    base
    base_date = base.strftime('%Y%m%d')
    base_time = base.strftime('%H%M')
    return base_date,base_time
    
def getDHT(nx,ny): #기상청 api에서 데이터 가져옴 REH가 습도, T1H가 온도
    base_date,base_time = getBaseTime()    
    
    CallBackURL = 'http://apis.data.go.kr/1360000/VilageFcstInfoService/getUltraSrtNcst'
    params = '?' + urlencode({ 
        quote_plus("serviceKey"): "A1p0vUiD%2FeSU99PG7kAIIwmJXcA9VJJuPChc5gRjevr4XDnF852eQpbgiD5mUcfArWRi9g4vt8S%2Bheg2sFsWaA%3D%3D",                        
        quote_plus("numOfRows"): "10", 
        quote_plus("pageNo"): "1", 
        quote_plus("dataType"): "JSON", 
        quote_plus("base_date"): base_date, 
        quote_plus("base_time"): base_time, 
        quote_plus("nx"): nx, 
        quote_plus("ny"): ny 
    })
    req = urllib.request.Request(CallBackURL + unquote(params))
    response_body = urlopen(req).read()
    data = json.loads(response_body)
    for i in data['response']['body']['items']['item']:
        if i['category'] == 'REH':
            humid = float(i['obsrValue'])
        elif i['category'] == 'T1H':
            tmp = float(i['obsrValue'])
            
    return int(tmp),int(humid)

def sendSql(cursor,sql): #send SQL QUERY
    cursor.execute(sql)
    conn.commit()
    return cursor.fetchall()

def motion_with_extDHT(cursor,nx,ny): #모션 인식하고, 온도 습도 가져와서 데베에 보내줌
    tmp=9999
    humid=9999
    thresh = 25
    max_diff = 5
    motion_check = 0
    had_motion=0
    start=time.time()
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
                    if (time.time()-start)>300: #more than 30 seconds with no motion
                        motion_check = 0 #variable which mean more than 300 seconds with no motion
    
            # send SQL
            try:
                tm = getCurTime()
            except:
                continue
            sqlTime = '\''+str(tm.tm_year)+'-'+str(tm.tm_mon)+'-'+str(tm.tm_mday)+' '+str(tm.tm_hour)+':'+str(tm.tm_min)+':00\''
            try:
                if tm.tm_min%5==0 and (tm.tm_sec==0 or tm.tm_sec==1): #확인 주기를 늘리기위해 1초 추가
                    tmp,humid = getDHT(nx,ny)
                    if motion_check ==1: #motion in 5 minutes
                        sql = 'insert into Env (datetime, store_id,ext_temp,ext_humid,people) values('+sqlTime+','+str(store_id)+','+str(tmp)+','+str(humid)+',1)'
                        sendSql(cursor,sql)
                    else: # no motion in 5 minutes
                        sql = 'insert into Env (datetime, store_id,ext_temp,ext_humid,people) values('+sqlTime+','+str(store_id)+','+str(tmp)+','+str(humid)+',0)'
                        sendSql(cursor,sql)
            except:
                if motion_check ==1: #motion in 5 minutes
                    sql = 'update Env set ext_temp='+str(tmp)+',ext_humid='+str(humid)+', people=1 where store_id ='+str(store_id)+' and datetime='+sqlTime
                    sendSql(cursor,sql)
                else: # no motion in 5 minutes
                    sql = 'update Env set ext_temp='+str(tmp)+',ext_humid='+str(humid)+', people=0 where store_id ='+str(store_id)+' and datetime='+sqlTime
                    sendSql(cursor,sql)

            stacked = np.hstack((draw, cv2.cvtColor(diff, cv2.COLOR_GRAY2BGR)))
            cv2.imshow('motion', stacked)

            a = b
            b = c

            if cv2.waitKey(1) & 0xFF == 27:
                break    

#main------------------------------------------------------------------
conn = pymysql.connect(
    user='lyc',
    passwd='lee',
    host='database-1.cshxrgoa1y2b.ap-northeast-2.rds.amazonaws.com',
    db='db',
    charset='utf8'
)
cursor = conn.cursor()

ip = getIP()
loc = getLoc(ip)
lat = loc['location']['lat']
lng=loc['location']['lng']
nx,ny = mapToGrid(lat,lng)
addr=getAddr(lat,lng)  

motion_with_extDHT(cursor,nx,ny)