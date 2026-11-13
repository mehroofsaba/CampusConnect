package com.campusconnect.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.campusconnect.model.StudentProject;
import com.campusconnect.util.DBConnection;

public class StudentProjectDAO {

    // GET ALL PROJECTS OF A STUDENT
    public List<StudentProject> getProjectsByUserId(int userId) {

        List<StudentProject> projects = new ArrayList<>();

        String sql = "SELECT * FROM student_projects "
                   + "WHERE user_id = ? ORDER BY created_at DESC";

        Connection conn = DBConnection.getConnection();

        if (conn == null) {
            return projects;
        }

        try (Connection connection = conn;
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    StudentProject project = new StudentProject();

                    project.setProjectId(rs.getInt("project_id"));
                    project.setUserId(rs.getInt("user_id"));
                    project.setProjectTitle(rs.getString("project_title"));
                    project.setDescription(rs.getString("description"));
                    project.setTechnologies(rs.getString("technologies"));
                    project.setProjectLink(rs.getString("project_link"));
                    project.setCreatedAt(rs.getTimestamp("created_at"));

                    projects.add(project);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return projects;
    }

    // ADD PROJECT
    public boolean addProject(StudentProject project) {

        String sql = "INSERT INTO student_projects "
                   + "(user_id, project_title, description, "
                   + "technologies, project_link) "
                   + "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection()) {

            if (conn == null) {
                return false;
            }

            try (PreparedStatement ps = conn.prepareStatement(sql)) {

                ps.setInt(1, project.getUserId());
                ps.setString(2, project.getProjectTitle());
                ps.setString(3, project.getDescription());
                ps.setString(4, project.getTechnologies());
                ps.setString(5, project.getProjectLink());

                return ps.executeUpdate() > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // UPDATE PROJECT
    // Ownership is checked using both project_id and user_id.
    public boolean updateProject(StudentProject project) {

        String sql = "UPDATE student_projects SET "
                   + "project_title = ?, description = ?, "
                   + "technologies = ?, project_link = ? "
                   + "WHERE project_id = ? AND user_id = ?";

        try (Connection conn = DBConnection.getConnection()) {

            if (conn == null) {
                return false;
            }

            try (PreparedStatement ps = conn.prepareStatement(sql)) {

                ps.setString(1, project.getProjectTitle());
                ps.setString(2, project.getDescription());
                ps.setString(3, project.getTechnologies());
                ps.setString(4, project.getProjectLink());
                ps.setInt(5, project.getProjectId());
                ps.setInt(6, project.getUserId());

                return ps.executeUpdate() > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // DELETE PROJECT
    // A student can delete only their own project.
    public boolean deleteProject(int projectId, int userId) {

        String sql = "DELETE FROM student_projects "
                   + "WHERE project_id = ? AND user_id = ?";

        try (Connection conn = DBConnection.getConnection()) {

            if (conn == null) {
                return false;
            }

            try (PreparedStatement ps = conn.prepareStatement(sql)) {

                ps.setInt(1, projectId);
                ps.setInt(2, userId);

                return ps.executeUpdate() > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}