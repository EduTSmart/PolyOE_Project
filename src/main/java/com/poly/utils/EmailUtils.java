package com.poly.utils;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailUtils {
    public static void send(String to, String subject, String content) throws Exception {
        // Cấu hình tài khoản email người gửi (Nên dùng App Password của Google)
        final String username = "edutsmart@gmail.com"; // THAY BẰNG EMAIL CỦA BẠN
        final String password = "";    // THAY BẰNG APP PASSWORD

        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(prop, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(username));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject(subject);
        message.setContent(content, "text/html; charset=utf-8");

        Transport.send(message);
    }
}
