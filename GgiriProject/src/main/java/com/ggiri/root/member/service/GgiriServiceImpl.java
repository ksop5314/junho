package com.ggiri.root.member.service;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.ggiri.root.member.dto.GgiriMemberDTO;
import com.ggiri.root.mybatis.member.GgiriMemberMapper;
import com.ggiri.root.project.dto.ProjectDTO;

@Service
public class GgiriServiceImpl implements GgiriService{

	@Autowired
	private GgiriMemberMapper gmm;
	
	
	// 강준호
	@Override
	public int register(GgiriMemberDTO member) {
		try {
			
			return gmm.register(member);
			
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	@Override
	public int idCheck(String id) {
		return gmm.idCheck(id);
	}
	
	@Override
	public int loginCheck(HttpServletRequest request) {
		GgiriMemberDTO dto = gmm.loginCheck(request.getParameter("id"));
		if(dto != null) {
			if(dto.getId().equals("GGIRIADMIN")) {
				if(request.getParameter("pwd").equals(dto.getPwd())) {
					return 2;
				}
			}
			if(request.getParameter("pwd").equals(dto.getPwd())) {
				return 0;
			}
		}
		return 1;
	}
	
	@Override
	public int modifyResult(GgiriMemberDTO modifyMember) {
		try {
			
			return gmm.modifyResult(modifyMember);
			
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	@Override
	public GgiriMemberDTO findEmail(String email) {
		return gmm.findEmail(email);
	}
	
	@Override
	public int findNaver(String naverMember) {
		int findNaver = gmm.findNaver(naverMember);
		if(findNaver == 0) {
			return 0;
		}
		return 1;
	}
	
	@Override
	public void naverInsert(GgiriMemberDTO naverInsert) {
		gmm.naverInsert(naverInsert);
	}
	
	@Override
	public int findKakao(String kakaoMember) {
		int findKakao = gmm.findKakao(kakaoMember);
		if(findKakao == 0) {
			return 0;
		}
		return 1;
	}
	
	
	@Override
	public void kakaoinsert(GgiriMemberDTO kakaoInsert) {
		gmm.kakaoinsert(kakaoInsert);
		
	}
	
	@Override
	public int findGoogle(String googleMember) {
		int findGoogle = gmm.findGoogle(googleMember);
		if(findGoogle == 0) {
			return 0;
		}
		return 1;
	}
	
	@Override
	public void googleinsert(GgiriMemberDTO googleInsert) {
		gmm.googleinsert(googleInsert);
	}
	
	@Override
	public void ggiriMemberInfo(String id, Model model) {
		GgiriMemberDTO dto = gmm.ggiriMemberInfo(id);
		model.addAttribute("ggiriMemberInfo", dto);
	}
	
	@Override
	public void ggiriSnsInfo(String id, Model model) {
		GgiriMemberDTO dto = gmm.ggiriSnsInfo(id);
		model.addAttribute("ggiriSnsInfo", dto);
	}
	
	@Override
	public int joinPhone(String userTel) {
		return gmm.joinPhone(userTel);
	}
	
	@Override
	public void allMember(Model model, String id) {
		model.addAttribute("allMember", gmm.allMember(id));
	}

	@Override
	public int getProjectCountBySearch(String keyword, String condition) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<ProjectDTO> getProjectListBySearch(String keyword, String condition) {
		// TODO Auto-generated method stub
		return null;
	}

//	@Override
//	public int getProjectCountBySearch(String keyword, String condition) {
//        return gmm.getProjectCountBySearch(keyword, searchType);
//	}
//
//	@Override
//	public List<ProjectDTO> getProjectListBySearch(String keyword, String condition) {
//        return gmm.getProjectListBySearch(keyword, searchType);
//	}
//
//	@Override
//	public List<ProjectDTO> getProjectList(int page, int perPage) {
//		// TODO Auto-generated method stub
//		return null;
//	}
//
//	@Override
//	public int getProjectCount() {
//		return gmm.getProjectCount();
//	}
	
	// 강준호 끝
	
	
	
	
	

	
	
}
