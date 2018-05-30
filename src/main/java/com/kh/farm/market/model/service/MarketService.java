package com.kh.farm.market.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.farm.market.exception.DeleteFailException;
import com.kh.farm.market.model.vo.Daily;
import com.kh.farm.market.model.vo.Market;
import com.kh.farm.market.model.vo.Reply;
import com.kh.farm.market.model.vo.Review;
import com.kh.farm.market.model.vo.UnderReply;
import com.kh.farm.qna.model.vo.Market_qna;

public interface MarketService {

	ArrayList<Market> selectMarketList(int page,String search,String ctype);
	
	
	Market selectMarketInfo(int market_no);

	ArrayList<Review> selectReviewList(Market mk, int currentPage);

	int selectReviewCount(Market mk);
	int insertMarket(Market market);

	int insertMarket_qna(Market_qna qna);

	int insertReview(Review rv);

	ArrayList<Daily> selectDailyList(Market market);

	int insertMarket_daily(Daily daily);

	ArrayList<Market> selectHomeNewMarketList();

	ArrayList<Market> selectHomePopularMarketList();


	Review selectReviewDetail(int review_no);

	Daily selectDailyDetail(int daily_no);

	Market selectSearchList(String search);
	ArrayList<Reply> selectReviewReply(int review_no,int currentPage);

	int selectReviewReplyCount(int review_no);

	ArrayList<UnderReply> selectReviewUnderReply(HashMap<String, ArrayList<Integer>> map);

	ArrayList<Reply> selectDailyReply(int daily_no, int currentPage);

	int selectDailyReplyCount(int daily_no);

	ArrayList<UnderReply> selectDailyUnderReply(HashMap<String, ArrayList<Integer>> map);

	int insertReply(Reply reply);

	int insertUnderReply(UnderReply reply);

	int deleteReply(Reply reply) throws DeleteFailException;

	int deleteUnderReply(UnderReply reply);

	int updateReplyNull(Reply reply);


}
