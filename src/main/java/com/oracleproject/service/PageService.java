package com.oracleproject.service;

import com.oracleproject.mapper.PageMapper;
import com.oracleproject.model.Building;
import com.oracleproject.utils.PageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class PageService{

    @Autowired
    private PageMapper pageMapper;

    public PageBean<Building> getBuildingPage(Integer pageNum) {
        PageBean<Building> pageBean = new PageBean<>();
        int pageSize = 6;
        if (pageNum == null || pageNum < 1) {
            pageNum = 1;
        }

        int start = (pageNum - 1) * pageSize;
        int end = pageNum * pageSize;

        List<Building> list = pageMapper.selectPage(start, end);
        Long total = pageMapper.selectCount();

        pageBean.setPageNum(pageNum);
        pageBean.setTotal(total);
        pageBean.setList(list);

        return pageBean;
    }

    public void deleteBuilding(Integer id) {
        pageMapper.deleteBuilding(id);
    }

    public List<Building> getAllDeletedBuildings() {
        return pageMapper.selectAllDeletedBuildings();
    }

    public void restoreBuilding(Integer id) {
        pageMapper.restoreBuilding(id);
    }
}