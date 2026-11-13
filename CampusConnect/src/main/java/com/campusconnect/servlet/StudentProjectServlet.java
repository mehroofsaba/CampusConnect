package com.campusconnect.servlet;

import java.io.IOException;
import java.net.URI;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.campusconnect.dao.StudentProjectDAO;
import com.campusconnect.model.StudentProject;
import com.campusconnect.model.User;

@WebServlet("/studentProjects")
public class StudentProjectServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        User user = session == null
                ? null
                : (User) session.getAttribute("user");

        if (user == null || !"STUDENT".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        request.setCharacterEncoding("UTF-8");

        StudentProjectDAO dao = new StudentProjectDAO();

        String action = trim(request.getParameter("action"));

        boolean success = false;

        if ("add".equals(action) || "update".equals(action)) {

            String title = trim(request.getParameter("projectTitle"));
            String description = trim(request.getParameter("description"));
            String technologies = trim(request.getParameter("technologies"));
            String link = trim(request.getParameter("projectLink"));

            if (title.isEmpty() || title.length() > 150
                    || technologies.length() > 500
                    || link.length() > 500) {

                response.sendRedirect(
                    request.getContextPath()
                    + "/studentProfile?projectError=invalid"
                );
                return;
            }

            if (!validOptionalUrl(link)) {
                response.sendRedirect(
                    request.getContextPath()
                    + "/studentProfile?projectError=url"
                );
                return;
            }

            StudentProject project = new StudentProject();

            project.setUserId(user.getUserId());
            project.setProjectTitle(title);
            project.setDescription(description);
            project.setTechnologies(technologies);
            project.setProjectLink(link);

            if ("add".equals(action)) {

                success = dao.addProject(project);

            } else {

                try {

                    int projectId = Integer.parseInt(
                        request.getParameter("projectId")
                    );

                    project.setProjectId(projectId);

                    success = dao.updateProject(project);

                } catch (NumberFormatException e) {
                    success = false;
                }
            }

        } else if ("delete".equals(action)) {

            try {

                int projectId = Integer.parseInt(
                    request.getParameter("projectId")
                );

                success = dao.deleteProject(
                    projectId,
                    user.getUserId()
                );

            } catch (NumberFormatException e) {
                success = false;
            }
        }

        String status = success ? "success" : "failed";

        response.sendRedirect(
            request.getContextPath()
            + "/studentProfile?projectStatus=" + status
        );
    }


    private String trim(String value) {
        return value == null ? "" : value.trim();
    }


    private boolean validOptionalUrl(String value) {

        if (value.isEmpty()) {
            return true;
        }

        try {

            URI uri = new URI(value);

            String scheme = uri.getScheme();

            return uri.getHost() != null
                    && scheme != null
                    && ("http".equalsIgnoreCase(scheme)
                    || "https".equalsIgnoreCase(scheme));

        } catch (Exception e) {
            return false;
        }
    }
}