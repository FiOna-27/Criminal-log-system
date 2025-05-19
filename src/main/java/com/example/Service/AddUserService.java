package com.example.Service;

import com.example.utils.DBUtil;
import com.example.utils.PasswordUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AddUserService {

    public static boolean addUser(String firstName, String lastName, String number, String email, String password) {
        String hashedPassword = PasswordUtil.hashPassword(password);

        String sql = "INSERT INTO detective (First_name, Last_name, Number, Email, Password) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, firstName);
            stmt.setString(2, lastName);
            stmt.setString(3, number);
            stmt.setString(4, email);
            stmt.setString(5, hashedPassword);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}