package com.jk.controller;

import com.alibaba.fastjson.JSON;

import com.jk.entity.Item;
import com.jk.service.ItemService;
import com.jk.util.DataGridJson;
import com.jk.util.PageUtil;
import com.jk.util.ReturnJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2017/6/2.
 */
@Controller
@RequestMapping("item")
public class ItemController {
    @Autowired
    private ItemService itemService;

    @RequestMapping(value = "toItem")
    public String toItem(){
        return "item/page";
    }

        //分页+条件查询
        @RequestMapping(value = "selectItem", method = RequestMethod.POST)
        @ResponseBody
        public DataGridJson selectItem(int page, int rows, PageUtil<Item> itemPage) {

            itemPage.setCpage(page);
            itemPage.setPageSize(rows);

            itemPage = itemService.selectItem(itemPage);

            DataGridJson dg = new DataGridJson();

            dg.setTotal(itemPage.getTotalCount());

            dg.setRows(itemPage.getList());

            return dg;
        }

        //跳转到itemAddFrom
        @RequestMapping("toAdd")
        public String toAdd() {

            return "item/itemForm";
        }

        //商品添加
        @RequestMapping(value = "saveItem",method = RequestMethod.POST)
        @ResponseBody
        public ReturnJson saveItem(Item item) {
            ReturnJson rj = new ReturnJson();

            int l = itemService.saveItem(item);

            if (l == 1) {
                rj.setMsg("新增用户成功");
                rj.setSuccess(true);

            } else {
                rj.setMsg("新增用户失败");
                rj.setSuccess(false);
            }
            return rj;

        }
    //批量删除
    @RequestMapping("deleteItem")
    @ResponseBody
    public ReturnJson deleteItem(HttpServletRequest request, HttpServletResponse response, String strId){
        ReturnJson rj=new ReturnJson();
        Boolean boo=itemService.deleteItem(request,strId);
        if(boo){
            rj.setMsg("删除成功");
        }else{
            rj.setMsg("不行就拉到");
        }
        return rj;
    }
    //行内修改updateItemInfo
    //行内修改
    @RequestMapping(value = "updateItemInfo" ,method = RequestMethod.POST)
    @ResponseBody
    public  ReturnJson updateItemInfo(String item){
        ReturnJson rj = new ReturnJson();
		/*json字符串--- json对象 --- java对象*/
        /*java对象---json对象----json字符串*/
        Item i = JSON.parseObject(item,Item.class);
        //修改时间为当前时间
        i.setUpdated(new Date());
        //根据id修改用户基本信息
        int x=itemService.updateItemInfo(i);
        return rj;
    }


}

