package com.example.Service;

import com.example.models.Detective;
import com.example.utils.DBUtil;

import java.sql.*;

public class DetectiveService {

    public Detective getDetectiveById(int id) throws SQLException {
        String sql = "SELECT Detective_id, First_name, Last_name, Email, Number, Access_Level, image_url, hide_image FROM detective WHERE Detective_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
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
            }
        }
        return null;
    }

    public boolean updateProfileImageAndVisibility(int detectiveId, String imageUrl, boolean hideImage) throws SQLException {
        String sql = "UPDATE detective SET image_url = ?, hide_image = ? WHERE Detective_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, imageUrl);
            stmt.setBoolean(2, hideImage);
            stmt.setInt(3, detectiveId);

            return stmt.executeUpdate() > 0;
        }
    }
}
