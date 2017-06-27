package com.jk.service;


import com.jk.entity.ItemCat;

import java.util.List;

/**
 * Created by Administrator on 2017/6/3.
 */
public interface ItemCatService {
    List<ItemCat> selectItemCatList();


    List<ItemCat> selectItemCat();

    List<ItemCat> selectCat(Integer id);
}
