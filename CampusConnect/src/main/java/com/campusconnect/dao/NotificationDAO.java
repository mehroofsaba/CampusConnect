package com.campusconnect.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.campusconnect.model.Notification;
import com.campusconnect.util.DBConnection;

public class NotificationDAO {

    // ADD NOTIFICATION
    public boolean addNotification(int userId, String message) {

        String sql = "INSERT INTO notifications (user_id, message) VALUES (?, ?)";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setInt(1, userId);
            ps.setString(2, message);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }


    // GET NOTIFICATIONS
    public List<Notification> getNotifications(int userId) {

        List<Notification> list = new ArrayList<>();

        String sql = "SELECT * FROM notifications WHERE user_id = ? " +
                     "ORDER BY created_at DESC";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Notification n = new Notification();

                n.setNotificationId(rs.getInt("notification_id"));
                n.setUserId(rs.getInt("user_id"));
                n.setMessage(rs.getString("message"));
                n.setRead(rs.getBoolean("is_read"));
                n.setCreatedAt(rs.getTimestamp("created_at"));

                list.add(n);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }


    // GET UNREAD COUNT
    public int getUnreadCount(int userId) {

        String sql = "SELECT COUNT(*) FROM notifications " +
                     "WHERE user_id = ? AND is_read = FALSE";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }


    // MARK ONE AS READ
    public boolean markAsRead(int notificationId, int userId) {

        String sql = "UPDATE notifications SET is_read = TRUE " +
                     "WHERE notification_id = ? AND user_id = ?";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setInt(1, notificationId);
            ps.setInt(2, userId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }


    // MARK ALL AS READ
    public boolean markAllAsRead(int userId) {

        String sql = "UPDATE notifications SET is_read = TRUE WHERE user_id = ?";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setInt(1, userId);

            ps.executeUpdate();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}