package com.example.Service;

import com.example.models.MostWanted;
import com.example.utils.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MostWantedService {

    public static List<MostWanted> getAllMostWanted() throws SQLException {
        List<MostWanted> mostWantedList = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT * FROM `most-wanted`";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                MostWanted criminal = new MostWanted();
                criminal.setId(rs.getInt("Criminal_id"));
                criminal.setName(rs.getString("Criminal_name"));
                criminal.setCharges(rs.getString("Charges"));
                criminal.setLastSeen(rs.getString("Last_seen"));
                criminal.setInfo(rs.getString("Criminal_info"));
                mostWantedList.add(criminal);
            }
        }

        return mostWantedList;
    }
}
