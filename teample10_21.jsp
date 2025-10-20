<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>중고모아</title>
    <style>
        /* CSS는 그대로 유지 */
        body {
            margin: 0;
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f9f9f9;
            color: #333;
        }
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 40px;
            background-color: #ffffff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .logo {
            font-size: 24px;
            font-weight: bold;
            color: #2c7be5;
        }
        .header-links a {
            margin-left: 20px;
            text-decoration: none;
            color: #555;
            font-size: 14px;
        }
        .search-bar {
            display: flex;
            justify-content: center;
            margin: 30px 0;
        }
        .search-bar input {
            width: 500px;
            padding: 12px 16px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 16px;
        }
        .swipe-image {
            width: 100%;
            height: 300px;
            background-color: #ddd;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 24px;
            color: #666;
        }
        .recommend-section {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }
        .recommend-section h2 {
            font-size: 20px;
            margin-bottom: 20px;
            color: #333;
        }
        .product-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }
        .product-card {
            background-color: #fff;
            border: 1px solid #eee;
            border-radius: 8px;
            height: 200px;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #aaa;
            font-size: 14px;
        }
        footer {
            background-color: #f1f1f1;
            padding: 40px;
            display: flex;
            justify-content: space-between;
            font-size: 14px;
            color: #555;
        }
        .footer-section h4 {
            margin-bottom: 10px;
            font-weight: bold;
        }
        .footer-section p,
        .footer-section a {
            margin: 4px 0;
            text-decoration: none;
            color: #555;
        }
    </style>
</head>
<body>
    <header>
        <div class="logo">
    		<img src="images/logo.png" style="height: 60px; width: 200">
		</div>
        <div class="header-links">
            <input type="button" value="로그인/회원가입" onclick="location.href='loginpage.jsp'">
            <input type="button" value="내상점" onclick="location.href='mystore.jsp'">
            <input type="button" value="" onclick="location.href='loginpage.jsp'"
       			style="background: url('images/bell.png') no-repeat center;
              	background-size: contain;
              	width: 40px; height: 40px; border: none; cursor: pointer;" />

        </div>
    </header>
    <div class="search-bar">
        <!-- 검색창과 지우기 버튼 -->
	<div style="position: relative; display: inline-block;">
  		<input type="text" id="searchInput" placeholder="검색어를 입력하세요" />

  		<!-- 지우기 버튼 -->
  		<button type="button"
          	onclick="document.getElementById('searchInput').value=''"
          	style="
            	position: absolute;
            	right: 5px;
            	top: 50%;
            	transform: translateY(-50%);
            	background: none;
            	border: none;
            	font-size: 16px;
            	cursor: pointer;
            	padding: 0;
            	line-height: 1;
          			"
          	aria-label="지우기">
    			✕
  			</button>
		</div>

            
        <slot name="start"></slot>
    
            <span class="content" part="content">
                <slot></slot>
            </span>
            
        <slot name="end"></slot>
    
        </button>
    </div>
    <div class="swipe-image">스와이프 이미지</div>
    <section class="recommend-section">
        <h2>상품 추천</h2>
        <div class="product-grid">
            <%-- 반복문으로 상품 카드 출력 가능 --%>
            <% for (int i = 0; i < 8; i++) { %>
                <div class="product-card">상품 추천 이미지</div>
            <% } %>
        </div>
    </section>
    <footer>
        <div class="footer-section">
            <img src="images/logo2.png" style="height: 80px; width: 200px; float: left;" />
            <p>(주) 중고모아 | 대표 김령균</p>
            <p>TEL : 010-0000-0000</p>
            <p>Mail : junggomoa@gmail.com</p>
            <p>주소 : 경기도 xx시 xx구 xx로 xx번</p>
            <p>이용약관 / 개인정보처리방침</p>
        </div>
        <%
    // 필요한 경우 서버에서 동적으로 텍스트를 설정할 수 있습니다
    	String companyIntro = "회사소개";
    	String notice = "공지사항";
    	String question = "1:1 문의";
    	String faq = "FAQ";
		%>

		<!-- 푸터 섹션 -->
		<div style="display: flex; gap: 40px;">
    		<!-- ABOUT 섹션 -->
    		<div class="footer-section">
        		<h4>ABOUT</h4>
        		<a href="#"> <%= companyIntro %> </a><br>
        		<a href="#"> <%= notice %> </a><br>
    		</div>

    		<!-- CONTACT 섹션 -->
    		<div class="footer-section">
        		<h4>SUPPORT</h4>
        		<a href="#"> <%= question %> </a><br>
        		<a href="#"> <%= faq %> </a>
    		</div>
		</div>
        
    </footer>
</body>