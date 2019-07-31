# simpleweb
skynet simpleweb for control server

一个简单的 skynet web 框架，用于在网页里控制 skynet 服务器。采用 AJAX 的 GET 和 POST 方式调用服务器命令。

## 启动

```
sh start.sh
```

## 如何增加新的功能

1. 在 `service/handler.lua` 实现功能的命令接口，支持 `GET` 和 `POST`。比如要实现开服命令:

```lua
local function syscmd(cmd)
    local popen = io.popen
    local pfile = popen(cmd)
    local ret = pfile:read('a')
    pfile:close()
    return ret
end

function CMD.post_start_server(query, header, body)
    return syscmd('make start') -- 修改为你自己的服务器开服命令即可
end
```

2. 在 `static/index.html` 新加入一个按钮

```html
<button id="start_server" class="btn btn-default" type="button">开服</button>
````

3. 在 `static/app.js` 加入 AJAX 方法

```js
    $("#start_server").click(function() {
        wait_msg()
        $.post("/start_server", {}, function(data) {
            output(data)
        })
    })
```

## 其他

项目的不同，控制台的命令实现也会不一样的，所以我只开源一个空架子。下面截图是目前公司内部使用的样子。

![截图示例](/screenshot.png)

## FAQ

Q: 为何没有权限管理？

A: 如果想用来做游戏的后台的话，权限管理很定是要加上的。因为我只是用来给策划或者测试用来操作测试服务器用的，所以就保持足够简单就行。
