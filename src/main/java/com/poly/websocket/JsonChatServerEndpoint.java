package com.poly.websocket;

import jakarta.websocket.EncodeException;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@ServerEndpoint(
    value = "/json/chat/{username}", 
    encoders = MessageEncoder.class, 
    decoders = MessageDecoder.class
)
public class JsonChatServerEndpoint {
    private static Map<String, Session> sessions = new HashMap<>();

    private void broadcast(Message message) {
        sessions.forEach((username, session) -> {
            try {
                session.getBasicRemote().sendObject(message);
            } catch (IOException | EncodeException e) {
                e.printStackTrace();
            }
        });
    }

    @OnOpen
    public void onOpen(@PathParam("username") String username, Session session) {
        if (sessions.containsKey(username)) {
            throw new RuntimeException("Username already exists");
        } else {
            session.getUserProperties().put("username", username);
            sessions.put(username, session);
            
            // type 0: có người vào
            Message message = new Message("joined the chat", 0, username, sessions.size());
            this.broadcast(message);
        }
    }

    @OnMessage
    public void onMessage(Message message, Session session) {
        // Gán lại tên người gửi và số count cho chắc chắn
        message.setSender((String) session.getUserProperties().get("username"));
        message.setCount(sessions.size());
        this.broadcast(message);
    }

    @OnClose
    public void onClose(Session session) {
        String username = (String) session.getUserProperties().get("username");
        if(username != null) {
            sessions.remove(username);
            // type 1: có người thoát
            Message message = new Message("left the chat", 1, username, sessions.size());
            this.broadcast(message);
        }
    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        try {
            session.close();
        } catch (IOException e) {
            throw new RuntimeException("Unable to close session");
        }
    }
}
