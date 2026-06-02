package com.oracleproject.mapper;

import com.oracleproject.model.Building;

public interface BuildingMapper {

    // 根据ID查询建筑详情
    Building findById(Integer id);

}