package com.poly.dto;

import java.util.Date;

public class ShareReport {
    private String videoTitle;
    private Long shareCount;
    private Date firstShareDate;
    private Date lastShareDate;

    // Constructor phải khớp với thứ tự các trường trong câu lệnh SELECT NEW của JPQL
    public ShareReport(String videoTitle, Long shareCount, Date firstShareDate, Date lastShareDate) {
        this.videoTitle = videoTitle;
        this.shareCount = shareCount;
        this.firstShareDate = firstShareDate;
        this.lastShareDate = lastShareDate;
    }

    // --- Getters và Setters ---
    public String getVideoTitle() { return videoTitle; }
    public void setVideoTitle(String videoTitle) { this.videoTitle = videoTitle; }
    public Long getShareCount() { return shareCount; }
    public void setShareCount(Long shareCount) { this.shareCount = shareCount; }
    public Date getFirstShareDate() { return firstShareDate; }
    public void setFirstShareDate(Date firstShareDate) { this.firstShareDate = firstShareDate; }
    public Date getLastShareDate() { return lastShareDate; }
    public void setLastShareDate(Date lastShareDate) { this.lastShareDate = lastShareDate; }
}
