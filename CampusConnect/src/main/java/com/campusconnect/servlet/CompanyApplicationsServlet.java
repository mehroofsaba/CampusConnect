package com.campusconnect.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.campusconnect.dao.ApplicationDAO;
import com.campusconnect.model.Application;
import com.campusconnect.model.User;

@WebServlet("/companyapplications")
public class CompanyApplicationsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        // Check whether company is logged in
        if (user == null || !"COMPANY".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get logged in UserId
        int userId = user.getUserId();

        // Get applications
        ApplicationDAO applicationDAO = new ApplicationDAO();

        List<Application> applications =
                applicationDAO.getApplicationsByCompany(userId);

        // Send applications to JSP
        request.setAttribute("applications", applications);

        // Open applicants page
        request.getRequestDispatcher("viewApplicants.jsp")
               .forward(request, response);
    }
}