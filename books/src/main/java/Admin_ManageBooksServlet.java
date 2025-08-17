

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/ManageBooksServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class Admin_ManageBooksServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

   
    private static final String DB_URL = "jdbc:mysql://localhost:3306/pahanaedu";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            if ("add".equals(action)) {
              
                String title = request.getParameter("title");
                String author = request.getParameter("author");
                String category = request.getParameter("category");
                double price = Double.parseDouble(request.getParameter("price"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));

               
                Part filePart = request.getPart("image");
                String fileName = new File(filePart.getSubmittedFileName()).getName();

               
                String uploadPath = getServletContext().getRealPath("") + File.separator + "book_images";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();

                filePart.write(uploadPath + File.separator + fileName);

               
                String sql = "INSERT INTO books (title, author, category, price, quantity, image_name) VALUES (?, ?, ?, ?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, title);
                ps.setString(2, author);
                ps.setString(3, category);
                ps.setDouble(4, price);
                ps.setInt(5, quantity);
                ps.setString(6, fileName);
                ps.executeUpdate();

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));

               
                String selectSql = "SELECT image_name FROM books WHERE id=?";
                PreparedStatement selectPs = conn.prepareStatement(selectSql);
                selectPs.setInt(1, id);
                ResultSet rs = selectPs.executeQuery();

                if (rs.next()) {
                    String imageName = rs.getString("image_name");

                    
                    File imgFile = new File(getServletContext().getRealPath("") + File.separator + "book_images" + File.separator + imageName);
                    if (imgFile.exists()) {
                        imgFile.delete();
                    }
                }

               
                String deleteSql = "DELETE FROM books WHERE id=?";
                PreparedStatement ps = conn.prepareStatement(deleteSql);
                ps.setInt(1, id);
                ps.executeUpdate();
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

      
        response.sendRedirect("Admin_managebooks.jsp");
    }
}

