package com.poly.dao;
import com.poly.entity.User;

public class UserDAO extends AbstractEntityDAO<User> {
    public UserDAO() {
        super(User.class);
    }
}
