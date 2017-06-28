package com.jk.service;


import com.jk.dao.AdminMapper;
import com.jk.entity.Admin;
import com.jk.util.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Date;
import java.util.UUID;

/**
 * Created by Administrator on 2017/6/2.
 */
@Service
public class AdminServiceImpl implements AdminService  {
    @Autowired
    private AdminMapper adminMapper;

    @Override
    public void registerAdmin(Admin admin) {
        //随机数id
        admin.setId(UUID.randomUUID().toString());
//		密码加密
        admin.setPassword(MD5Util.md5(admin.getPassword()));
        //创建时间

        admin.setCreated(new Date());
        //修改时间
        admin.setUpdated(new Date());

        adminMapper.saveAdmin(admin);
    }
//校检用户是否存在
    @Override
    public Admin checkAdmin(Admin admin) {
        return adminMapper.checkAdmin(admin);
    }
}
