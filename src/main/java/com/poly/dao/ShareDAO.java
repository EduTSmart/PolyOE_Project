package com.poly.dao;
import com.poly.entity.Share;
import com.poly.entity.User;
import com.poly.utils.JpaUtils;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

import com.poly.dto.ShareReport;
public class ShareDAO extends AbstractEntityDAO<Share> {
    public ShareDAO() {
        super(Share.class);
    }
 // Xây dựng truy vấn hiển thị thông tin chia sẻ tổng hợp (Dùng cho Bài 4)
    public List<ShareReport> getShareReports() {
        EntityManager em = JpaUtils.getEntityManager();
        try {
            String jpql = "SELECT new com.poly.dto.ShareReport(s.video.title, COUNT(s), MIN(s.shareDate), MAX(s.shareDate)) " +
                          "FROM Share s GROUP BY s.video.title";
            TypedQuery<ShareReport> query = em.createQuery(jpql, ShareReport.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }


}