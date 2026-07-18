package com.poly.utils;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JpaUtils {
    private static EntityManagerFactory factory;

    public static EntityManager getEntityManager() {
        if (factory == null || !factory.isOpen()) {
            // "PolyOE" phải khớp với tên <persistence-unit name="PolyOE"> trong persistence.xml
            factory = Persistence.createEntityManagerFactory("PolyOE");
        }
        return factory.createEntityManager();
    }
}
