package com.web.entity;

public class User extends BaseDto {
	
	String 	ucid;
	String 	cmpid;
	String 	userid;
	String 	username;
	String 	userpassword;
	String 	usergroupid;
	String 	tel;
	String 	email;
	int	inputauthority;
	int	approveauthority;
	int	infoauthority;
	int	deleteflag;
	
	public String getUcid() {
		return ucid;
	}
	public void setUcid(String ucid) {
		this.ucid = ucid;
	}
	public String getCmpid() {
		return cmpid;
	}
	public void setCmpid(String cmpid) {
		this.cmpid = cmpid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUserpassword() {
		return userpassword;
	}
	public void setUserpassword(String userpassword) {
		this.userpassword = userpassword;
	}
	public String getUsergroupid() {
		return usergroupid;
	}
	public void setUsergroupid(String usergroupid) {
		this.usergroupid = usergroupid;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getInputauthority() {
		return inputauthority;
	}
	public void setInputauthority(int inputauthority) {
		this.inputauthority = inputauthority;
	}
	public int getApproveauthority() {
		return approveauthority;
	}
	public void setApproveauthority(int approveauthority) {
		this.approveauthority = approveauthority;
	}
	public int getInfoauthority() {
		return infoauthority;
	}
	public void setInfoauthority(int infoauthority) {
		this.infoauthority = infoauthority;
	}
	public int getDeleteflag() {
		return deleteflag;
	}
	public void setDeleteflag(int deleteflag) {
		this.deleteflag = deleteflag;
	}
	
	

}
