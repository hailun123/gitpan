package com.jk.service;


import com.jk.entity.Admin;

public interface AdminService {


    void registerAdmin(Admin admin);

    Admin checkAdmin(Admin admin);
}
