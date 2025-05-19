package com.example.Service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.example.utils.DBUtil;

public class AddInmateService {

    public static boolean addInmate(String name, String charges, String sentence, String info, String behavior, String mentalState) {

        String sql = "INSERT INTO `in-custody` (Prisioner_name, Prisioner_charges, Prisioner_sentence, Prisioner_info, Prisioner_behaviour, Prisioner_mentalstate) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, name);
            stmt.setString(2, charges);
            stmt.setString(3, sentence);
            stmt.setString(4, info);
            stmt.setString(5, behavior);
            stmt.setString(6, mentalState);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
