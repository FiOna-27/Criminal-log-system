package com.example.Service;

import com.example.models.InCustody;
import com.example.utils.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class InCustodyService {

    public static List<InCustody> getAllPrisoners() throws SQLException {
        List<InCustody> prisoners = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT * FROM `in-custody`";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                InCustody prisoner = new InCustody();
                prisoner.setId(rs.getInt("Prisioner_id"));
                prisoner.setName(rs.getString("Prisioner_name"));
                prisoner.setCharges(rs.getString("Prisioner_charges"));
                prisoner.setSentence(rs.getString("Prisioner_sentence"));
                prisoner.setInfo(rs.getString("Prisioner_info"));
                prisoner.setBehavior(rs.getString("Prisioner_behaviour"));
                prisoner.setMentalState(rs.getString("Prisioner_mentalstate"));

                prisoners.add(prisoner);
            }
        }

        return prisoners;
    }
}
