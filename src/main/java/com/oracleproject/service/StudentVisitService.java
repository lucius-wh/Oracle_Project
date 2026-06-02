package com.oracleproject.service;

import com.oracleproject.mapper.StudentVisitMapper;
import com.oracleproject.model.StudentBuildingRel;
import com.oracleproject.vo.StudentVisitVO;
import com.oracleproject.vo.VisitQueryVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StudentVisitService {

    @Autowired
    private StudentVisitMapper studentVisitMapper;

    public List<StudentVisitVO> findVisitList(
            VisitQueryVO queryVO) {

        return studentVisitMapper
                .findVisitList(queryVO);
    }

    public boolean deleteRel(Integer relId) {

        return studentVisitMapper
                .deleteRel(relId) > 0;
    }

}