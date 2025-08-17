<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cart - PahanaEdu</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; padding: 20px; background: #f8f9fa; }
        h2 { text-align: center; }
        table { width: 100%; border-collapse: collapse; background: #fff; margin-top: 20px; }
        th, td { padding: 10px; border: 1px solid #ddd; text-align: center; }
        th { background: #3498db; color: white; }
        .total { font-weight: bold; background: #ecf0f1; }
        .print-btn { margin-top: 20px; background: #27ae60; color: white; padding: 10px; border: none; cursor: pointer; }
        .print-btn:hover { background: #219150; }
    </style>
</head>
<body>
    <h2>🛒 Your Cart</h2>
    <table>
        <tr>
            <th>Book</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Total</th>
        </tr>

        <%
            double grandTotal = 0;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahanaedu", "root", "");

                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("SELECT * FROM cart");

                while (rs.next()) {
                    double total = rs.getDouble("price") * rs.getInt("quantity");
                    grandTotal += total;
        %>
                    <tr>
                        <td><%= rs.getString("title") %></td>
                        <td>Rs. <%= rs.getDouble("price") %></td>
                        <td><%= rs.getInt("quantity") %></td>
                        <td>Rs. <%= total %></td>
                    </tr>
        <%
                }
                rs.close();
                st.close();
                con.close();
            } catch (Exception e) {
                out.println("<tr><td colspan='4' style='color:red'>Error: " + e.getMessage() + "</td></tr>");
            }
        %>
        <tr class="total">
            <td colspan="3">Grand Total</td>
            <td>Rs. <%= grandTotal %></td>
        </tr>
    </table>

    <button class="print-btn" onclick="window.print()">🖨 Print Bill</button>
</body>
</html>
