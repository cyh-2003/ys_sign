## 获取米游社 Cookie

1. 打开你的浏览器,进入**无痕/隐身模式**

2. 由于米哈游修改了 bbs 可以获取的 Cookie，导致一次获取的 Cookie 缺失，所以需要增加步骤

3. 打开`https://www.miyoushe.com/ys/` 并进行登入操作

4. 按下键盘上的`F12`或右键检查,打开开发者工具,点击`Source`或`源代码`

5. 键盘按下`Ctrl+F8`或点击停用断点按钮，点击` ▌▶`解除暂停

6. 点击`NetWork`或`网络`，在`Filter`或`筛选器`里粘贴 `getUserGameUnreadCount`，同时选择`Fetch/XHR`

7. 点击一条捕获到的结果，往下拉，找到`Cookie:`

8. 复制Cookie部分除`Cookie:`的全部内容

9. 将此处的复制到的 Cookie 先粘贴到 config 文件的 Cookie 处

10. **此时 Cookie 已经获取完毕了**

## 海外版获取Cookie

1. 打开你的浏览器,进入**无痕/隐身模式**

2. 打开 `https://act.hoyolab.com/bbs/event/signin/hkrpg/index.html?act_id=e202303301540311` 并进行登入操作

3. 按下键盘上的`F12`或右键检查,打开开发者工具,在控制台输入:

    ```javascript
    document.cookie
    ```

4. 从`ltoken=....`开始复制到结尾

5. 将获取到的 Cookie 粘贴到之前获取到 OS 的 Cookie 里面

> 本文档内容属于 `某开源项目`,遵循 MIT 协议
> 
> 根据`某开源项目` 的意愿不放出 url 地址