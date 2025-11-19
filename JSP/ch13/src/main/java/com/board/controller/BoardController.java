package com.board.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.board.dao.*;
import com.board.dto.*;


@WebServlet("/")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public BoardController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		String conPath = request.getContextPath();
		String com = uri.substring(conPath.length());
		
		String view = null;
		
		if(com.equals("/list") || com.equals("/")) {
			//게시글이 담긴 DTO객체들의 리스트를 얻음
			request.setAttribute("msgList", new BoardDao().selectList());
			
			view = "list.jsp";
		}else if (com.equals("/view")) {
	    	int num = Integer.parseInt(request.getParameter("num"));
	    	BoardDto dto = new BoardDao().selectOne(num, true);
	    	
	    	
	    	dto.setTitle(dto.getTitle().replace (" ", "&nbsp;"));
			dto.setContent(dto.getContent().replace (" ", "&nbsp;").replace("\n", "<br>"));
			
			request.setAttribute("msg", dto);
			
			view = "view.jsp";
			
		}else if (com.equals("/write")) {
			String tmp = request.getParameter("num");
			int num = (tmp != null && tmp.length() > 0) ? Integer.parseInt(tmp) : 0;

			BoardDto dto = new BoardDto();
			String action = "insert";

			if(num > 0) { // 글번호가 주어졌으면 DB에서 데이터를 읽어옴
				dto = new BoardDao().selectOne(num, false);
				action = "update?num=" + num;
				
			}
			
			request.setAttribute("msg", dto);
			request.setAttribute("action", action);
			
			view = "write.jsp";
		}else if (com.equals("/insert")) {

			String writer = request.getParameter("writer");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			
			if(writer != null && writer.length() > 0 &&
					title != null && title.length() > 0 &&
					content != null && content.length() > 0) { //교재와 반대 조건 : 만약 빈칸이 하나도 없으면 

				BoardDto dto = new BoardDto();
				
				dto.setWriter(writer);
				dto.setTitle(title);
				dto.setContent(content);
			    
				new BoardDao().insertOne(dto);
				
				view = "redirect: list";
			}else {
				request.setAttribute("errorMessage", "모든 항목이 빈칸없이 입력되어야 합니다.");
				
				view = "errorBack.jsp";
			}
			
		}else if (com.equals("/b")) {
			view = "redirect: b.jsp";
		}else {
			response.getWriter().append("Invaild URL");
		}
		if(view.startsWith("redirect:")) {
			response.sendRedirect(view.substring(9));
		}else {
			request.getRequestDispatcher(view).forward(request, response);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
