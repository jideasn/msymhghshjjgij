package com.kh.farm.notice.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.farm.notice.model.service.NoticeService;
import com.kh.farm.notice.model.vo.Notice;
import com.kh.farm.qna.model.vo.MainQna;

@Controller
public class NoticeController {
@Autowired private NoticeService noticeService;

	@RequestMapping("noticeList.do")
	public void noticeList(HttpServletResponse response,@RequestParam("page") int currentPage) throws IOException{
		
		JSONArray jarr =new JSONArray();
		
		ArrayList<Notice> noticeList = noticeService.selectNoticeList(currentPage);
		int limitPage = 10;
		System.out.println("111");
		int listCount = noticeService.selectNoticeCount();
		
		int maxPage=(int)((double)listCount/limitPage+0.9); //ex) 41개면 '5'페이지나와야되는데 '5'를 계산해줌
		int startPage=((int)((double)currentPage/5+0.8)-1)*5+1;
		int endPage=startPage+5-1;
		
		if(maxPage<endPage) {
			endPage = maxPage;
		}
		for (Notice sq : noticeList) {
			JSONObject jsq = new JSONObject();
			jsq.put("rnum", sq.getRnum());
			jsq.put("notice_no", sq.getNotice_no());
			jsq.put("notice_date", sq.getNotice_date().toString());
			jsq.put("notice_title", sq.getNotice_title());
			jsq.put("startPage", startPage);
			jsq.put("endPage", endPage);
			jsq.put("maxPage", maxPage);
			jsq.put("currentPage",currentPage);
			jarr.add(jsq);
		}
		
		JSONObject sendJson = new JSONObject();
		sendJson.put("list", jarr);
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.append(sendJson.toJSONString());
		out.flush();
		out.close();
		
	}
	
	@RequestMapping(value="insertNotice.do", method=RequestMethod.POST)
	public String insertNotice(Notice notice) {
		String a = "ab";
		int result = noticeService.insertNotice(notice);
		
		if(result > 0) {
			
			return "notice/notice";
			
		}
		return a;
	}
	
	@RequestMapping(value="noticeDetail.do")
	public String noticeDetail(Model model, @RequestParam(value="notice_no") int notice_no) {
		
		System.out.println(notice_no);
		Notice notice = noticeService.noticeDeatil(notice_no);
		System.out.println(notice.getNotice_title());
		notice.toString();
		if(notice != null) {
		
			model.addAttribute("notice",notice);
			return "notice/noticeDetail";
		}
		return "에러페이지";
	}
	
	@RequestMapping(value="updateNotice.do", method=RequestMethod.POST)
	public String updateNotice(Notice notice) {
		int result = noticeService.updateNotice(notice);
		
		if(result > 0) {
			
			return "redirect:/noticeDetail.do?notice_no="+notice.getNotice_no();
			/*return "notice/notice";*/
		}
		
		
		return null;
	}
	
	@RequestMapping(value="deleteNotice.do")
	public String deleteNotice(@RequestParam(value="notice_no") int notice_no) {
		int result = noticeService.deleteNotice(notice_no);
		
		if(result > 0) {
			return "notice/notice";
		}
		return null;
	}
}
