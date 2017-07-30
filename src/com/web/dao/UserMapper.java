package com.web.dao;

import com.web.entity.User;

public interface UserMapper {

	User selectUserByUserId(User user);
}
