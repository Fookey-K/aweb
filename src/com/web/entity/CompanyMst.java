package com.web.entity;

public class CompanyMst extends BaseDto {
	
	String cmpid;
	String cmpname;
	String contacts;
	String tel;
	String fax;
	String address;
	int deleteFlag;
	
	public String getCmpid() {
		return cmpid;
	}
	public void setCmpid(String cmpid) {
		this.cmpid = cmpid;
	}
	public String getCmpname() {
		return cmpname;
	}
	public void setCmpname(String cmpname) {
		this.cmpname = cmpname;
	}
	public String getContacts() {
		return contacts;
	}
	public void setContacts(String contacts) {
		this.contacts = contacts;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getDeleteFlag() {
		return deleteFlag;
	}
	public void setDeleteFlag(int deleteFlag) {
		this.deleteFlag = deleteFlag;
	}
	@Override
	public String toString() {
		return "CompanyMst [cmpid=" + cmpid + ", cmpname=" + cmpname + ", contacts=" + contacts + ", tel=" + tel
				+ ", fax=" + fax + ", address=" + address + ", deleteFlag=" + deleteFlag + "]";
	}
	
	
	
}
