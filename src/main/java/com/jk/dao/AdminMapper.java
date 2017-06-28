package com.jk.dao;

import com.jk.entity.Admin;

import java.math.BigDecimal;


public interface AdminMapper {
    int deleteByPrimaryKey(BigDecimal id);

    int insert(Admin record);

    int insertSelective(Admin record);

    Admin selectByPrimaryKey(BigDecimal id);

    int updateByPrimaryKeySelective(Admin record);

    int updateByPrimaryKey(Admin record);
     //用户注册
    void saveAdmin(Admin admin);
   //校检用户是否存在
    Admin checkAdmin(Admin admin);
}