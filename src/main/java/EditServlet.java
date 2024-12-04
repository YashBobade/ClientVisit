
import java.io.File;
import java.io.IOException;
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

@WebServlet("/EditServlet")
@MultipartConfig(maxFileSize = 16177215)
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        String id = request.getParameter("id");
	        String updatedName = request.getParameter("name");
	        String updatedAddress = request.getParameter("address");
	        String updatedPhone = request.getParameter("phone");
	        String updatedPurpose = request.getParameter("purpose");
	        String updatedRemark = request.getParameter("remark");
	        String updatedReference = request.getParameter("reference");
	        String updatedReferenceContact = request.getParameter("referenceContact");
	        String updatedInterviewedBy = request.getParameter("interviewed");
	        String updatedDate = request.getParameter("date");
	        
	        String imagePath = "";
	        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
	        File uploadDir = new File(uploadPath);
	        if (!uploadDir.exists()) {
	            uploadDir.mkdir(); 
	        }

	        Part filePart = request.getPart("image"); 
	        String fileName = (filePart != null) ? filePart.getSubmittedFileName() : null;


	        if (fileName != null && !fileName.isEmpty()) {
	            imagePath = "uploads/" + fileName;
	            filePart.write(uploadPath + File.separator + fileName);
	        } else {
	            
	            Connection con = null;
	            PreparedStatement pst = null;
	            ResultSet rs = null;

	            try {
	                Class.forName("com.mysql.jdbc.Driver");
	                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskvfly", "root", "");
	                
	                String getImageQuery = "SELECT image FROM client_history WHERE id = ?";
	                pst = con.prepareStatement(getImageQuery);
	                pst.setString(1, id);
	                rs = pst.executeQuery();
	                
	                if (rs.next()) {
	                    imagePath = rs.getString("image"); 
	                }
	            } catch (Exception e) {
	                e.printStackTrace();
	            } finally {
	                if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
	                if (pst != null) try { pst.close(); } catch (SQLException ignored) {}
	                if (con != null) try { con.close(); } catch (SQLException ignored) {}
	            }
	        }

	    
	        Connection con = null;
	        PreparedStatement pst = null;

	        try {
	            Class.forName("com.mysql.jdbc.Driver");
	            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskvfly", "root", "");

	    
	            String sqlUpdate = "UPDATE client_history SET name = ?, address = ?, phone = ?, purpose = ?, remark = ?, reference = ?, referenceContact = ?, interviewed = ?, date = ?, image = ? WHERE id = ?";
	            pst = con.prepareStatement(sqlUpdate);
	            pst.setString(1, updatedName);
	            pst.setString(2, updatedAddress);
	            pst.setString(3, updatedPhone);
	            pst.setString(4, updatedPurpose);
	            pst.setString(5, updatedRemark);
	            pst.setString(6, updatedReference);
	            pst.setString(7, updatedReferenceContact);
	            pst.setString(8, updatedInterviewedBy);
	            pst.setString(9, updatedDate);
	            pst.setString(10, imagePath);
	            pst.setString(11, id);
	      
	            int rowsUpdated = pst.executeUpdate();

	            
	            if (rowsUpdated > 0) {
	              
	                response.sendRedirect("client_history.jsp");
	            } else {
	                
	                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Client not found or data not updated.");
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while updating the client data.");
	        } finally {
	            if (pst != null) try { pst.close(); } catch (SQLException ignored) {}
	            if (con != null) try { con.close(); } catch (SQLException ignored) {}
	        }
	    }
	}