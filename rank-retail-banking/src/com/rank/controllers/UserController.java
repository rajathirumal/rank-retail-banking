package com.rank.controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.rank.beans.User;
import com.rank.services.Login;

/**
 * User Login and Logout controller
 */
@WebServlet("/UserController")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String userName = (String) request.getParameter("userName");
		String password = (String) request.getParameter("password");
		User newUser = new User(userName, password, null, 0);
		Login userLogin = new Login();
		
		try {
			newUser = userLogin.isValidUser(newUser);
			if (newUser != null) {
				HttpSession session = request.getSession();
				session.setAttribute("currentUser", newUser);
//				session.setAttribute("workGroup", newUser.getWorkGroup());
				response.sendRedirect("Dashboard.jsp");
			} else {
				response.setContentType("text/plain");
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write("failed");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher rd;
		String action = "";
		action = (String) request.getParameter("action");
		if (action != null && action.contentEquals("logout")) {
			Login logOut = new Login();
			HttpSession session = request.getSession();
			try {
				User user = (User) session.getAttribute("currentUser");
				logOut.updateLogoutInfo(user.getUserId());
			} catch (Exception e) {
				e.printStackTrace();
			}

			session.removeAttribute("currentUser");
			session.invalidate();
			rd = request.getRequestDispatcher("index.jsp");
			rd.forward(request, response);
		} else {
			rd = request.getRequestDispatcher("Dashboard.jsp");
			rd.forward(request, response);
		}

	}

}
