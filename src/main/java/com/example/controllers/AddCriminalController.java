package com.example.controllers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.example.utils.DBUtil;

public class AddCriminalController {
	
	public static boolean addWanted(String Criminal_Name, String Charges, String Last_seen, String Criminal_info) {

        String sql = "INSERT INTO `most-wanted` (Criminal_name, Charges, Last_seen, Criminal_info) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, Criminal_Name);
            stmt.setString(2, Charges);
            stmt.setString(3, Last_seen);
            stmt.setString(4, Criminal_info);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
