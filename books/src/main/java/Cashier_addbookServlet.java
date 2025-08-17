

import java.io.*;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/cashier_addbookServlet")
@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
                 maxFileSize=1024*1024*10,      // 10MB
                 maxRequestSize=1024*1024*50)   // 50MB
public class Cashier_addbookServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "book_images";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if("add".equalsIgnoreCase(action)) {
            addBook(request, response);
        } else if("delete".equalsIgnoreCase(action)) {
            deleteBook(request, response);
        } else if("update".equalsIgnoreCase(action)) {
            updateBook(request, response);
        }
    }

    private void addBook(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String category = request.getParameter("category");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            Part part = request.getPart("image");
            String fileName = new File(part.getSubmittedFileName()).getName();
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();
            part.write(uploadPath + File.separator + fileName);

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahanaedu","root","");
            String sql = "INSERT INTO books (title, author, category, price, quantity, image_name) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, title);
            ps.setString(2, author);
            ps.setString(3, category);
            ps.setDouble(4, price);
            ps.setInt(5, quantity);
            ps.setString(6, fileName);
            ps.executeUpdate();
            conn.close();

            response.sendRedirect("cashier_addbook.jsp");

        } catch(Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahanaedu","root","");
            String sql = "DELETE FROM books WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
            conn.close();

            response.sendRedirect("cashier_addbook.jsp");
        } catch(Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }

    private void updateBook(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String category = request.getParameter("category");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            String fileName = null;
            Part part = request.getPart("image");
            if(part != null && part.getSize() > 0) {
                fileName = new File(part.getSubmittedFileName()).getName();
                String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();
                part.write(uploadPath + File.separator + fileName);
            }

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahanaedu","root","");
            String sql;
            if(fileName != null) {
                sql = "UPDATE books SET title=?, author=?, category=?, price=?, quantity=?, image_name=? WHERE id=?";
            } else {
                sql = "UPDATE books SET title=?, author=?, category=?, price=?, quantity=? WHERE id=?";
            }
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, title);
            ps.setString(2, author);
            ps.setString(3, category);
            ps.setDouble(4, price);
            ps.setInt(5, quantity);
            if(fileName != null) {
                ps.setString(6, fileName);
                ps.setInt(7, id);
            } else {
                ps.setInt(6, id);
            }
            ps.executeUpdate();
            conn.close();

            response.sendRedirect("manage_books.jsp");

        } catch(Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
