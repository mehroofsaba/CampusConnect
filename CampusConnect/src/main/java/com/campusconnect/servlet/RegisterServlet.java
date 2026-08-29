package com.campusconnect.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.campusconnect.dao.UserDAO;
import com.campusconnect.model.User;
import com.campusconnect.dao.CompanyDAO;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    String name = request.getParameter("name");
	    String email = request.getParameter("email");
	    String password = request.getParameter("password");
	    String role = request.getParameter("role");

	    UserDAO userDAO = new UserDAO();

	    if (userDAO.emailExists(email)) {
	        request.setAttribute("error", "Email already registered!");
	        request.getRequestDispatcher("register.jsp").forward(request, response);
	        return;
	    }

	    User user = new User();
	    user.setName(name);
	    user.setEmail(email);
	    user.setPassword(password);
	    user.setRole(role);

	    boolean success = userDAO.registerUser(user);

	    if (success && "COMPANY".equals(role)) {
	        // Fetch the newly created user to get their generated user_id
	        User newUser = userDAO.login(email, password);
	        if (newUser != null) {
	            CompanyDAO companyDAO = new CompanyDAO();
	            companyDAO.createCompanyProfile(newUser.getUserId(), name); // using 'name' field as company name
	        }
	    }

	    if (success) {
	        request.setAttribute("message", "Registration successful! Please login.");
	        request.getRequestDispatcher("login.jsp").forward(request, response);
	    } else {
	        request.setAttribute("error", "Registration failed. Try again.");
	        request.getRequestDispatcher("register.jsp").forward(request, response);
	    }
	}
}
