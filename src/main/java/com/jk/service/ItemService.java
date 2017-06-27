package com.jk.service;

import com.jk.entity.Item;
import com.jk.util.PageUtil;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2017/6/2.
 */
public interface ItemService {
    PageUtil<Item> selectItem(PageUtil<Item> itemPage);

    int saveItem(Item item);

    Boolean deleteItem(HttpServletRequest request, String strId);

    int updateItemInfo(Item i);

    List<Item> selectItemWhere(Item item);
}
