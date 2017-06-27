package com.jk.service;

import com.jk.dao.ItemMapper;
import com.jk.entity.Item;
import com.jk.util.PageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2017/6/2.
 */
@Service
public class ItemServiceImpl implements ItemService {
@Autowired
    private ItemMapper itemMapper;
//分页条件
    @Override
    public PageUtil<Item> selectItem(PageUtil<Item> itemPage) {

        //查询list
        List<Item> itemList = itemMapper.selectItemManyList(itemPage);

        //查询count
        int totalCount = itemMapper.selectItemManyListCount(itemPage);

        itemPage.setList(itemList);

        itemPage.setTotalCount(totalCount);

        return itemPage;
    }
  //新增
    @Override
    public int saveItem(Item item) {
//创建时间

        item.setCreated(new Date());
        //修改时间
        item.setUpdated(new Date());
        int l = itemMapper.saveItem(item);
        return 1;
    }
//批量删除
    @Override
    public Boolean deleteItem(HttpServletRequest request, String strId) {
        String[] split = strId.split(",");
        List<String> idList=new ArrayList();
        for (int i=0;i<split.length;i++){
            idList.add(split[i].trim());
        }
        try {


            int c=itemMapper.deleteItem(idList);

            for (int j=0;j<idList.size();j++){
                String s = idList.get(j);
                Integer id = Integer.valueOf(s);

                String realPath = request.getServletContext().getRealPath("upfile");
            }

            return true;
        }catch (Exception e){
            return false;
        }
    }
// 行内修改
    @Override
    public int updateItemInfo(Item i) {
        return itemMapper.updateItemInfo(i);
    }
//下载execl
    @Override
    public List<Item> selectItemWhere(Item item) {
        return itemMapper.selectItemWhere(item);
    }
}
