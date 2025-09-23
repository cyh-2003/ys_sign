import json
import time
import os
import urllib.request
import urllib.parse

path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "data.json")
data = json.loads(open(path, "r").read())


def sign(url, headers, json):
    data = urllib.parse.urlencode(json).encode("utf-8")
    req = urllib.request.Request(url, headers=headers, data=data, method="POST")
    response = urllib.request.urlopen(req)
    result = response.read().decode("utf-8")
    print(result)
    response.close()


if data["miHoYo_cookie"] != "" and data["miHoYo_uid"] != "":
    print("开始米游社签到")
    url = "https://api-takumi.mihoyo.com/event/luna/hk4e/sign"
    headers = {
        "User-Agent": f"Mozilla/5.0 (Linux; Android 12) Mobile miHoYoBBS/{data['miHoYo_ua_version']}",
        "x-rpc-signgame": "hk4e",
        "Referer": "https://act.mihoyo.com/",
        "Cookie": data["miHoYo_cookie"],
    }
    json = {
        "act_id": "e202311201442471",
        "region": "cn_gf01",
        "uid": data["miHoYo_uid"],
        "lang": "zh-cn",
    }

    sign(url, headers, json)

if data["HoYoLAB_cookie"] != "":
    print("开始HoYoLAB签到")
    url = "https://sg-hk4e-api.hoyolab.com/event/sol/sign?lang=zh-cn"
    headers = {
        "User-Agent": f"Mozilla/5.0 (Linux; Android 12) Mobile miHoYoBBSOversea/{data['HoYoLAB_ua_version']}",
        "Referer": "https://act.hoyolab.com/",
        "Cookie": data["HoYoLAB_cookie"],
    }
    json = {"act_id": "e202102251931481"}

    sign(url, headers, json)


print("签到完成")
time.sleep(2)
