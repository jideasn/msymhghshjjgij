package com.kh.farm.category.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.farm.category.model.service.CategoryImpl;
import com.kh.farm.category.model.service.CategoryService;
import com.kh.farm.category.model.vo.Category;
import com.kh.farm.member.model.vo.Member;

import net.sf.json.JSONArray;

@Controller
public class CategoryController {
	@Autowired
	private CategoryService categoryService;
	
	@RequestMapping(value="category_big.do", method=RequestMethod.POST)
	@ResponseBody
	public void selectCategory_main(HttpServletResponse response) throws IOException{
		System.out.println("selectCategory_main 메소드 실행");
		List<Category> category = categoryService.selectCategory_main();
		category.toString();
		if(category.size()> 0) {
			JSONArray jarr = new JSONArray();
			
			for(Category c : category) {
				JSONObject job = new JSONObject();
				
				job.put("category_main", c.getCategory_main());
				//job.put("category_small", c.getCategory_small());
			
				
				jarr.add(job);
			}
			JSONObject sendJson = new JSONObject();
			sendJson.put("big", jarr);
			
			response.setContentType("application/json; charset=utf-8"); 
			PrintWriter out = response.getWriter();
			out.println(sendJson.toJSONString());
			out.flush();
			out.close();
			
			
		}
	}
	
	@RequestMapping(value="category_small.do", method=RequestMethod.POST)
	@ResponseBody
	public void selectCategory_small(HttpServletResponse response) throws IOException{
		System.out.println("selectCategory_small 메소드 실행");
		List<Category> category = categoryService.selectCategory_small();
		category.toString();
		if(category.size()> 0) {
			JSONArray jarr = new JSONArray();
			
			for(Category c : category) {
				JSONObject job = new JSONObject();
				
				job.put("category_small", c.getCategory_small());
				job.put("category_main", c.getCategory_main());
				
				jarr.add(job);
			}
			JSONObject sendJson = new JSONObject();
			sendJson.put("small", jarr);
			
			response.setContentType("application/json; charset=utf-8"); 
			PrintWriter out = response.getWriter();
			out.println(sendJson.toJSONString());
			out.flush();
			out.close();
			
			
		}
	}
	@RequestMapping(value="category_name.do", method=RequestMethod.POST)
	@ResponseBody
	public void selectCategory_name (HttpServletResponse response) throws IOException{
		System.out.println("selectCategory_name 메소드 실행");
		List<Category> category = categoryService.selectCategory_name();
		category.toString();
		if(category.size()> 0) {
			JSONArray jarr = new JSONArray();
			
			for(Category c : category) {
				JSONObject job = new JSONObject();
				job.put("category_no", c.getCategory_no());
				job.put("category_main", c.getCategory_main());
				job.put("category_small", c.getCategory_small());
				job.put("category_name", c.getCategory_name());
				
				jarr.add(job);
			}
			JSONObject sendJson = new JSONObject();
			sendJson.put("name", jarr);
			
			response.setContentType("application/json; charset=utf-8"); 
			PrintWriter out = response.getWriter();
			out.println(sendJson.toJSONString());
			out.flush();
			out.close();
			
		}
	}
	
	
}
