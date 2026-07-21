package com.poly.dao;
import com.poly.entity.User;
import com.poly.utils.JpaUtils;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class UserDAO extends AbstractEntityDAO<User> {
    public UserDAO() {
        super(User.class);
    }
    public User findByIdOrEmail(String idOrEmail) {
        EntityManager em = JpaUtils.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u WHERE u.id = :keyword OR u.email = :keyword";
            TypedQuery<User> query = em.createQuery(jpql, User.class);
            query.setParameter("keyword", idOrEmail);
            return query.getResultStream().findFirst().orElse(null);
        } finally {
            em.close();
        }
    }

}
