package com.jk.dao;



import com.jk.entity.ItemCat;

import java.math.BigDecimal;
import java.util.List;

public interface ItemCatMapper {
    int deleteByPrimaryKey(BigDecimal id);

    int insert(ItemCat record);

    int insertSelective(ItemCat record);

    ItemCat selectByPrimaryKey(BigDecimal id);

    int updateByPrimaryKeySelective(ItemCat record);

    int updateByPrimaryKey(ItemCat record);
    //查询itemcat集合
    List<ItemCat> selectItemCatList();
    //查询itemcat的树（tree）
    List<ItemCat> selectItemCat();

    List<ItemCat> selectCat(Integer id);
}