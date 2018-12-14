<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>用WebSocket实例</title>
</head>
<body>
<input id="message" type="text">
<button onclick="sendMessage()">发送</button>
<button onclick="closeSocket()">关闭</button>
<hr>
<hr>
<div id="showMessage"></div>

</body>

<script type="text/javascript">
    var websocket = null;
    //判断当前浏览器是否支持WebSocket
    if ('WebSocket' in window) {
        websocket = new WebSocket("ws://localhost:8889/maven_websocket_war/testweb");

        //连接成功建立的回调方法
        websocket.onopen = function () {
            setMessageInnerHTML("客户端链接成功..");
        }

        //接收到消息的回调方法
        websocket.onmessage = function (event) {
            setMessageInnerHTML(event.data);
        }

        //连接发生错误的回调方法
        websocket.onerror = function () {
            alert("WebSocket连接发生错误");
        };

        //连接关闭的回调方法
        websocket.onclose = function () {
            setMessageInnerHTML("WebSocket连接关闭");
        }

        //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
        window.onbeforeunload = function () {
            closeWebSocket();
        }
        
        function sendMessage() {
            var message=document.getElementById("message").value;
            websocket.send(message);
        }
        function closeSocket() {
            closeWebSocket();
        }

    }
    else {
        alert('当前浏览器不支持WebSocket..')
    }


    //将消息显示在网页上
    function setMessageInnerHTML(innerHTML) {
        document.getElementById('showMessage').innerHTML +=innerHTML+'</br>';
    }

    //关闭WebSocket连接
    function closeWebSocket() {
        websocket.close();
    }

</script>
</html>