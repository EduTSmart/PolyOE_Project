package com.poly.entity;
import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "Logs")
public class Log {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private String url;
    
    @Temporal(TemporalType.TIMESTAMP)
    private Date time;
    
    private String username;

    // Các hàm khởi tạo (Constructors)
    public Log() {}
    public Log(String url, Date time, String username) {
        this.url = url;
        this.time = time;
        this.username = username;
    }
    // TODO: Bạn bổ sung thêm Getter/Setter cho các trường
}
