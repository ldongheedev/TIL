package com.board.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.board.dao.*;
import com.board.dto.*;
import com.board.service.*;


@WebServlet("/")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public BoardController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BoardService svc = new BoardService();
		
		String uri = request.getRequestURI();
		String conPath = request.getContextPath();
		String com = uri.substring(conPath.length());
		
		String view = null;
		
		if(com.equals("/list") || com.equals("/")) {
			
			String tmp = request.getParameter("page");
			int pageNo = (tmp != null && tmp.length() > 0) ? Integer.parseInt(tmp) : 1;
			
			//게시글이 담긴 DTO객체들의 리스트를 얻음
			request.setAttribute("msgList", svc.getMsgList(pageNo));
			request.setAttribute("pgnList", svc.getPagination(pageNo));
			request.setAttribute("page", pageNo);
			
			view = "list.jsp";
		}else if (com.equals("/view")) {
	    	int num = Integer.parseInt(request.getParameter("num"));
	    	
	    	request.setAttribute("msg", svc.getMsg(num));
			
			view = "view.jsp";
			
		}else if (com.equals("/write")) {
			String tmp = request.getParameter("num");
			int num = (tmp != null && tmp.length() > 0) ? Integer.parseInt(tmp) : 0;

			BoardDto dto = new BoardDto();
			String action = "insert";

			if(num > 0) { // 글번호가 주어졌으면 DB에서 데이터를 읽어옴
				int pageNo = Integer.parseInt(request.getParameter("page"));
				action = "update?num=" + num;
				
			}
			
			request.setAttribute("msg", svc.getMsgWrite(num));
			request.setAttribute("action", action);
			
			view = "write.jsp";
		}else if (com.equals("/insert")) {

			String writer = request.getParameter("writer");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			try {
				svc.writeMsg(writer, title, content);
				view = "redirect: list";
			} catch (Exception e) {
				request.setAttribute("errorMessage", e.getMessage());
				
				view = "errorBack.jsp";
			}
			
		}else if (com.equals("/update")) {
			
			int num = Integer.parseInt(request.getParameter("num"));

			String writer = request.getParameter("writer");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			try {
				svc.updateMsg(writer, title, content, num);
				int pageNo = Integer.parseInt(request.getParameter("page"));
				view = "redirect:view?num=" + num + "&page=" + pageNo;
			}catch(Exception e) {
				request.setAttribute("errorMessage", e.getMessage());
				
				view = "errorBack.jsp";
			}
		} else if (com.equals("/delete")) {
			int num = Integer.parseInt(request.getParameter("num"));
			int pageNo = Integer.parseInt(request.getParameter("page"));
			svc.deleteMsg(num);
			
			view = "redirect:list?page=" + pageNo;
		}
		
		else {
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
