package com.jk.controller;


import com.jk.entity.Admin;
import com.jk.entity.SessionInfo;
import com.jk.service.AdminService;
import com.jk.util.ConfigUtil;
import com.jk.util.MD5Util;
import com.jk.util.ReturnJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2017/6/2.
 */
@Controller
@RequestMapping("admin")
public class AdminController{
    @Autowired
    private AdminService adminService;
    /**
     * 用户注册  ---添加用户
     * @param
     * @return
     */
    @RequestMapping(value="registerAdmin",method= RequestMethod.POST)
    @ResponseBody
    public ReturnJson registerAdmin(Admin admin, HttpServletRequest request){
        ReturnJson  rj = new ReturnJson();
        //获取session中的验证码
        String code = (String) request.getSession().getAttribute("imageCode");
        //校验验证码是否正确
        if (null != admin && !"".equals(admin.getImgcode().trim()) && !"".equals(code)) {
            //验证码正确---不区分大小写
            if (admin.getImgcode().trim().toUpperCase().equals(code.toUpperCase())) {
                adminService.registerAdmin(admin);
                // 主键id ,布尔类型 ,影响数据库的条数
                rj.setSuccess(true);
                rj.setMsg("注册成功");
            }else{
                rj.setSuccess(false);
                rj.setMsg("验证码错误");
            }
        }
        return rj;
    }
    /**
     * 校验用户登录
     * @return
     */
    @RequestMapping(value="checkAdminLogin",method=RequestMethod.POST)
    @ResponseBody
    public ReturnJson checkAdminLogin(Admin admin,HttpServletRequest request){
        ReturnJson rj = new ReturnJson();

        //获取session中的验证码
        String code = (String) request.getSession().getAttribute("imageCode");
        //校验验证码是否正确
        if (null != admin && !"".equals(admin.getImgcode().trim()) && !"".equals(code)) {

            //验证码正确---不区分大小写
            if (admin.getImgcode().trim().toUpperCase().equals(code.toUpperCase())) {
                //u 查询数据库的信息
                //user 用户登录时表单
                Admin a = adminService.checkAdmin(admin);
                if (null != a) {//用户名正确
                    if (a.getPassword().equals(MD5Util.md5(admin.getPassword()))) {//密码正确
                        rj.setSuccess(true);
                        rj.setMsg("登录成功");

                        //登录成功之后将用户信息存放到session中
                        SessionInfo sessionInfo = new SessionInfo();
                        sessionInfo.setAdmin(a);

                        request.getSession().setAttribute(ConfigUtil.getSessionInfoName(),sessionInfo);
                    } else {
                        rj.setSuccess(false);
                        rj.setMsg("密码错误");
                    }
                } else {//用户名错误
                    rj.setSuccess(false);
                    rj.setMsg("用户名错误");
                }
            }
        }

        return rj;
    }
    /**
     * 校验用户---账户名称是否已存在
     * @return
     */
    @RequestMapping(value="checkAdmin",method=RequestMethod.POST)
    @ResponseBody
    public ReturnJson checkAdmin(Admin admin){
        ReturnJson rj = new ReturnJson();

        Admin a = adminService.checkAdmin(admin);

        if (null != a) {
            rj.setSuccess(false);//已经被注册
        }else{
            rj.setSuccess(true);
        }
        return rj;
    }

    /*登陆成功跳转的page*/
    @RequestMapping("toAdminList")
    public String toAdminList(){

        return "admin/page";
    }



}
