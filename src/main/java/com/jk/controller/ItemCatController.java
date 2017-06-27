package com.jk.controller;

import com.jk.entity.ItemCat;
import com.jk.service.ItemCatService;
import com.jk.util.Tree;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2017/6/3.
 */
@Controller
@RequestMapping("itemCat")
public class ItemCatController {
    @Autowired
    private ItemCatService itemCatService;
    @RequestMapping(value="selectItemCatList")
    @ResponseBody
    public List<ItemCat> selectUserLevelList(){
        List<ItemCat> itemCatList = new ArrayList<>();

        itemCatList = itemCatService.selectItemCatList();
        return itemCatList;
    }

   /* treegrid*/
   @RequestMapping("toItemList")
   public String toItemList(){
       return "admin/toItemList";
   }
    @RequestMapping(value="selectCat",method=RequestMethod.POST)
    @ResponseBody
    public List<ItemCat> selectChildLista(Integer  id){
        List<ItemCat> itemList =  itemCatService.selectCat(id);
        return itemList;
    }
    //封装递归方法
    private void selectChildLista(List<ItemCat> list,ItemCat prarentNode){
        //子节点list
        ArrayList<ItemCat> childList = new ArrayList<>();
        //子级节点
        ItemCat child = null;
        //节点的自定义属性 如 url等。。。
        HashMap<String, String> nodeAttr = null;
        //循环遍历子节点
        for (int j = 0; j < list.size(); j++) {
            //当前循环的节点的父级id 等于  上层循环节点的id
            if (list.get(j).getParentId().intValue() != 0 &&
                    prarentNode.getId().equals(list.get(j).getParentId()) ) {
                //实例化子节点
                child = new ItemCat();
                //节点属性赋值
                child.setId(list.get(j).getId());
                child.setName(list.get(j).getName());
                child.setStatus(list.get(j).getStatus());
                child.setParentId(list.get(j).getParentId());
                child.setCreated(list.get(j).getCreated());
                child.setUpdated(list.get(j).getUpdated());
                childList.add(child);

                //递归调用查找子节点 n层
                selectChildLista(list, child);
            }
        }
        prarentNode.setChildren(childList);

    }

    }




