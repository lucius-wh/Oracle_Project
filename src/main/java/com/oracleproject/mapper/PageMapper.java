package com.oracleproject.mapper;

import com.oracleproject.model.Building;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface PageMapper {

    List<Building> selectPage(@Param("start") int start, @Param("end") int end);

    Long selectCount();

    void deleteBuilding(Integer id);

    List<Building> selectAllDeletedBuildings();

    void restoreBuilding(Integer id);
}