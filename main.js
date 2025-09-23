import data from './data.json' with { type: 'json' }

let url, headers, body
if (data['miHoYo_cookie'] != '' && data['miHoYo_uid'] != '') {
    console.log('开始米游社签到')
    url = ' '
    headers = {
        'User-Agent': `Mozilla/5.0 (Linux; Android 12) Mobile miHoYoBBS/${data['miHoYo_ua_version']}`,
        "x-rpc-signgame": "hk4e",
        "Referer": "https://act.mihoyo.com/",
        "Cookie": data['miHoYo_cookie']
    }
    body = {
        "act_id": "e202311201442471",
        "region": "cn_gf01",
        "uid": data['miHoYo_uid'],
        "lang": "zh-cn"
    }
    sign(url, headers, body)
}

if (data['HoYoLAB_cookie'] != '') {
    console.log('开始HoYoLAB签到')
    url = 'https://sg-hk4e-api.hoyolab.com/event/sol/sign?lang=zh-cn'
    headers = {
        'User-Agent': `Mozilla/5.0 (Linux; Android 12) Mobile miHoYoBBSOversea/${data['HoYoLAB_ua_version']}`,
        'Referer': "https://act.hoyolab.com/",
        'Cookie': data['HoYoLAB_cookie']
    }
    body = { 'act_id': 'e202102251931481' }
    sign(url, headers, body)
}

console.log('签到完成,2秒后退出程序')

setTimeout(() => {
    process.exit()
}, 2000)

async function sign(url, headers, body) {
    let res = await fetch(url, {
        method: 'POST',
        headers: headers,
        body: JSON.stringify(body)
    }).then(res => res.json())
    console.log(res)
}