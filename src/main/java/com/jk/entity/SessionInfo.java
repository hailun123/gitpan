package com.jk.entity;

/**
 * sessionInfo只要登录成功，就需要设置到session里面，便于系统使用
 * 
 */
public class SessionInfo implements java.io.Serializable {

	private static final long serialVersionUID = -223064067942668756L;
	/**
	 * 
	 */

	private Admin admin;

	public Admin getAdmin() {
		return admin;
	}

	public void setAdmin(Admin admin) {
		this.admin = admin;
	}

	@Override
	public String toString() {
		return "SessionInfo{" +
				"admin=" + admin +
				'}';
	}


}
