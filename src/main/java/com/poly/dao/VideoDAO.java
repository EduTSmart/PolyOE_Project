package com.poly.dao;
import java.util.List;

import com.poly.entity.User;
import com.poly.entity.Video;
import com.poly.utils.JpaUtils;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class VideoDAO extends AbstractEntityDAO<Video> {
   
	public VideoDAO() {
        super(Video.class);
    }
	
	// Tìm các video có title chứa từ khóa (Dùng cho Bài 3)
	public List<Video> findByKeyword(String keyword) {
	    EntityManager em = JpaUtils.getEntityManager();
	    try {
	        String jpql = "SELECT v FROM Video v WHERE v.title LIKE :keyword";
	        TypedQuery<Video> query = em.createQuery(jpql, Video.class);
	        query.setParameter("keyword", "%" + keyword + "%");
	        return query.getResultList();
	    } finally {
	        em.close();
	    }
	}

	// Truy vấn 10 video được yêu thích nhiều nhất
	public List<Video> findTop10LikedVideos() {
	    EntityManager em = JpaUtils.getEntityManager();
	    try {
	        String jpql = "SELECT f.video FROM Favorite f GROUP BY f.video ORDER BY COUNT(f.video) DESC";
	        TypedQuery<Video> query = em.createQuery(jpql, Video.class);
	        query.setMaxResults(10); // Giới hạn 10 kết quả
	        return query.getResultList();
	    } finally {
	        em.close();
	    }
	}

	// Tìm các video không được ai thích
	public List<Video> findVideosWithNoLikes() {
	    EntityManager em = JpaUtils.getEntityManager();
	    try {
	        String jpql = "SELECT v FROM Video v WHERE v.favorites IS EMPTY";
	        TypedQuery<Video> query = em.createQuery(jpql, Video.class);
	        return query.getResultList();
	    } finally {
	        em.close();
	    }
	}

	// Tìm video được chia sẻ trong năm 2024 và sắp xếp theo thời gian
	public List<Video> findVideosSharedIn2024() {
	    EntityManager em = JpaUtils.getEntityManager();
	    try {
	        String jpql = "SELECT DISTINCT s.video FROM Share s WHERE YEAR(s.shareDate) = 2024 ORDER BY s.shareDate DESC";
	        TypedQuery<Video> query = em.createQuery(jpql, Video.class);
	        return query.getResultList();
	    } finally {
	        em.close();
	    }
	}


}
