package com.example.Service;

import com.example.models.Detective;
import com.example.utils.DBUtil;
import com.example.utils.PasswordUtil;

import java.sql.*;

public class LoginService {

    public static Detective authenticate(String email, String rawPassword) throws SQLException {
        String hashedPassword = PasswordUtil.hashPassword(rawPassword);

        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT Detective_id, First_name, Last_name, Email, Number, Access_Level, image_url, hide_image " +
                         "FROM detective WHERE Email = ? AND Password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, hashedPassword);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Detective detective = new Detective();
                detective.setId(rs.getInt("Detective_id"));
                detective.setFirstName(rs.getString("First_name"));
                detective.setLastName(rs.getString("Last_name"));
                detective.setEmail(rs.getString("Email"));
                detective.setNumber(rs.getString("Number"));
                detective.setLevel(rs.getInt("Access_Level"));
                detective.setImageUrl(rs.getString("image_url"));
                detective.setHideImage(rs.getBoolean("hide_image"));

                return detective;
            } else {
                return null;
            }
        }
    }
}
