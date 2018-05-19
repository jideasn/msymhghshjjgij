package com.kh.farm.market.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.farm.market.model.service.MarketService;
import com.kh.farm.market.model.vo.Market;

@Controller
public class MarketController {
@Autowired private MarketService marketService;

	@RequestMapping(value="marketList.do")
	public ModelAndView marketList(ModelAndView mv) {
		int page = 1;
		ArrayList<Market> list = marketService.marketList(page);
		mv.setViewName("market/marketList");
		mv.addObject("list",list);
		return mv;
	}
	@RequestMapping(value="ajaxMoreMarket.do", method=RequestMethod.POST)
	public void moreMarketList(HttpServletResponse response,@RequestParam("page") int page) throws IOException{
		List<Market> list = marketService.marketList(page);
		JSONArray jarr = new JSONArray();
		
		//list를 jarr로 복사하기
		for(Market m : list) {
			//추출한 user를 json 객체에 담기
			JSONObject jmarket = new JSONObject();
			jmarket.put("market_title", m.getMarket_title());
			jmarket.put("market_no", m.getMarket_no());
			jmarket.put("market_note", m.getMarket_note());
			jmarket.put("market_img", m.getMarket_img());
			
			jarr.add(jmarket);
		}
		//전송용 최종 json 객체 선언
		JSONObject sendJson = new JSONObject();
		sendJson.put("list", jarr);
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.append(sendJson.toJSONString());
		out.flush();
		out.close();
	}
}