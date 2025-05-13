package com.example.utils;

import java.sql.*;
import java.util.*;

import com.example.models.Photo;

public class PhotoDAO {
    private Connection conn;

    public PhotoDAO(Connection conn) {
        this.conn = conn;
    }

    public List<Photo> getPhotosByDetectiveId(int detectiveId) throws SQLException {
        List<Photo> photos = new ArrayList<>();
        String sql = "SELECT p.photo_id, p.url FROM photo p " +
                     "JOIN detective_photo dp ON p.photo_id = dp.photo_id " +
                     "WHERE dp.detective_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, detectiveId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                photos.add(new Photo(rs.getInt("photo_id"), rs.getString("url")));
            }
        }

        return photos;
    }
}
