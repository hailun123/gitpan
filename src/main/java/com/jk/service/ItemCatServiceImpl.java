package com.jk.service;
import com.jk.dao.ItemCatMapper;
import com.jk.entity.ItemCat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2017/6/3.
 */
@Service
public class ItemCatServiceImpl implements  ItemCatService {
    @Autowired
    private ItemCatMapper itemCatMapper;

    @Override
    public List<ItemCat> selectItemCatList() {
        return itemCatMapper.selectItemCatList();
    }

    @Override
    public List<ItemCat> selectItemCat() {
        return itemCatMapper.selectItemCat();
    }

    @Override
    public List<ItemCat> selectCat(Integer id) {
        return itemCatMapper.selectCat(id);
    }
}
