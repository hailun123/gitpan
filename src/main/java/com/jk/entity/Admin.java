package com.jk.entity;

import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

public class Admin implements Serializable {
    private static final long serialVersionUID = 8770992856494959634L;
    private String id;

    private String adminName;

    private String phone;

    private String email;

    private String password;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date created;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date updated;

    private Date StringinTime;
    //验证码
    private String imgcode;

    public String getImgcode() {
        return imgcode;
    }

    public void setImgcode(String imgcode) {
        this.imgcode = imgcode;
    }


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getAdminName() {
        return adminName;
    }

    public void setAdminName(String adminName) {
        this.adminName = adminName == null ? null : adminName.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public Date getCreated() {
        return created;
    }

    public void setCreated(Date created) {
        this.created = created;
    }

    public Date getUpdated() {
        return updated;
    }

    public void setUpdated(Date updated) {
        this.updated = updated;
    }

    public Date getStringinTime() {
        return StringinTime;
    }

    public void setStringinTime(Date StringinTime) {
        this.StringinTime = StringinTime;
    }

    @Override
    public String toString() {
        return "Admin{" +
                "id='" + id + '\'' +
                ", adminName='" + adminName + '\'' +
                ", phone='" + phone + '\'' +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", created=" + created +
                ", updated=" + updated +
                ", StringinTime=" + StringinTime +
                ", imgcode='" + imgcode + '\'' +
                '}';
    }

    public Admin() {
        super();
    }
}