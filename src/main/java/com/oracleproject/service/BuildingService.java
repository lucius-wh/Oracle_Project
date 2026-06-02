package com.oracleproject.service;

import com.oracleproject.mapper.BuildingMapper;
import com.oracleproject.model.Building;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BuildingService {

    @Autowired
    private BuildingMapper buildingMapper;

    public Building findById(Integer id) {

        return buildingMapper.findById(id);
    }
}