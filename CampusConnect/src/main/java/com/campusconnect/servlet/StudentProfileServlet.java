package com.campusconnect.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.campusconnect.dao.StudentProfileDAO;
import com.campusconnect.dao.StudentProjectDAO;
import com.campusconnect.model.StudentProfile;
import com.campusconnect.model.StudentProject;
import com.campusconnect.model.User;

@WebServlet("/studentProfile")
public class StudentProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        User user = session == null
                ? null
                : (User) session.getAttribute("user");

        if (user == null || !"STUDENT".equals(user.getRole())) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");
            return;
        }

        StudentProfileDAO profileDAO = new StudentProfileDAO();

        StudentProfile profile =
                profileDAO.getProfileByUserId(user.getUserId());

        request.setAttribute("profile", profile);

        StudentProjectDAO projectDAO = new StudentProjectDAO();

        List<StudentProject> projects =
                projectDAO.getProjectsByUserId(user.getUserId());

        request.setAttribute("projects", projects);

        request.getRequestDispatcher("/studentProfile.jsp")
               .forward(request, response);
    }
}