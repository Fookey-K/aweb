package com.web.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.web.dao.CompanyMstMapper;
import com.web.dao.UserMapper;
import com.web.entity.CompanyMst;
import com.web.entity.User;

@Service("loginService")
public class LoginServiceImpl implements LoginService {

	@Resource
	UserMapper userMapper;
	
	@Resource
	CompanyMstMapper  companyMstMapper;
	

	@Override
	public List<CompanyMst> selectCmpForList() {
		List<CompanyMst> list = companyMstMapper.selectCmpForList();
		return list;
	}

	@Override
	public int checkUser(String cmpId, String userId, String password) {
		
		int result = 0;
		//1:读取数据库的信息（tblUser）
		User paramUser = new User();
		paramUser.setCmpid(cmpId);
		paramUser.setUserid(userId);
		paramUser.setUserpassword(password);
		
		User user = userMapper.selectUserByUserId(paramUser);
		//2:判断数据是否存在 
		// 2.1 如果存在，判断密码是否相同，如果相同，返回1，不同返回0
		// 2.2 如果不存在，直接返回0
		if (user != null) {
			if (password.equals(user.getUserpassword())) {
				result = 1;
			}
		} 
		return result;
	}

	
}
