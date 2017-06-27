package com.jk.dao;

import com.jk.entity.Item;
import com.jk.util.PageUtil;

import java.math.BigDecimal;
import java.util.List;


public interface ItemMapper {
    int deleteByPrimaryKey(BigDecimal id);

    int insert(Item record);

    int insertSelective(Item record);

    Item selectByPrimaryKey(BigDecimal id);

    int updateByPrimaryKeySelective(Item record);

    int updateByPrimaryKey(Item record);
  /*  查询商品 list集合*/
    List<Item> selectItemManyList(PageUtil<Item> itemPage);
    /*  查询商品 总条数*/
    int selectItemManyListCount(PageUtil<Item> itemPage);


    int saveItem(Item item);

    int deleteItem(List<String> idList);

    int updateItemInfo(Item i);

    List<Item> selectItemWhere(Item item);
}