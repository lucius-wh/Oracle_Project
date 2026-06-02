package com.oracleproject.mapper;

import com.oracleproject.model.StudentBuildingRel;
import com.oracleproject.vo.StudentVisitVO;
import com.oracleproject.vo.VisitQueryVO;

import java.util.List;

public interface StudentVisitMapper {

    // 查询所有参观记录（模糊查询）
    List<StudentVisitVO> findVisitList(VisitQueryVO queryVO);

    // 逻辑删除参观记录
    int deleteRel(Integer relId);

}