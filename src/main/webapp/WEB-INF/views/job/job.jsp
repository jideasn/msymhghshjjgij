<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<script src="/farm/resources/js/jquery-3.3.1.min.js"></script>
<script>
	function job_write() {
		location.href = "/farm/moveJobMake.do";
	}
	$(function() {
		$
				.ajax({
					url : "jobList.do",
					type : "post",
					dataType : "json",
					success : function(data) {
						var jsonStr = JSON.stringify(data);
						var json = JSON.parse(jsonStr);
						var values = "<tr><th width='10%'>번호</th><th width='12%'>상태</th><th width='45%'>제목</th><th width='13%'>작성자</th><th width='20%'>날짜</th></tr>";

						for ( var i in json.list) {
							values += "<tr id='hover'><td>" + json.list[i].rnum
									+ "</td>";
							if (json.list[i].job_status == "1") {
								values += "<td><span id='job_table_span_find'><strong>구인중</strong></span></td>";
							} else {
								values += "<td><span id='job_table_span_finded'>마감</span></td>";
							}

							values += "<td id='job_td'><a href='jobDetail.do?job_no="
									+ json.list[i].job_no
									+ "'>"
									+ json.list[i].job_title
									+ "</a></td><td>"
									+ json.list[i].member_id
									+ "</td><td>"
									+ json.list[i].job_date + "</td></tr>";
						}
						$(".job_table").html(values);

						var startPage = json.list[0].startPage;
						var endPage = json.list[0].endPage;
						var maxPage = json.list[0].maxPage;
						var currentPage = json.list[0].currentPage;

						var values1 = "";
						if (startPage > 5) {
							values1 += "<a href='javascript:jobPage("
									+ (startPage - 1) + ")'>&laquo;</a>"
						} else {
							values1 += "<a>&laquo;</a>";
						}
						for (var i = startPage; i <= endPage; i++) {
							if (i == currentPage) {
								values1 += "<a class='active'>" + i + "</a>";
							} else {
								values1 += "<a href='javascript:jobPage(" + i
										+ ");'>" + i + "</a>";
							}
						}
						if (endPage < maxPage) {
							values1 += "<a href='javascript:jobPage("
									+ (endPage + 1) + ")'>&raquo;</a>";

						} else {
							values1 += "<a>&raquo;</a>";
						}
						$(".pagination").html(values1);
					},
					error : function(request, status, errorData) {
						alert("error code : " + request.status + "\nmessage"
								+ request.responseText + "\nerror" + errorData);
					}

				});

	});
	function jobPage(page) {
		$
				.ajax({
					url : "jobList.do",
					type : "post",
					data : {
						page : page
					},
					dataType : "json",
					success : function(data) {
						var jsonStr = JSON.stringify(data);
						var json = JSON.parse(jsonStr);
						var values = "<tr><th width='10%'>번호</th><th width='12%'>상태</th><th width='45%'>제목</th><th width='13%'>작성자</th><th width='20%'>날짜</th></tr>";

						for ( var i in json.list) {
							values += "<tr id='hover'><td>" + json.list[i].rnum
									+ "</td>";
							if (json.list[i].job_status == "1") {
								values += "<td><span id='job_table_span_find'><strong>구인중</strong></span></td>";
							} else {
								values += "<td><span id='job_table_span_finded'>마감</span></td>";
							}

							values += "<td id='job_td'><a href='jobDetail.do?job_no="
									+ json.list[i].job_no
									+ "'>"
									+ json.list[i].job_title
									+ "</a></td><td>"
									+ json.list[i].member_id
									+ "</td><td>"
									+ json.list[i].job_date + "</td></tr>";
						}
						$(".job_table").html(values);

						var startPage = json.list[0].startPage;
						var endPage = json.list[0].endPage;
						var maxPage = json.list[0].maxPage;
						var currentPage = json.list[0].currentPage;

						var values1 = "";
						if (startPage > 5) {
							values1 += "<a href='javascript:jobPage("
									+ (startPage - 1) + ")'>&laquo;</a>"
						} else {
							values1 += "<a>&laquo;</a>";
						}
						for (var i = startPage; i <= endPage; i++) {
							if (i == currentPage) {
								values1 += "<a class='active'>" + i + "</a>";
							} else {
								values1 += "<a href='javascript:jobPage(" + i
										+ ");'>" + i + "</a>";
							}
						}
						if (endPage < maxPage) {
							values1 += "<a href='javascript:jobPage("
									+ (endPage + 1) + ")'>&raquo;</a>";

						} else {
							values1 += "<a>&raquo;</a>";
						}
						$(".pagination").html(values1);
					},
					error : function(request, status, errorData) {
						alert("error code : " + request.status + "\nmessage"
								+ request.responseText + "\nerror" + errorData);
					}

				});
	}
</script>
<!-- Job.css -->
<link rel="stylesheet" type="text/css"
	href="/farm/resources/css/style.css" />
<link rel="stylesheet" type="text/css"
	href="/farm/resources/css/job.css" />
<meta charset="UTF-8">
<title>Farm 구인구직</title>
</head>
<body>
	<div id="top_line"></div>
	<div id="wrap">
		<div id="header">
			<%@ include file="../inc/header.jsp"%>
		</div>
		<div id="container">
			<div class="inner-wrap">
				<div class="board-wrap">
					<div id="top">
						<div class="Job_title">구인구직</div>

						<!-- select box -->
						<div class="select_box">
							<c:if test="${loginUser.member_category eq '0'}">
								<button class="job_w" onclick="job_write();"
									style="background-color: white; color: #f1473a; border: 1px solid #f1473a; padding: 6px 6px 6px;">구인구직등록
								</button>
							</c:if>
							<select class="select">
								<option value="1" selected="">최근등록순</option>
								<option value="2">좋아요많은순</option>
								<option value="3">조회많은순</option>
							</select>
						</div>
					</div>

					<!-- 왼쪽 지역 박스 -->
					<br> <br> <br> <br>

					<!--  -->
					<div id="sort_all">
						<div class="sort" style="padding-left: 10px;">
							<h4>지역별</h4>
							<table id="left_area_table" style="text-align: center;">
								<tr>
									<td><a href="#">서울&nbsp;</a></td>
									<td><a href="#">경기&nbsp;</a></td>
								</tr>
								<tr>
									<td><a href="#">인천&nbsp;</a></td>
									<td><a href="#">강원&nbsp;</a></td>
								</tr>
								<tr>
									<td><a href="#">대전&nbsp;</a></td>
									<td><a href="#">세종&nbsp;</a></td>
								</tr>
								<tr>
									<td><a href="#">충남&nbsp;</a></td>
									<td><a href="#">충북&nbsp;</a></td>
								</tr>
								<tr>
									<td><a href="#">부산&nbsp;</a></td>
									<td><a href="#">울산&nbsp;</a></td>
								</tr>
								<tr>
									<td><a href="#">경남&nbsp;</a></td>
									<td><a href="#">경북&nbsp;</a></td>
								</tr>
								<tr>
									<td><a href="#">대구&nbsp;</a></td>
									<td><a href="#">광주&nbsp;</a></td>
								</tr>
								<tr>
									<td><a href="#">전남&nbsp;</a></td>
									<td><a href="#">전북&nbsp;</a></td>
								</tr>
								<tr>
									<td><a href="#">제주&nbsp;</a></td>
									<td><a href="#">전국&nbsp;</a></td>
								</tr>
							</table>

						</div>

						<!-- <hr style="clear:both"> -->
						<!-- 왼쪽 밑 지역구 박스 -->
						<br>
						<div class="sort2" style="padding-left: 5px;">
							<h4>권역별</h4>
							<table id="left_area_table2" style="text-align: center;">
								<tr>
									<td><a href="#">강남&nbsp;</a></td>
									<td><a href="#">강동&nbsp;</a></td>
								</tr>
								<tr>
									<td><a href="#">강북&nbsp;</a></td>
									<td><a href="#">강서&nbsp;</a></td>
								</tr>
								<tr>
									<td><a href="#">관악&nbsp;</a></td>
									<td><a href="#">광진&nbsp;</a></td>
								</tr>
								<tr>
									<td><a href="#">구로&nbsp;</a></td>
									<td><a href="#">금천&nbsp;</a></td>
								</tr>
								<tr>
									<td><a href="#">노원&nbsp;</a></td>
									<td><a href="#">도봉&nbsp;</a></td>
								</tr>
								<tr>
									<td><a href="#">동대문&nbsp;</a></td>
									<td><a href="#">동작&nbsp;</a></td>
								</tr>
								<tr>
									<td><a href="#">마포&nbsp;</a></td>
									<td><a href="#">서대문&nbsp;</a></td>
								</tr>
								<tr>
									<td><a href="#">서초&nbsp;</a></td>
									<td><a href="#">성동&nbsp;</a></td>
								</tr>
								<tr>
									<td><a href="#">성북&nbsp;</a></td>
									<td><a href="#">송파&nbsp;</a></td>
								</tr>
								<tr>
									<td><a href="#">양천&nbsp;</a></td>
									<td><a href="#">영등포&nbsp;</a></td>
								</tr>
								<tr>
									<td><a href="#">용산&nbsp;</a></td>
									<td><a href="#">은평구&nbsp;</a></td>
								</tr>
								<tr>
									<td><a href="#">종로&nbsp;</a></td>
									<td><a href="#">중구&nbsp;</a></td>
								</tr>
								<tr>
									<td><a href="#">중량&nbsp;</a></td>
								</tr>
							</table>

						</div>
					</div>

					<!--  -->
					<div id="table_div">
						<table class="job_table">
							<!--  <tr>
                     <th width="10%">번호</th>
                     <th width="12%">상태</th>
                     <th width="45%">제목</th>
                     <th width="13%">작성자</th>
                     <th width="20%">날짜</th>
                  </tr>
                  <tr id="hover">
                     <td>1</td>
                     <td><span id="job_table_span_find"><strong>구인중</strong></span></td>
                     <td id="job_td"><a href="moveJobDetail.do">딸기농장_01</a></td>
                     <td>김민선</td>
                     <td>2018-05-08</td>
                  </tr>
                  <tr id="hover">
                     <td>2</td>
                     <td>구인중</td>
                     <td id="job_td"><a href="moveJobDetail.do">딸기농장_02</a></td>
                     <td>김민선</td>
                     <td>2018-05-08</td>
                  </tr>
                  <tr id="hover">
                     <td>3</td>
                     <td>구인중</td>
                     <td id="job_td"><a href="moveJobDetail.do">딸기농장_03</a></td>
                     <td>김민선</td>
                     <td>2018-05-08</td>
                  </tr>
                  <tr>
                     <td>4</td>
                     <td>구인중</td>
                     <td id="job_td"><a href="moveJobDetail.do">딸기농장_04</a></td>
                     <td>김민선</td>
                     <td>2018-05-08</td>
                  </tr>
                  <tr>
                     <td>5</td>
                     <td>구인중</td>
                     <td id="job_td"><a href="moveJobDetail.do">딸기농장_05</a></td>
                     <td>김민선</td>
                     <td>2018-05-08</td>
                  </tr>
                  <tr>
                     <td>6</td>
                     <td>구인중</td>
                     <td id="job_td"><a href="moveJobDetail.do">딸기농장_06</a></td>
                     <td>김민선</td>
                     <td>2018-05-08</td>
                  </tr>
                  <tr>
                     <td>7</td>
                     <td>구인중</td>
                     <td id="job_td"><a href="moveJobDetail.do">딸기농장_07</a></td>
                     <td>김민선</td>
                     <td>2018-05-08</td>
                  </tr>
                  <tr>
                     <td>8</td>
                     <td>구인중</td>
                     <td id="job_td"><a href="moveJobDetail.do">딸기농장_08</a></td>
                     <td>김민선</td>
                     <td>2018-05-08</td>
                  </tr>
                  <tr>
                     <td>9</td>
                     <td><span id="job_table_span_finded">마감</span></td>
                     <td id="job_td"><a href="moveJobDetail.do">딸기농장_09</a></td>
                     <td>김민선</td>
                     <td>2018-05-08</td>
                  </tr>
                  <tr>
                     <td>10</td>
                     <td>마감</td>
                     <td id="job_td"><a href="moveJobDetail.do">딸기농장_10</a></td>
                     <td>김민선</td>
                     <td>2018-05-08</td>
                  </tr> -->
						</table>
					</div>

					<!-- 하단 페이징, 검색 묶음 -->
					<div id="bottom">
						<!-- 페이징 처리 -->
						<div class="pagination">
							<!--  <a href="#">&laquo;</a> <a href="#">1</a> <a href="#"
                     class="active">2</a> <a href="#">3</a> <a href="#">4</a> <a
                     href="#">5</a> <a href="#">&raquo;</a> -->
						</div>

						<!-- 검색 -->
						<div class="search_box">
							<span class='green_window'> <input type='text'
								class='input_text' />
							</span>
							<button type='submit' class='sch_smit'>검색</button>
						</div>
					</div>

				</div>
			</div>
		</div>
		<!-- container끝 -->
		<%@ include file="../messenger/msg_box.jsp"%>
		<div id="footer">
			<%@  include file="../inc/foot.jsp"%>
		</div>
	</div>
	<!-- wrap끝  -->
</body>
</html>