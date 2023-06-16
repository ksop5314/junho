package com.ggiri.root.project.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.ggiri.root.mybatis.project.ProjectMapper;
import com.ggiri.root.project.dto.ProjectDTO;
import com.ggiri.root.project.dto.ProjectRepDTO;

@Service
public class ProjectServiceImpl implements ProjectService {

    @Autowired
    private ProjectMapper pm;

    @Override
    public void projectList(Model model) {
        model.addAttribute("projectList", pm.projectList());
    }
    
    @Override
    public void projectView(int projectNum, Model model) {
        model.addAttribute("data", pm.projectView(projectNum));
        pm.proHit(projectNum);
    }

    @Override
    public int insertPro(ProjectDTO dto) {
    	return pm.insertPro(dto);
    }

    @Override
    public void modify(ProjectDTO dto) {
        pm.modify(dto);
    }

    @Override
    public void delete(int projectNum) {
        pm.delete(projectNum);
    }

    @Override
    public List<ProjectDTO> search(String keyword, String searchType) {
        return pm.search(keyword, searchType);
    }

    @Override
    public int getProjectCountBySearch(String keyword, String searchType) {
        return pm.getProjectCountBySearch(keyword, searchType);
    }

    @Override
    public List<ProjectDTO> getProjectListBySearch(String keyword, String searchType, int startRow, int endRow) {
        return pm.getProjectListBySearch(keyword, searchType, startRow, endRow);
    }


    @Override
    public List<ProjectDTO> getProjectList(int page, int perPage) {
        int startRow = (page - 1) * perPage + 1;
        int endRow = startRow + perPage - 1;
        return pm.getProjectList(startRow, endRow);
    }
    
    @Override
    public int getProjectCount() {
        return pm.getProjectCount();
    }	
    
    
    @Override
    public List<ProjectDTO> getProjectInfo(int projectNum, Model model) {
    	return pm.getProjectInfo(projectNum, model);
    }
    
    
    // 관리자 페이지
    @Override
    public void adminProjectList(Model model) {
    	model.addAttribute("adminProjectList", pm.adminProjectList());
    }

    
    @Override
    public void proDelete(int projectNum) {
    	pm.proDelete(projectNum);
    }
    
    @Override
    public void adminReplyList(Model model) {
    	model.addAttribute("adminReplyList", pm.adminReplyList());
    }
    
    
    // 댓글
    @Override
    public int addReplyTest(ProjectRepDTO dto) {
    	
    	return pm.addReplyTest(dto);
    }
    
	@Override
	public List<ProjectRepDTO> getRepList(int bno) {
		return pm.getRepList(bno);
	}
    
}

