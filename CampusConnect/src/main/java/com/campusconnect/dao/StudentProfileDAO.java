package com.campusconnect.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.campusconnect.model.StudentProfile;
import com.campusconnect.util.DBConnection;

public class StudentProfileDAO {


    // =========================================================
    // GET PROFILE
    // =========================================================

    public StudentProfile getProfileByUserId(int userId) {

        String sql =
                "SELECT * FROM student_profile WHERE user_id = ?";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                StudentProfile profile = new StudentProfile();

                profile.setProfileId(
                    rs.getInt("profile_id")
                );

                profile.setUserId(
                    rs.getInt("user_id")
                );

                profile.setSkills(
                    rs.getString("skills")
                );

                profile.setEducation(
                    rs.getString("education")
                );

                profile.setResumePath(
                    rs.getString("resume_path")
                );

                profile.setPhone(
                    rs.getString("phone")
                );

                profile.setLocation(
                    rs.getString("location")
                );

                profile.setBio(
                    rs.getString("bio")
                );

                profile.setGithubLink(
                    rs.getString("github_link")
                );

                profile.setLinkedinLink(
                    rs.getString("linkedin_link")
                );

                return profile;
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // CREATE PROFILE
    // =========================================================

    public boolean createProfile(StudentProfile profile) {

        String sql =
                "INSERT INTO student_profile "
              + "(user_id, skills, education, resume_path, "
              + "phone, location, bio, github_link, linkedin_link) "
              + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setInt(
                1,
                profile.getUserId()
            );

            ps.setString(
                2,
                profile.getSkills()
            );

            ps.setString(
                3,
                profile.getEducation()
            );

            ps.setString(
                4,
                profile.getResumePath()
            );

            ps.setString(
                5,
                profile.getPhone()
            );

            ps.setString(
                6,
                profile.getLocation()
            );

            ps.setString(
                7,
                profile.getBio()
            );

            ps.setString(
                8,
                profile.getGithubLink()
            );

            ps.setString(
                9,
                profile.getLinkedinLink()
            );

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // UPDATE PROFILE
    // =========================================================

    public boolean updateProfile(StudentProfile profile) {

        String sql =
                "UPDATE student_profile SET "
              + "skills = ?, "
              + "education = ?, "
              + "resume_path = ?, "
              + "phone = ?, "
              + "location = ?, "
              + "bio = ?, "
              + "github_link = ?, "
              + "linkedin_link = ? "
              + "WHERE user_id = ?";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setString(
                1,
                profile.getSkills()
            );

            ps.setString(
                2,
                profile.getEducation()
            );

            ps.setString(
                3,
                profile.getResumePath()
            );

            ps.setString(
                4,
                profile.getPhone()
            );

            ps.setString(
                5,
                profile.getLocation()
            );

            ps.setString(
                6,
                profile.getBio()
            );

            ps.setString(
                7,
                profile.getGithubLink()
            );

            ps.setString(
                8,
                profile.getLinkedinLink()
            );

            ps.setInt(
                9,
                profile.getUserId()
            );

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return false;
    }
}