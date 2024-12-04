import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
@WebServlet("/Client_servlet")
@MultipartConfig(maxFileSize = 16177215)
public class Client_servlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String purpose = request.getParameter("purpose");
        String remark = request.getParameter("remark");
        String reference = request.getParameter("reference");
        String referenceContact = request.getParameter("referenceContact");
        String interviewed = request.getParameter("interviewed");
        String date = request.getParameter("date");
       
        Part imagePart = request.getPart("image");
        String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir(); 
        }
        String filePath = uploadPath + File.separator + fileName; 

       
        try (FileOutputStream fos = new FileOutputStream(filePath);
             InputStream inputStream = imagePart.getInputStream()) {
            byte[] buffer = new byte[1024];
            int bytesRead = 0;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                fos.write(buffer, 0, bytesRead);
            }
        }

        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskvfly", "root", "");

           
            String checkQuery = "SELECT * FROM client_history WHERE phone = ?";
            pst = con.prepareStatement(checkQuery);
            pst.setString(1, phone);
            rs = pst.executeQuery();

            if (rs.next()) {
              
                String selectRevisitQuery = "SELECT * FROM client_revisit WHERE phone = ?";
                pst = con.prepareStatement(selectRevisitQuery);
                pst.setString(1, phone);
                ResultSet revisitRs = pst.executeQuery();

                int revisitCount = 1;
                if (revisitRs.next()) {
                    revisitCount = revisitRs.getInt("revisit") + 1;

                    String updateRevisitQuery = "UPDATE client_revisit SET revisit = ?, name = ?, address = ?, purpose = ?, remark = ?, reference = ?, referenceContact = ?, interviewed = ?, date = ?, image = ? WHERE phone = ?";
                    pst = con.prepareStatement(updateRevisitQuery);
                    pst.setInt(1, revisitCount);
                    pst.setString(2, name);
                    pst.setString(3, address);
                    pst.setString(4, purpose);
                    pst.setString(5, remark);
                    pst.setString(6, reference);
                    pst.setString(7, referenceContact);
                    pst.setString(8, interviewed);
                    pst.setString(9, date);
                    pst.setString(10, "uploads/" + fileName);
                    pst.setString(11, phone);
                    pst.executeUpdate();

                } else {
                    String insertRevisitQuery = "INSERT INTO client_revisit (name, address, phone, purpose, remark, reference, referenceContact, interviewed, date, revisit, image) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    pst = con.prepareStatement(insertRevisitQuery);
                    pst.setString(1, name);
                    pst.setString(2, address);
                    pst.setString(3, phone);
                    pst.setString(4, purpose);
                    pst.setString(5, remark);
                    pst.setString(6, reference);
                    pst.setString(7, referenceContact);
                    pst.setString(8, interviewed);
                    pst.setString(9, date);
                    pst.setInt(10, revisitCount);
                    pst.setString(11, "uploads/" + fileName);
                    pst.executeUpdate();
                }

                if (rs.next()) {
                    // Data found in client history
                    response.sendRedirect("client_revisit.jsp?status=success&action=update");
                } else {
                    // New entry in client history
                    response.sendRedirect("client_revisit.jsp?status=success&action=add");
                }

            } else {
           
                String insertHistoryQuery = "INSERT INTO client_history (name, address, phone, purpose, remark, reference, referenceContact, interviewed, date, image) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                pst = con.prepareStatement(insertHistoryQuery);
                pst.setString(1, name);
                pst.setString(2, address);
                pst.setString(3, phone);
                pst.setString(4, purpose);
                pst.setString(5, remark);
                pst.setString(6, reference);
                pst.setString(7, referenceContact);
                pst.setString(8, interviewed);
                pst.setString(9, date);
                pst.setString(10, "uploads/" + fileName);
                pst.executeUpdate();
                if (rs.next()) {
                    int generatedId = rs.getInt(1);
                 
                }else if (rs.next()) {
                        // Data found in client history
                        response.sendRedirect("client_history.jsp?status=success&action=update");
                    } else {
                        // New entry in client history
                        response.sendRedirect("client_history.jsp?status=success&action=add");
                    }
        }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
