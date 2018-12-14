package com.cn;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.concurrent.CopyOnWriteArraySet;

@ServerEndpoint("/testweb")
public class TestSocket {
    private static CopyOnWriteArraySet<TestSocket> websocket = new CopyOnWriteArraySet<TestSocket>();
    private  Session session;

    @OnClose
    public void onclose(){
        websocket.remove(this);
    }
    @OnError
    public void onerror(Session session,Throwable throwable){
        System.out.println("产生异常..");
        throwable.printStackTrace();
    }

    @OnMessage
    public void  Message(String message,Session session){
        System.out.println("信息内容:"+message);
        for (TestSocket item : websocket) {
            try {
                item.sendMessage(message,session);
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
                continue;
            }
        }
    }

    @OnOpen
    public void onopen(Session session){
        this.session=session;
        websocket.add(this);
    }

    public void sendMessage(String message,Session session) throws IOException {
        this.session.getBasicRemote().sendText(message);
    }

}