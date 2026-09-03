package com.campusconnect.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.campusconnect.dao.ApplicationDAO;

@WebServlet("/applicationStatus")
public class ApplicationStatusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        int appId = Integer.parseInt(
                request.getParameter("appId")
        );

        String status = request.getParameter("status");

        ApplicationDAO dao = new ApplicationDAO();

        boolean updated =
                dao.updateApplicationStatus(appId, status);

        if (updated) {
            response.sendRedirect("companyapplications");
        } else {
            response.sendRedirect("companyapplications");
        }
    }
}