package com.example.Service;

import com.example.utils.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UpdateMostWantedService {

    public static boolean updateCriminal(String name, String charges, String lastSeen, String description) {

        String sql = "UPDATE `most-wanted` SET Charges = ?, Last_seen = ?, Criminal_info = ? WHERE Criminal_name = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, charges);
            stmt.setString(2, lastSeen);
            stmt.setString(3, description);
            stmt.setString(4, name);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
